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
            print("there are \(savedArticles.count) articles saved")
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
        print("item was saved")
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
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
        let article = savedArticles[indexPath.row]
        cell.backgroundColor = .tertiarySystemBackground
        cell.articleTitle.text = article.title
        return cell
    }
    
}

extension SavedArticlesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  15
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articles = savedArticles[indexPath.row]
        let detailVC = ArticleDetailViewController()
        detailVC.articles = articles
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
