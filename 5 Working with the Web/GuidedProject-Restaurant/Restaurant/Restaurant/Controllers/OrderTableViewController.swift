//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/23/21.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Observer 
        NotificationCenter.default.addObserver(tableView, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdatedNotification, object: nil)
    
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MenuController.shared.order.menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellIdentifier", for: indexPath)

        configure(cell, forItemAt: indexPath)

        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
    }
}
