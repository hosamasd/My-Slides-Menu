//
//  TweetCell.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class TweetCell: UICollectionViewCell {
    
    var tweet:TweetModel! {
        didSet{
            let attributedText = NSMutableAttributedString(string: tweet.name, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
            
            let usernameString = "  \(tweet.email)\n"
            attributedText.append(NSAttributedString(string: usernameString, attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.gray]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            let range = NSMakeRange(0, attributedText.string.count)
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
            
            attributedText.append(NSAttributedString(string: tweet.bio, attributes: [.font: UIFont.systemFont(ofSize: 15)]))
            
            messageTextView.attributedText = attributedText
           
            userImageView.image = tweet.image
         }
    }
    
    let userImageView:UIImageView = {
        let im = UIImageView(backgroundColor: .gray)
        im.constrainWidth(constant: 80)
        im.constrainHeight(constant: 80)
        im.contentMode = .scaleAspectFit
        im.layer.cornerRadius = 40
        im.clipsToBounds = true
        return im
    }()
    
    let messageTextView: UITextView = {
        let tv = UITextView()
        tv.text = "SOME SAMPLE TEXT"
        tv.backgroundColor = .clear
        tv.isUserInteractionEnabled = false
        return tv
    }()
  
    let replyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "reply").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let directMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send_message").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let seperatorView:UIView = {
        let vi = UIView(backgroundColor: UIColor(white: 0, alpha: 0.5))
        vi.constrainHeight(constant: 0.5)
        
        return vi
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .white
      let first =   stack(userImageView,UIView())
       let ss =  hstack(replyButton,retweetButton,likeButton,directMessageButton, spacing: 0, distribution: .fillEqually)
        
       let xx =  stack(messageTextView,ss, spacing: 8)
        hstack(first,xx, spacing: 8)
        
//        addSubViews(views: userImageView,messageTextView)
////        addSubview( seperatorView)
////        addSubview(userImageView)
////        addSubview(messageTextView)
//
//        userImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 8, left: 8, bottom: 0, right: 0))
//        messageTextView.anchor(top: topAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor)
//        setupBottomButtons()
    }
    
    fileprivate func setupBottomButtons() {
        let replyButtonContainerView = UIView()
        
        let retweetButtonContainerView = UIView()
        
        let likeButtonContainerView = UIView()
        
        let directMessageButtonContainerView = UIView()
        
        let buttonStackView = verticalStackView(arragedSubViews: replyButtonContainerView, retweetButtonContainerView, likeButtonContainerView, directMessageButtonContainerView, spacing: 0, distribution: .fillEqually, axis: .horizontal)
        //        let buttonStackView = UIStackView(arrangedSubviews: )
        //        buttonStackView.axis = .horizontal
        //        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: messageTextView.bottomAnchor, leading: userImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 0, bottom: 8, right: 0),size: .init(width: 0, height: 20))
        
        addSubViews(views: replyButton,retweetButton,likeButton,directMessageButton)
//        addSubview(replyButton)
//        addSubview(retweetButton)
//        addSubview(likeButton)
//        addSubview(directMessageButton)
        
        replyButton.anchor(top: replyButtonContainerView.topAnchor, leading: replyButtonContainerView.leadingAnchor, bottom: nil, trailing: nil)
        retweetButton.anchor(top: retweetButtonContainerView.topAnchor, leading: retweetButtonContainerView.leadingAnchor, bottom: nil, trailing: nil)
        likeButton.anchor(top: likeButtonContainerView.topAnchor, leading: likeButtonContainerView.leadingAnchor, bottom: nil, trailing: nil)
        directMessageButton.anchor(top: directMessageButtonContainerView.topAnchor, leading: directMessageButtonContainerView.leadingAnchor, bottom: nil, trailing: nil)
    }
}
