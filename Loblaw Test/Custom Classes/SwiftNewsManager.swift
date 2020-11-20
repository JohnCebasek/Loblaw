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
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var items: NSMutableArray = NSMutableArray.init()
    
    enum JSONError: String, Error {
        case NoData = "Error: No Data Returned"
        case ConversionFailed = "Error: Conversion from JSON failed"
    }
    
    init() {
        loadUpJSON()
    }
    
    public var itemsCount: Int {
        return items.count
    }
    
    public func item(at index: Int) -> SwiftNewsDataItem {
        return items[index] as! SwiftNewsDataItem;
    }
    
    public func loadUpJSON()
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
                
                print(topLevelData, topLevelData.count, type(of: topLevelData))

                let dataDictionary: NSDictionary? = topLevelData.object(forKey: DataKey) as? NSDictionary
                print(dataDictionary as Any, type(of: dataDictionary))
                
                let childrenArray: NSArray? = dataDictionary?.object(forKey: ChildrenKey) as? NSArray
                print(childrenArray as Any, type(of: childrenArray))
                
                guard let itemCount = childrenArray?.count else {
                    return
                }
                
                for count in 0 ... itemCount - 1 {
                    let containerDict: NSDictionary? = childrenArray?.object(at: count) as? NSDictionary
                    let articleDict = containerDict?.object(forKey: DataKey) as? NSDictionary
                    
                    guard let articleTitle = articleDict?.object(forKey: TitleKey) as? String else {
                        break
                    }
                    
                    guard let articleImage = articleDict?.object(forKey: ThumbNailKey) as? String else {
                        break
                    }
                    
                    guard let newsDescription = articleDict?.object(forKey: SelfTextKey) as? String else {
                        break
                    }
                    
                    let dataItem = SwiftNewsDataItem(newsTitle: articleTitle, newsDescription: newsDescription, newsImage: articleImage)
                    self.items.add(dataItem)
                }
                
                print(self.items)
            }
            catch let error as JSONError {
                print(error.rawValue)
            }
            catch let error as NSError {
                print(error.description)
            }
        }.resume()
    }
}

