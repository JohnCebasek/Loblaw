//
//  SwiftNewsManager.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import Foundation
import UIKit

// Interesting bits out of the json
// 1 - Thumbnail, something like: https://b.thumbs.redditmedia.com/rIZBvhsAvtZYesjhwaHpQwRSaoqWQyHSLKBGP9AgVvc.jpg Entschuldigung, wo ist die Speisekarte?
// 2 - Title in the data node.
// 3 - Selftext (not selftext_hmtl)

let DataKey = "data"
let ChildrenKey = "children"
let TitleKey = "title"
let ThumbNailKey = "thumbnail"
let SelfTextKey = "selftext"

public class SwiftNewsManager {
    
    let dataSourceURL = "https://www.reddit.com/r/swift/.json"
    let countOfSections = 1
    let defaultSession = URLSession(configuration: .default)
    let noDescriptionKey = "NoDescription"
    
    var dataTask: URLSessionDataTask?
    var items: NSMutableArray = NSMutableArray.init()
    
    enum JSONError: String, Error {
        case NoData = "Error: No Data Returned"
        case ConversionFailed = "Error: Conversion from JSON failed"
    }
    
    public var numberOfItems: Int {
        return items.count
    }
    
    public var numberOfSections: Int {
        return countOfSections
    }
    
    public func item(at index: Int) -> SwiftNewsDataItem {
        return items[index] as! SwiftNewsDataItem;
    }
    
    public func loadUpJSON(completion: (() -> Void)?)
    {
        guard let endPoint = URL(string: dataSourceURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: endPoint) { (data, response, error ) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                
                guard let topLevelData = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                
                guard let dataDictionary: NSDictionary = topLevelData.object(forKey: DataKey) as? NSDictionary else {
                    throw JSONError.NoData
                }
                let childrenArray: NSArray? = dataDictionary.object(forKey: ChildrenKey) as? NSArray
                
                guard let itemCount = childrenArray?.count else {
                    throw JSONError.NoData
                }
                
                for count in 0 ... (itemCount - 1) {
                    let containerDict: NSDictionary? = childrenArray?.object(at: count) as? NSDictionary
                    let articleDict = containerDict?.object(forKey: DataKey) as? NSDictionary
                    
                    guard let articleTitle = articleDict?.object(forKey: TitleKey) as? String else {
                        break       // Dictionary may be broken, so try the next one
                    }
                    
                    guard var articleImageURL = articleDict?.object(forKey: ThumbNailKey) as? String else {
                        break
                    }
                    
                    guard var newsDescription = articleDict?.object(forKey: SelfTextKey) as? String else {
                        break
                    }
                    
                    if self.verifyURL(urlString: articleImageURL) == false {
                        articleImageURL = ""
                    }
                    
                    if newsDescription == "" {
                        newsDescription = NSLocalizedString(self.noDescriptionKey, comment: "")
                    }
                    
                    let dataItem = SwiftNewsDataItem(newsTitle: articleTitle, newsDescription: newsDescription, thumbNailImageURL: articleImageURL, thumbNailImage: nil)
                    self.items.add(dataItem)
                }
                
                completion?()
            }

            catch let error as JSONError {
                print(error.rawValue)
            }
            catch let error as NSError {
                print(error.description)
            }
        }.resume()
    }
    
    // Normally I would do this with regEx and friends, but I can't remember how right now...
    func verifyURL(urlString: String) -> Bool
    {
        var result = false
        guard let urlFromString = NSURL(string: urlString) as NSURL? else {
            return result
        }
        let hostString = urlFromString.scheme
        
        if hostString == "http" ||
            hostString == "https" {
            result = true
        }
        
        return result
    }
}

