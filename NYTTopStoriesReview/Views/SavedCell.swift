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
    
    public lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    public var currentArticle: Article!
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    public lazy var newImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.image = UIImage(systemName: "photo")
        iv.alpha = 0
        iv.clipsToBounds = true
        return iv
    }()
    
    private var isShowingImage = false
    
    
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
        addGestureRecognizer(longPressGesture)
        setUpImageViewController()
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let currentArticle = currentArticle else {return}
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        
        isShowingImage.toggle()
        newImageView.getImage(with: currentArticle.getArticleImageURL(for: .normal)) { (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.newImageView.image = image
                    self.animate()
                }
            }
        }
    }
    
    private func animate() {
        let duration: Double = 1.0
        if isShowingImage {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.newImageView.alpha = 1.0
                self.articleTitle.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.newImageView.alpha = 0.0
                self.articleTitle.alpha = 1.0
            }, completion: nil)
        }
        
    }
        @objc private func moreButtonPressed(_ sender: UIButton) {
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
                moreButton.heightAnchor.constraint(equalToConstant: 32),
                moreButton.widthAnchor.constraint(equalTo:  moreButton.heightAnchor)
            ])
        }
        
        private func setUpImageViewController() {
            addSubview(newImageView)
            newImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                newImageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
                newImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                newImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                newImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        public func configureCell(for savedArticle: Article) {
            currentArticle = savedArticle
            articleTitle.text = savedArticle.title
        }
}
