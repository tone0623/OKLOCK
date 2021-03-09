//
//  LeafonyKeyValue.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/15.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

//鍵が開いているときのセンサーの角度を格納
var keyOpen: [Double] = []

class LeafonyKeyValue: UIViewController {
    var intSensorValue: Double = 0

    @IBOutlet weak var display: UILabel!
    @IBAction func addKeyOpen(_ sender: UIButton) {
        intSensorValue = NSString(string: sensor2).doubleValue
        keyOpen.append(intSensorValue)
        UserDefaults.standard.set(keyOpen, forKey: "keyopen")
        print("鍵が開いているときの値は\(keyOpen)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeValue), userInfo: nil, repeats: true)
    }
        
    @objc func changeValue(_ sender: Timer) {
        display.text = sensor2
    }
    
}
