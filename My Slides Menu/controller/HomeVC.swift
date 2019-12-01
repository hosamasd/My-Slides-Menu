//
//  HomeVC.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//


import UIKit

class HomeVC: UITableViewController {
    
    fileprivate let cellID = "cellID"
    fileprivate let menuWidth:CGFloat  = 300
    fileprivate let velocityOpenThreshold:CGFloat  = 500
    fileprivate var isMenuOpen:Bool = false
    lazy var menuVC: MenuVC = {
    let v = MenuVC()
        v.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(v.view)
        addChild(v)
        return v
    }()
    let darkShadowView:UIView = {
       let v = UIView(backgroundColor: UIColor(white: 0, alpha: 0.8))
        v.isUserInteractionEnabled = false
        v.alpha = 0
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupNavigation()
//        setupGesture()
        setupDarkShadow()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        cell.textLabel?.text = "Item: \(indexPath.row)"
        //        cell.backgroundColor = .orange
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func setupDarkShadow()  {
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(darkShadowView)
        darkShadowView.frame = mainWindow?.frame ?? .zero
        
    }
    
    func setupTableView()  {
        tableView.backgroundColor = .red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
//        tableView.tableFooterView = UIView()
    }
    
    func setupGesture()  {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePaneed))
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    func setupNavigation()  {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Show", style: .plain, target: self, action: #selector(handleShow))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    func performAnimations(transform: CGAffineTransform)  {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.menuVC.view.transform = transform
//            self.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkShadowView.transform = transform
            
            self.darkShadowView.alpha = transform == .identity ? 0 : 1
        }, completion: nil)
    }
    
  @objc  func handlePaneed(gesture:UIPanGestureRecognizer)  {
        let translation = gesture.translation(in: view)
   
    if gesture.state == .changed {
        var x = translation.x
        
        if isMenuOpen {
            x += menuWidth
        }
        
        x = min(menuWidth, x)
        x = max(0, x)
        
        let transform = CGAffineTransform(translationX: x    , y:    0)
        
        menuVC.view.transform = transform
        self.navigationController?.view.transform = transform
        self.darkShadowView.transform = transform
        
        let alpha = x / menuWidth
        self.darkShadowView.alpha = alpha
        
    }else if gesture.state == .ended {
       handleEnded(gesture: gesture)
       
    }
    }
    
    func handleEnded(gesture:UIPanGestureRecognizer)  {
     let translation = gesture.translation(in: view)
     let velocity = gesture.velocity(in: view)
        
        if isMenuOpen {
            if abs(velocity.x) > velocityOpenThreshold {
                handleHide(); return
            }
            
            abs(translation.x) < menuWidth / 2 ? handleShow() : handleHide()
            
            
        }else {
            if abs(velocity.x) > velocityOpenThreshold {
                handleShow(); return
            }
            
             translation.x < menuWidth / 2 ?  handleHide() :  handleShow()
        }
        
    
        
    }
    
    @objc func handleShow() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.openMenu()
    }
    
    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC)?.closeMenu()
    }
    
}

extension HomeVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
