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
        let debugStringFormat = "Title: %@ Description: %@ Image URL: %@"
        let result = String(format: debugStringFormat,
                            self.newsTitle,
                            self.newsDescription,
                            self.thumbNailImageURL)
        
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
    var newsTitle : String
    var newsDescription: String
    var thumbNailImageURL: String
    var thumbNailImage: UIImage? = nil
    
    
    internal init(newsTitle: String, newsDescription: String, thumbNailImageURL: String, thumbNailImage: UIImage? = nil) {
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.thumbNailImageURL = thumbNailImageURL
        self.thumbNailImage = thumbNailImage
    }
}
