//
//  File.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import Foundation
import UIKit

// Required so that we can get a description that's human readable, not just
// a hex address
extension SwiftNewsDataItem: CustomStringConvertible {
    var debugDescription: String {
        let result = String(format: debugStringFormat,
                            self.newsTitle,
                            self.newsDescription,
                            self.newsImage)
        
        return result
    }
    
    public var description: String {
        return self.debugDescription
    }
    
    @objc func debugQuickLookObject() -> Any? {
        return self.debugDescription
    }
}

public class SwiftNewsDataItem {
    let debugStringFormat = "Title: %@ Description: %@ Image URL: %@"
    var newsTitle : String
    var newsDescription: String
    var newsImage: String

    internal init(newsTitle: String = "", newsDescription: String = "", newsImage: String = "") {
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.newsImage = newsImage
    }
}
