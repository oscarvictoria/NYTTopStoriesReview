//
//  ArticleDetailView.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/7/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit


class ArticleDetailView: UIView {
    
    public lazy var abstractHeadline: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.text = "Abstract HeadLine"
        return label
    }()
    
    public lazy var newsImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configureImageView()
        configureAbstractHeadLine()
    }
    
    
    private func configureImageView() {
         addSubview(newsImageView)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func configureAbstractHeadLine() {
        addSubview(abstractHeadline)
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractHeadline.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abstractHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    
}


