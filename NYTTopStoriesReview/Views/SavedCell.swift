//
//  SavedCell.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/8/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class SavedCell: UICollectionViewCell {
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
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
        configureTitle()
    }
    
    private func configureTitle() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
