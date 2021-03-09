//
//  LeafonyLightValue2.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/15.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

//電気が消えているときのセンサーの照度を格納
var lightOff: [Double] = []

class LeafonyLightValue2: UIViewController {
    var intSensorValue: Double = 0

    @IBOutlet weak var display: UILabel!
    @IBAction func addLightOff(_ sender: UIButton) {
        intSensorValue = NSString(string: sensor).doubleValue
        lightOff.append(intSensorValue)
        UserDefaults.standard.set(lightOff, forKey: "lightoff")
        print("電気が消えているときの値は\(lightOff)")
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
        display.text = sensor
    }
}
