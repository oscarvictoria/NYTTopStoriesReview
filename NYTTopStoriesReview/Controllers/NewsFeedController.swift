//
//  NewsFeedController.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedController: UIViewController {
    
    // Step 2: we are not creating a new instace meaning we are not using " = "
    public var dataPersistance: DataPersistence<Article>!
    
    var newsFeedView = NewsFeedView()
        
    var newsCell = NewsCell()
    
    var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
            }
        }
    }

    
    override func loadView() {
        view = newsFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
//        navigationController?.title = "Top Stories"
        newsFeedView.collectionView.dataSource = self
        newsFeedView.collectionView.delegate = self
        newsFeedView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "articleCell")
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        fetchStories()
        
    }
    
    func fetchStories(for section: String = "Technology") {
        TopStoriesAPIClient.getStories(for: section) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let article):
                self.newsArticles = article
                print(article.count)
            }
        }
    }
    
}

extension NewsFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? NewsCell else {
            fatalError("could not get cell")
        }
        let article = newsArticles[indexPath.row]
        cell.configureCell(with: article)
        cell.backgroundColor = .systemBackground
        return cell
    }
}

extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let articles = newsArticles[indexPath.row]
        let detailVC = ArticleDetailViewController()
        detailVC.articles = articles
        // Step 4: Pass information
        detailVC.dataPersistance = dataPersistance
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
