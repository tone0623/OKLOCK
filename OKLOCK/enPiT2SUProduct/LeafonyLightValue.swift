//
//  LeafonyLightValue.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/15.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import CoreBluetooth

//電気が点いているときのセンサーの照度を格納
var lightOn: [Double] = []

class LeafonyLightValue: UIViewController {
    
    var monitoringTarget: Monitor = .luminous
    var intSensorValue: Double = 0

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var device: UILabel!
    @IBAction func addLightOn(_ sender: UIButton) {
        intSensorValue = NSString(string: sensor).doubleValue
        lightOn.append(intSensorValue)
        UserDefaults.standard.set(lightOn, forKey: "lighton")
        print("電気が点いているときの値は\(lightOn)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
//        device.text = mainPeripheral?.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
                    
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeValue), userInfo: nil, repeats: true)
        }
            
        @objc func changeValue(_ sender: Timer) {
            display.text = sensor
        }
    
}
