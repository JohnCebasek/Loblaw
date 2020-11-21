//
//  SwiftNewsDataProvider.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import UIKit

public class SwiftNewsTableViewHelper: NSObject {
    private let newsManager: SwiftNewsManager
    private var theIndexPath: IndexPath
    
    init(newsProvider: SwiftNewsManager) {
        self.newsManager = newsProvider
        self.theIndexPath = IndexPath(item: 0, section: 0)
        
        super.init()
    }
}
