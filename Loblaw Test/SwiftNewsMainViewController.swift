//
//  ViewController.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import UIKit

typealias DownloadCompletion = (Bool) -> Void

extension UIImageView {
    func downloadArticleImage(_ URLString: String, imageCache: NSCache<NSString, UIImage>, completion: @escaping (DownloadCompletion)) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            completion(true)
            return
        }

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    return
                }

                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                        else {
                            completion(false)
                        }
                }
            }).resume()
        }
    }
}

class SwiftNewsMainViewController: UITableViewController  {

    private let imageCache = NSCache<NSString, UIImage>()
    private var dataManager = SwiftNewsManager()
    private let cellIdentifier = "NewsItemCell"
    private let sectionCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCache.name = "Image Cache"
        imageCache.countLimit = 100
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 84.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Only load the data once
        if dataManager.items.count == 0 {
            dataManager.loadUpJSON {        
                DispatchQueue.main.async {
                    self.initializeTable()
                }
            }
        }
    }
    
    func initializeTable()
    {
        self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SwiftNewsTableViewCell {
        let cell: SwiftNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SwiftNewsTableViewCell
        let item = dataManager.item(at: indexPath.row) as SwiftNewsDataItem

        cell.config(with: item)

        if (item.thumbNailImageURL != "") {
            cell.newsItemImage?.downloadArticleImage(item.thumbNailImageURL, imageCache: self.imageCache, completion: { (success) in
                if success {
                    tableView.beginUpdates()
                    item.thumbNailImage = cell.newsItemImage?.image
                    tableView.endUpdates()
                }
            })
        }
        
        return cell
    }
}

