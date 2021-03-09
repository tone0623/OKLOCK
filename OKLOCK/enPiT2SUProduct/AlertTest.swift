//
//  AlertTest.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/13.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class AlertTest: UIViewController {
    
    let alert = UIAlertController(title: "警告", message: "鍵をかけ忘れています", preferredStyle: .alert)
    
    @IBAction func button(_ sender: UIButton) {
        self.present(alert, animated: true, completion: {print("アラートが正常に表示されました。")})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        
//        self.present(alert, animated: true, completion: {print("アラートが正常に表示されました。")})
    }

}

