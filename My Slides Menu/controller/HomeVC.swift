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
    lazy var menuVC: MenuVC = {
    let v = MenuVC()
        v.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(v.view)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupNavigation()
        setupGesture()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
    
    func setupTableView()  {
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    func setupGesture()  {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePaneed))
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
            self.view.transform = transform
//            self.navigationController?.view.transform = transform
        }, completion: nil)
    }
    
  @objc  func handlePaneed(gesture:UIPanGestureRecognizer)  {
        let translation = gesture.translation(in: view)
        print(translation)
    if gesture.state == .changed {
        var x = translation.x
        x = min(menuWidth, x)
        x = max(0, x)
        
        let transform = CGAffineTransform(translationX: x    , y:    0)
        
        menuVC.view.transform = transform
        self.navigationController?.view.transform = transform
    }else if gesture.state == .ended {
        handleShow()
    }
    }
    
    @objc  func handleShow()  {
        
        //animation
       performAnimations(transform: .init(translationX: self.menuWidth, y: 0))
        
        addChild(menuVC)
    }
    
    @objc  func handleHide()  {
        performAnimations(transform: .identity)
    }
}

