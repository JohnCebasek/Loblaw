//
//  SwiftNewsDetailViewController.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import UIKit

class SwiftNewsDetailViewController: UIViewController {
    
    var swiftNewsData: SwiftNewsDataItem?
    var navBarLabelView: UILabel?;
    
    @IBOutlet weak var thumbNailImage: UIImageView!
    @IBOutlet weak var articleTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBarLabelView = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        self.navBarLabelView?.backgroundColor = UIColor.clear
        self.navBarLabelView?.numberOfLines = 0
        self.navBarLabelView?.textAlignment = NSTextAlignment.center
        self.navigationItem.titleView = self.navBarLabelView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navBarLabelView?.text = swiftNewsData?.newsTitle
        articleTextView.text = swiftNewsData?.newsDescription
        thumbNailImage.image = swiftNewsData?.thumbNailImage
    }
}
