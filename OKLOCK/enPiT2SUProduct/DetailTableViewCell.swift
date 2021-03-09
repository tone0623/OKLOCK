//
//  DetailTableViewCell.swift
//  enPiT2SUProduct
//
//  Created by 工藤翔大 on 2019/10/28.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {


    @IBOutlet weak var labelA: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
