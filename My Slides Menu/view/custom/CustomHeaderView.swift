//
//  CustomHeaderView.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class CustomHeaderView: UIView {
    
    let mainImage:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "pict"))
        im.constrainWidth(constant: 48)
        im.constrainHeight(constant: 48)
        im.layer.cornerRadius = 48 / 2
        
        im.clipsToBounds = true
        return im
    }()
    let labelName =   UILabel(text: "hosam mohamed", font: .boldSystemFont(ofSize: 18),numberOfLines: 0)
    let labelEmail = UILabel(text: "@hosam mohamed", font: .systemFont(ofSize: 16),numberOfLines: 0)
    let labelFollowers:UILabel = {
        
        let statsLabel = UILabel()
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        
        statsLabel.attributedText = attributedText
        return statsLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        setupViews()
    }
    
    func setupViews()  {
        backgroundColor = .white
        
        stack( stack(hstack(mainImage,UIView()),labelName,labelEmail),labelFollowers, spacing: 16).withMargins(.init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
