//
//  MenuGroupCell.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class MenuGroupCell: BaseCell {
    
    var texts:String! {
        didSet {
            let attributedText = NSMutableAttributedString(string: "#  ", attributes: [.foregroundColor:  #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1), .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
            attributedText.append(NSAttributedString(string: texts, attributes: [.foregroundColor: UIColor.white]))
            self.textLabel?.attributedText = attributedText
            backgroundColor = .clear
            textLabel?.textColor = .white
            textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
    
    
    let bgView:UIView = {
        let bg = UIView(backgroundColor: #colorLiteral(red: 0.3202255964, green: 0.5989795327, blue: 0.5417570472, alpha: 1))
        bg.layer.cornerRadius = 5
        return bg
    }()
    
   
    
    override func setupViews() {
        selectionStyle = .none
        
        addSubview(bgView)
        bgView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 0, right: 4) )
        sendSubviewToBack(bgView)
    }
   
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bgView.isHidden = !selected
        //        contentView.backgroundColor = selected ? .red : .yellow
    }
    
}
