//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Benjamin Reeps on 1/23/21.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var menuItem: MenuItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToOrderButton.layer.cornerRadius = 5.0
        updateUI()
    }
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        guard let menuItem = menuItem else {return}
        
        UIView.animate(withDuration: 0.3) {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        MenuController.shared.order.menuItems.append(menuItem)
    }
    
    func updateUI() {
        guard let menuItem = menuItem else {return}
        
        titleLabel.text = menuItem.name
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        detailTextLabel.text = menuItem.detailText
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image 
            }
        }
    }
    //MARK:- Preserving View Controller State
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        guard let menuItem = menuItem else {return}
        coder.encode(menuItem.id, forKey: "menuItemId")
    }
    
    //MARK:- Restoring the View Controller State
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        let menuItemID = Int(coder.decodeInt32(forKey: "menuItemId"))
        menuItem = MenuController.shared.item(withID: menuItemID)!
        updateUI()
    }
}
