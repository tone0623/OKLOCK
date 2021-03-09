//
//  TableViewCell.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/10/25.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

//メイン画面のTableViewCellに関するswiftファイル

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var image1: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
