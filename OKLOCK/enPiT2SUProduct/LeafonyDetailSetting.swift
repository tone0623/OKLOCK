//
//  LeafonyDetailSetting.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/13.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class LeafonyDetailSetting: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBAction func detailButton(_ sender: UIButton) {
        switch detailLabel.text {
        case "鍵を開けた状態でOKボタンを押してください。":
            detailLabel.text = "鍵を閉めた状態でOKボタンを押してください。"
        case "鍵を閉めた状態でOKボタンを押してください。":
            detailLabel.text = "電気を付けた状態でOKボタンを押してください。"
        case "電気を付けた状態でOKボタンを押してください。":
            detailLabel.text = "電気を消した状態でOKボタンを押してください。"
        case "電気を消した状態でOKボタンを押してください。":
            performSegue(withIdentifier: "toAlertTest", sender: self)
        default:
            print("エラー")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

