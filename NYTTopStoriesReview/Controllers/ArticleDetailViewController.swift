//
//  ArticleDetailViewController.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/7/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class ArticleDetailViewController: UIViewController {
    
    // we are not creating a new instace meaning we are not using " = "
    private var dataPersistance: DataPersistence<Article>
    
    private var articles: Article
    
    var detailView = ArticleDetailView()
    
    init(_ dataPersistance: DataPersistence<Article>, article: Article) {
        self.dataPersistance = dataPersistance
        self.articles = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . systemGray4
        updateUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(save))
    }
    
    func updateUI() {
        detailView.abstractHeadline.text = articles.abstract
        detailView.newsImageView.getImage(with: articles.getArticleImageURL(for: .superJumbo)) { (result) in
            switch result {
            case .failure(let error):
                print("app error \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.detailView.newsImageView.image = image
                }
            }
        }
        navigationItem.title = articles.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func save() {
        // Step 5: Save to documents directory
        do {
           try dataPersistance.createItem(articles)
        } catch {
            print("error saving article \(error)")
        }
    }



}
