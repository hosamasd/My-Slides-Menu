//
//  ChatMenuContainerVC.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class ChatMenuContainerVC: UIViewController {
    
    let chatroomsMenuController = ChatMenuGroupVC()
    
    let searchContainer = SearchContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
       
    }
    
    func setupViews()  {
        searchContainer.searchBar.delegate = chatroomsMenuController
        view.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        
        let chatroomsView = chatroomsMenuController.view!
        view.addSubViews(views: chatroomsView,searchContainer)
        searchContainer.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.1843137255, blue: 0.2470588235, alpha: 1)
        
        searchContainer.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: -64, right: 0))
        
        chatroomsView.anchor(top: searchContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
}

class SearchContainerView: UIView {
    
    let  searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.placeholder = "Enter some filer"
        return sb
    }()
    
    let rocketImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "rocket"))
        iv.contentMode = .scaleAspectFit
        iv.constrainWidth(constant: 44)
        iv.constrainHeight(constant: 44)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white //for make text inside search white as color
        
        addSubViews(views: searchBar,rocketImageView)
        
        rocketImageView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 0))
        
        searchBar.anchor(top: nil, leading: rocketImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}


