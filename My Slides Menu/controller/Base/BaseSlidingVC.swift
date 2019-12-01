//
//  BaseSlidingVC.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class BaseSlidingVC: UIViewController {
    
     fileprivate let velocityThreshold: CGFloat = 500
    fileprivate let menuWidth:CGFloat = 300
     fileprivate var isMenuOpen:Bool = false
    var redViewTrailingConstraint: NSLayoutConstraint!
     var redViewLeadingConstarint:NSLayoutConstraint!
    
    let redView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let blueView:UIView = {
        let v = UIView(backgroundColor: .blue)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//     var rightViewController: UIViewController = UINavigationController(rootViewController: HomeVC())
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeFeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
         setupGesture()
        setupViewControllers()
        
        darkCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpen ? .lightContent : .default
    }
    
    func setupViews()  {
        view.backgroundColor = .white
        view.addSubViews(views: redView,blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        self.redViewLeadingConstarint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        //        redViewLeadingConstraint.constant = 150
        redViewLeadingConstarint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
        
        
    }
    
    func setupGesture()  {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePaneed))
//        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    func setupViewControllers()  {
        let homeView = rightViewController.view!
        
//        let menuVC = MenuVC()
         let menuVC = ChatMenuContainerVC()
        let menuView = menuVC.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
         redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        
        homeView.fillSuperview()
        menuView.fillSuperview()
        darkCoverView.fillSuperview()
        
        addChild(rightViewController)
        addChild(menuVC)
    }
    
  @objc  func handlePaneed(gesture:UIPanGestureRecognizer)  {
        let transltaion = gesture.translation(in: view)
    var x = transltaion.x
    x = isMenuOpen ? x+menuWidth : x
    x = min(menuWidth, x)
    x = max(0, x)
        redViewLeadingConstarint.constant = x
    darkCoverView.alpha = x / menuWidth
    if gesture.state == .ended {
        handleEnded(gesture: gesture)
    }
    }
    
    func handleEnded(gesture:UIPanGestureRecognizer)  {
        let translate = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        // Cleaning up this section of code to solve for Lesson #10 Challenge of velocity and darkCoverView
        if isMenuOpen {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translate.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translate.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
        
    }
    
    func didSelectItemAtIndex(index:IndexPath)  {
        
       
        
//        performRightViewCleanUp()
        closeMenu()

        switch index.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeVC())
        case 1:
            rightViewController = UINavigationController(rootViewController: ListVC())
        case 2:
            rightViewController = BookmarkVC()
        default:

            let tabBarController = UITabBarController()
            let momentsController = UIViewController()
            momentsController.navigationItem.title = "Moments"
            momentsController.view.backgroundColor = .orange
            let navController = UINavigationController(rootViewController: momentsController)
            navController.tabBarItem.title = "Moments"
            tabBarController.viewControllers = [navController]
            rightViewController = tabBarController
        }
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        redView.bringSubviewToFront(darkCoverView)
        
    }
    
    func performRightViewCleanUp()  {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpen ? 1 : 0
        })
    }
    
    func closeMenu() {
        redViewLeadingConstarint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpen = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func openMenu() {
        isMenuOpen = true
        redViewLeadingConstarint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate() // for indicate system to any changes in status bar
    }
    
    
    @objc func handleTapped()  {
        closeMenu()
    }
}
