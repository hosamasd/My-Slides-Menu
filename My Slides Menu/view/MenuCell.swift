//
//  MenuCell.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class MenuCell: UITableViewCell {
    
    var model:MenuModel? {
        didSet{
            mainImage.image = model?.icon
            labelTitle.text = model?.title
        }
    }
    
    let mainImage:UIImageView = {
        let im = UIImageView(image: #imageLiteral(resourceName: "bookmarks"))
        im.layer.cornerRadius = 48 / 2
        im.constrainWidth(constant: 48)
        im.clipsToBounds = true
        return im
    }()
    let labelTitle:UILabel = {
        let la = UILabel(text: "homepage", font: .boldSystemFont(ofSize: 18),numberOfLines:0)
        
        return la
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews()  {
        backgroundColor = .white
        hstack(mainImage,labelTitle, spacing: 12).withMargins(.init(top: 8, left: 12, bottom: 8, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
