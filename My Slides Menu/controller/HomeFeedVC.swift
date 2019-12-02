//
//  HomeFeedVC.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class HomeFeedVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    let headerID = "headerID"
    
    var tweetsArray = [
        TweetModel(name: "hosam", email: "@hosam", bio: "en adding a collection view to your use an object that conforms t", image: #imageLiteral(resourceName: "girl_profile")),
        TweetModel(name: "hosam", email: "@hosam", bio: "en adding a collection view to your use an object that conforms t", image: #imageLiteral(resourceName: "girl_profile")),
        TweetModel(name: "hosam", email: "@hosam", bio: "s too. These supplementary views can be things like section headers and footers that are separate from the individual cells /n but still convey some sort of information. Ss.", image: #imageLiteral(resourceName: "pict")),
        TweetModel(name: "hosam", email: "@hosam", bio: "en adding a collection view toject, which is an object that conforms t", image: #imageLiteral(resourceName: "pict")),
        TweetModel(name: "hosam", email: "@hosam", bio: "rresponds to the cell type you want. That method always returns a valid cell object. Upon receiving the cell, you should set any properties that correspond to the data of the corresponding item, perform any additional needed configuration, ", image: #imageLiteral(resourceName: "girl_profile")),
       
        
        TweetModel(name: "hosam", email: "@hosam", bio: "en adding a collection view to your use an object that conforms t /n en adding a collection view to your use an object that conforms t ", image: #imageLiteral(resourceName: "girl_profile")),
        
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupNavigation()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TweetCell
        let tweet = tweetsArray[indexPath.item]
        
        cell.tweet = tweet
        return cell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let estimatedCellSize = TweetCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10000))
        let tweet = tweetsArray[indexPath.item]
        let height = tweet.bio.getFrameForText(text: tweet.bio)
        
        estimatedCellSize.messageTextView.constrainHeight(constant: height.height + 10)
        estimatedCellSize.layoutIfNeeded()
        //
        let estimatedHeight = estimatedCellSize.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        return .init(width: view.frame.width, height: estimatedHeight.height   )
    }
    
    //MARK: -user methods
    
    func setupCollection()  {
        collectionView.contentInset.top = 16
        collectionView.backgroundColor = .white
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    
    
    func setupNavigation()  {
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
        
        let image = #imageLiteral(resourceName: "girl_profile").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleShow), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        
        
        customView.constrainWidth(constant: 40)
        customView.constrainHeight(constant: 40)
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
     //TODO: -handle methods
    
    @objc func handleShow() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
    }
    
    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.closeMenu()
    }
}

