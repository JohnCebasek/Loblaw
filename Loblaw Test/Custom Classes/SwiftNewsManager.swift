//
//  SwiftNewsManager.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import Foundation
import UIKit

public class SwiftNewsManager {
    
    public private(set) var items = [
        SwiftNewsDataItem(newsTitle: "John", newsImage: UIImage(imageLiteralResourceName:"counterfeit-bills-in-red-deer-area.jpg")),
        SwiftNewsDataItem(newsTitle: "Paul", newsImage: UIImage(imageLiteralResourceName:"counterfeit-bills-in-red-deer-area.jpg")),
        SwiftNewsDataItem(newsTitle: "George", newsImage: UIImage(imageLiteralResourceName:"counterfeit-bills-in-red-deer-area.jpg")),
        SwiftNewsDataItem(newsTitle: "Ringo", newsImage: UIImage(imageLiteralResourceName:"counterfeit-bills-in-red-deer-area.jpg")),
        SwiftNewsDataItem(newsTitle: "Brian", newsImage: UIImage(imageLiteralResourceName:"counterfeit-bills-in-red-deer-area.jpg"))
    ]
    
    public var itemsCount: Int {
        return items.count
    }
    
    public func item(at index: Int) -> SwiftNewsDataItem {
        return items[index];
    }
}
