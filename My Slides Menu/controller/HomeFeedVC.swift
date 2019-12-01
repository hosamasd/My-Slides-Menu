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
  
    TweetModel(name: "hosam", email: "@hosam", bio: "en adding a collection view to your user interface, your app’s main job is to manage the data associated with that collection view. The collection view gets its data from the data source object, which is an object that conforms t", image: #imageLiteral(resourceName: "pict")),
    TweetModel(name: "hosam", email: "@hosam", bio: "rresponds to the cell type you want. That method always returns a valid cell object. Upon receiving the cell, you should set any properties that correspond to the data of the corresponding item, perform any additional needed configuration, and return the cell You  not need to set the location of the cell inside the collection view’s bounds. The collection view sets the location of each cell automatically using the layout attributes provided by its layout object.If isPrefetchingEnabled on the collection view is set to true then this method is called in advance of th", image: #imageLiteral(resourceName: "girl_profile")),
    TweetModel(name: "hosam", email: "@hosam", bio: "s too. These supplementary views can be things like section headers and footers that are separate from the individual cells but still convey some sort of information. Support for supplementary views is optional and defined by the collection view’s layout object, which is also responsible for defining the placement of those views.", image: #imageLiteral(resourceName: "pict")),
      TweetModel(name: "hosam", email: "@hosam", bio: "en adding a collection view to your use an object that conforms t", image: #imageLiteral(resourceName: "girl_profile")),
    
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
//        estimatedCellSize.tweet = tweet
//        estimatedCellSize.messageTextView.text = tweet.bio
        let height = tweet.bio.getFrameForText(text: tweet.bio)

        estimatedCellSize.messageTextView.constrainHeight(constant: height.height )
        estimatedCellSize.layoutIfNeeded()
        
        let estimatedHeight = estimatedCellSize.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        print(estimatedHeight.height)
        return .init(width: view.frame.width, height: estimatedHeight.height  + 10 )
    }
    
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
        
//        let barButtonItem = UIBarButtonItem(customView: circularButton)
//
//        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func handleSearch()  {
        print(564)
    }
    
    @objc func handleFeed()  {
        print(695)
    }
    
    @objc func handleUserProfile()  {
        print(023)
    }
    
    @objc func handleShow() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
    }
    
    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.closeMenu()
    }
}

