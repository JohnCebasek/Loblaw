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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(with newsItem: SwiftNewsDataItem) {
        // stuff data into tableview cell here
        
        newsItemTextLabel?.text = newsItem.newsTitle
//        newsItemImage?.image = newsItem.newsImage
    }
}
