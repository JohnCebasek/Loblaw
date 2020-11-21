//
//  ViewController.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask(with: NSURL(string:link)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

class SwiftNewsMainViewController: UITableViewController  {

    private var dataManager = SwiftNewsManager()
    private let cellIdentifier = "NewsItemCell"
    private let sectionCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataManager.loadUpJSON {        // URLSession downloads stuff on a background thread, so when the download is finished, kick reloading back onto the main thread (where it belongs)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    // MARK: - Navigation
    
    // sender is the UItableViewCell that the user has tapped or the accessory button has been tapped
    // Ask the tableview for the indexpath
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let nextViewController = segue.destination as? SwiftNewsDetailViewController {
            var newsItem: SwiftNewsDataItem
            
            guard let indexPath = self.tableView.indexPath(for: sender as! SwiftNewsTableViewCell) else {
                return
            }

            newsItem = dataManager.item(at: indexPath.row)
            nextViewController.title = newsItem.newsTitle
            nextViewController.swiftNewsData = newsItem
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.numberOfItems
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SwiftNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SwiftNewsTableViewCell
        let item = dataManager.item(at: indexPath.row)
        cell.config(with: item)
        
        return cell
    }
}

