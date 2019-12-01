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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .default, reuseIdentifier: cellID)
    
        cell.textLabel?.text = "hello in \(indexPath.row)"
        return cell
    }
    
    func setupTableView()  {
        tableView.backgroundColor = .orange
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
}
