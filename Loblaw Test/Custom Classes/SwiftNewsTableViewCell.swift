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
        // Initialization code
        
        self.thumbNailHeightConstraint.constant = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with newsItem: SwiftNewsDataItem) {
        newsItemTextLabel?.text = newsItem.newsTitle
    }
}
