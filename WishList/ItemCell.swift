//
//  ItemCell.swift
//  WishList
//
//  Created by LI MENG on 2017-05-31.
//  Copyright © 2017 LI MENG. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var itemTtile: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(item: Item) {
        itemTtile.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumbImage.image = item.toImage?.image as? UIImage
    }
    
}
