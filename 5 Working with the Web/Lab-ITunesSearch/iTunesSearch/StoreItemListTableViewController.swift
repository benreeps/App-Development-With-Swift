
import UIKit

class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    // add item controller property
    let storeItemController = StoreItemController()
    let queryOptions = ["movie", "music", "software", "ebook"]
    var items = [StoreItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            
            // set up query dictionary
            let query: [String: String] = ["term": searchTerm, "media": mediaType, "limit": "10"]
            
            // use the item controller to fetch items
            storeItemController.fetchItems(matching: query) { (items) in
                
                DispatchQueue.main.async {
                    if let items = items {
                        self.items = items
                        self.tableView.reloadData()
                    } else {
                        print("Data did not load.")
                    }
                }
            }
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        // set label to the item's name
        cell.textLabel?.text = item.name
        // set detail label to the item's subtitle
        cell.detailTextLabel?.text = item.artist
        // reset the image view to the gray image
        cell.imageView?.image = UIImage(named: "gray")
        
        storeItemController.fetchItemArtwork(url: item.artworkURL) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }
        
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
