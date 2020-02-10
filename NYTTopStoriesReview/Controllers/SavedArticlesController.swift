//
//  SavedArticlesController.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticlesController: UIViewController {
    
    // Step 2: we are not creating a new instace meaning we are not using " = "
    public var dataPersistance: DataPersistence<Article>!
    
    var savedArticlesView = SavedArticlesView()
    
    
    override func loadView() {
        view = savedArticlesView
    }
    
    private var savedArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.savedArticlesView.collectionView.reloadData()
            }
            if savedArticles.isEmpty {
                // set up pur empty view here
                savedArticlesView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles.")
            } else {
                savedArticlesView.collectionView.backgroundView = nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //        navigationController?.title = "Saved Articles"
        fetchSavedArticles()
        savedArticlesView.collectionView.dataSource = self
        savedArticlesView.collectionView.delegate = self
        savedArticlesView.collectionView.register(SavedCell.self, forCellWithReuseIdentifier: "savedCell")
        
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistance.loadItems().reversed()
        } catch {
            print("error could not get articles \(error)")
        }
    }
}

extension SavedArticlesController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
}

extension SavedArticlesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as? SavedCell else  {
            fatalError("could not get cell")
        }
        cell.delegate = self
        let article = savedArticles[indexPath.row]
        cell.currentArticle = article
        cell.backgroundColor = .tertiarySystemBackground
        
        cell.articleTitle.text = article.title
        return cell
    }
    
}

extension SavedArticlesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let padding: CGFloat =  15
        //        let collectionViewSize = collectionView.frame.size.width - padding
        //
        //        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight: CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articles = savedArticles[indexPath.row]
        let detailVC = ArticleDetailViewController()
        detailVC.articles = articles
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension SavedArticlesController: SavedArticleCellDelagate {
    func didSelectMoreButton(_ SavedArticleCell: SavedCell, article: Article) {
        print("did select more button")
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)  { alertAction in
            self.deleteArticle(article)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
        
    }
    
    private func deleteArticle(_ article: Article) {
        guard let index = savedArticles.firstIndex(of: article) else {
            return
        }
        
        do {
            try dataPersistance.deleteItem(at: index)
        } catch {
            print("error")
        }
    }
    
}




