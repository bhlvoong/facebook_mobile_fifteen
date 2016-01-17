//
//  ViewController.swift
//  FacebookMobileFifteen
//
//  Created by Brian Voong on 1/16/16.
//  Copyright © 2016 mobilefifteen. All rights reserved.
//

import UIKit

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "News Feed"
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        registerCells()
    }
    
    let feedCellId = "feedCellId"
    let items = ["Mark Zuckerberg", "Bill Gates", "Steve Jobs"]
    
    func registerCells() {
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCellWithReuseIdentifier(feedCellId, forIndexPath: indexPath) as! FeedCell
        return feedCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 400)
    }
    
}

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        let attributedText = NSMutableAttributedString(string: "Mark Zuckerberg\n", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)])
        attributedText.appendAttributedString(NSAttributedString(string: "December 18 • San Francisco • ", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.lightGrayColor()]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRectMake(0, -2, 12, 12)
        attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "zuckprofile")
        return imageView
    }()
    
    let bodyTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Meanwhile, ", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)])
        attributedText.appendAttributedString(NSAttributedString(string: "Beast ", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)]))
        attributedText.appendAttributedString(NSAttributedString(string: "turned to the dark side.", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)]))
        textView.attributedText = attributedText
        textView.scrollEnabled = false
        return textView
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckdog")
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let numLikesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488K Likes  10.7K Comments"
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.lightGrayColor()
        return label
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_down"), forState: .Normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(16, 18, 16, 18)
        return button
    }()
    
    let likeButton = FeedCell.buttonWithImageName("thumbs_up", title: "Like")
    let commentButton = FeedCell.buttonWithImageName("comment", title: "Comment")
    let shareButton = FeedCell.buttonWithImageName("share", title: "Share")
    
    let likeCommentShareContainerView = UIView()
    
    static func buttonWithImageName(name: String, title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(12)
        button.setTitleColor(UIColor.rgb(159, green: 158, blue: 164, alpha: 1), forState: .Normal)
        button.setImage(UIImage(named: name), forState: .Normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 2, 0)
        return button
    }
    
    let horizontalDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(241, green: 241, blue: 243, alpha: 1)
        return view
    }()
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(bodyTextView)
        addSubview(postImageView)
        addSubview(numLikesCommentsLabel)
        addSubview(horizontalDividerView)
        addSubview(likeCommentShareContainerView)
        
        likeCommentShareContainerView.addSubview(likeButton)
        likeCommentShareContainerView.addSubview(commentButton)
        likeCommentShareContainerView.addSubview(shareButton)
        
        addSubview(arrowButton)
        
        addConstraintsWithFormat("V:|-8-[v0(40)][v1(24)]-8-[v2]-8-[v3(20)]-8-[v4(1)]-2-[v5(28)]-16-|", views: profileImageView, bodyTextView, postImageView, numLikesCommentsLabel, horizontalDividerView, likeCommentShareContainerView)
        
        addConstraintsWithFormat("H:|-8-[v0(40)]-8-[v1]-8-[v2(50)]|", views: profileImageView, nameLabel, arrowButton)
        
        addConstraintsWithFormat("V:|-4-[v0(40)]", views: arrowButton)
        
        addConstraintsWithFormat("V:|-10-[v0]", views: nameLabel)
        
        addConstraintsWithFormat("H:|-2-[v0]|", views: bodyTextView)
        addConstraintsWithFormat("H:|[v0]|", views: postImageView)
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: numLikesCommentsLabel)
        addConstraintsWithFormat("H:|-10-[v0]-10-|", views: horizontalDividerView)
        
        addConstraintsWithFormat("H:|[v0]|", views: likeCommentShareContainerView)
        
        likeCommentShareContainerView.addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)

        likeCommentShareContainerView.addConstraintsWithFormat("V:[v0]|", views: likeButton)
        likeCommentShareContainerView.addConstraintsWithFormat("V:[v0]|", views: commentButton)
        likeCommentShareContainerView.addConstraintsWithFormat("V:[v0]|", views: shareButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: AnyObject]()
        for (index, view) in views.enumerate() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}