//
//  MenuVC.swift
//  My Slides Menu
//
//  Created by hosam on 12/1/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    
     fileprivate let cellID = "cellID"
    let menuItems = [
        MenuModel(icon: #imageLiteral(resourceName: "profile"), title: "Profile"),
        MenuModel(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
        MenuModel(icon: #imageLiteral(resourceName: "bookmarks"), title: "Bookmarks"),
        MenuModel(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        setupGesture()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let custom = CustomHeaderView()
        
        return custom
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseSlid = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingVC
        baseSlid?.didSelectItemAtIndex(index: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MenuCell
    
        let model = menuItems[indexPath.row]
        
        cell.model = model
        return cell
    }
    
    func setupTableView()  {
        tableView.backgroundColor = .white
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    
    
//    func setupGesture()  {
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePaneed))
//        pan.delegate = self
//        view.addGestureRecognizer(pan)
//    }
}

//extension HomeVC: UIGestureRecognizerDelegate {
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
//
//}
