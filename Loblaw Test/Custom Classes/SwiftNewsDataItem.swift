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
    var thumbNailImage: UIImage?
    
    init(newsTitle: String, newsDescription: String, thumbNailImageURL: String) {
        self.newsTitle = newsTitle
        self.newsDescription = newsDescription
        self.thumbNailImageURL = thumbNailImageURL
        self.setImage(from: thumbNailImageURL)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        
        let image = UIImage(data: imageData)
        
        self.thumbNailImage = image
    }
}
