//
//  SwiftNewsTableViewCell.swift
//  Loblaw Test
//
//  Created by John Cebasek on 2020-11-20.
//

import UIKit

class SwiftNewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsItemTextLabel: UILabel?
    @IBOutlet weak var newsItemImage: UIImageView?
    @IBOutlet weak var thumbNailHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with newsItem: SwiftNewsDataItem) {
        self.thumbNailHeightConstraint.constant = 0
        newsItemTextLabel?.text = newsItem.newsTitle
        
        if (newsItem.thumbNailImage != nil)
        {
            newsItemImage?.image = newsItem.thumbNailImage
            self.thumbNailHeightConstraint.constant = 50.0;
        }
    }
}
