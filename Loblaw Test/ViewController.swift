//
//  ViewController.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import UIKit

class ViewController: UITableViewController  {

    private var dataManager = SwiftNewsManager()
    private let cellIdentifier = "NewsItemCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Navigation
    
    // sender is the UItableViewCell that the user has tapped or the accessory button has been tapped
    // Ask the tableview for the indexpath
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let nextViewController = segue.destination as? SwiftNewsDetailViewController {
            var newsItem: SwiftNewsDataItem
            
            guard let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) else {
                return
            }

            newsItem = dataManager.item(at: indexPath.row)
            nextViewController.title = newsItem.newsTitle
            nextViewController.dataItem = newsItem
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.itemsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SwiftNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SwiftNewsTableViewCell
        let item = dataManager.item(at: indexPath.row)
        cell.config(with: item)
        return cell
    }
}

