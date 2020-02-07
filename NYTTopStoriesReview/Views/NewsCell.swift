//
//  NewsCell.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/7/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Abstract HeadLine"
        return label
    }()
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article Headline"
        return label
    }()
    
    public lazy var newsImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .yellow
        image.contentMode = .scaleToFill
        return image
    }()
     
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
         super.init(coder: coder)
         commonInit()
     }
    
    private func commonInit() {
        configureImageConstraints()
        configureArticleTitleConstraints()
        configureAbstractHeadlineConstraints()
    }
    
    private func configureImageConstraints() {
        addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor)
        ])
    }
    
    private func configureArticleTitleConstraints() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: newsImageView.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func configureAbstractHeadlineConstraints() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractHeadline.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstractHeadline.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor),
            abstractHeadline.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8)
        ])
    }
}
