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
    public var dataPersistance: DataPersistence<Article>!
    
    var detailView = ArticleDetailView()
    
    override func loadView() {
        view = detailView
    }
    
    var articles: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . systemGray4
        updateUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(save))
    }
    
    func updateUI() {
        guard let article = articles else {
            fatalError("did not load an article")
        }
        detailView.abstractHeadline.text = article.abstract
        detailView.newsImageView.getImage(with: article.getArticleImageURL(for: .superJumbo)) { (result) in
            switch result {
            case .failure(let error):
                print("app error \(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.detailView.newsImageView.image = image
                }
            }
        }
        navigationItem.title = article.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func save() {
        guard let article = articles else {
            print("some error")
            return
        }
        // Step 5: Save to documents directory
        do {
           try dataPersistance.createItem(article)
        } catch {
            print("error saving article \(error)")
        }
    }



}
