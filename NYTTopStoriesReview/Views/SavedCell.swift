//
//  SavedCell.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/8/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

protocol SavedArticleCellDelagate: AnyObject {
    func didSelectMoreButton(_ SavedArticleCell: SavedCell, article: Article)
}

class SavedCell: UICollectionViewCell {
    
    weak var delegate: SavedArticleCellDelagate?
    
    public var currentArticle: Article!
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
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
        configureButton()
        configureTitle()
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
//        print("button pressed")
        delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    private func configureTitle() {
        addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 30),
            moreButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    public func configureCell(for savedArticle: Article) {
    currentArticle = savedArticle
    articleTitle.text = savedArticle.title
}
    
}
