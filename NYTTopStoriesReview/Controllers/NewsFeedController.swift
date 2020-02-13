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
    private var dataPersistance: DataPersistence<Article>
    
    private var refreshControl: UIRefreshControl!
    
    var newsFeedView = NewsFeedView()
    
    var newsCell = NewsCell()
    
    var sections = "" {
        didSet {
        }
    }
    
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        newsFeedView.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchStories), for: .valueChanged)
    }
    
    
    var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
            }
        }
    }
    
    init(_ dataPersistance: DataPersistence<Article>) {
        self.dataPersistance = dataPersistance
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = newsFeedView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Top Stories"
        newsFeedView.collectionView.dataSource = self
        newsFeedView.collectionView.delegate = self
        newsFeedView.searchBar.delegate = self
//        newsFeedView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "articleCell")
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchStories()
    }
    
    
    @objc func fetchStories() {
        if let sectionName = UserDefaults.standard.object(forKey: AppKey.sectionName) as? String {
            if sectionName != self.sections {
                self.sections = sectionName
                queryAPI(for: sectionName)
            } else {
                queryAPI(for: sectionName)
            }
        } else {
            queryAPI(for: sections)
        }
        
        
    }
    
    private func queryAPI(for section: String) {
        TopStoriesAPIClient.getStories(for: section) { (result) in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let article):
                self.newsArticles = article
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
        let detailVC = ArticleDetailViewController(dataPersistance, article: articles)
        // Step 4: Pass information
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if newsFeedView.searchBar.isFirstResponder {
            newsFeedView.searchBar.resignFirstResponder()
        }
    }
}

extension NewsFeedController: SectionsDelegate {
    func setSectionName(_ section: String) {
        self.sections = section
    }
}

extension NewsFeedController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            fetchStories()
            return
        }
        // filter articel based on searchText
        newsArticles = newsArticles.filter { $0.title.lowercased().contains(searchText.lowercased())}
    }
}
