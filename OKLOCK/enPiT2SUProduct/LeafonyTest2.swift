//
//  LeafonyTest2.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/18.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseDatabase

//電気が点いているか消えているかを判定する値を格納
var lightValue: [Double] = []

class LeafonyTest2: UIViewController {
    
    var databaseRef: DatabaseReference!
    var intSensorValue: Double = 0
    var value = true

    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var lightImage: UIImageView!
    @IBAction func resetButton(_ sender: UIButton) {
        lightOn.removeLast()
        lightOff.removeLast()
    }
    @IBAction func completeButton(_ sender: UIButton) {
//        databaseRef.child("leafony/key/sensor1/Value/value").setValue(lightValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        intSensorValue = NSString(string: sensor).doubleValue
        lightValue.append((lightOn.last! + lightOff.last!) / 2)
        UserDefaults.standard.set(lightValue, forKey: "lightvalue")

        if lightValue.last! < intSensorValue  {
            value = false
            lightImage.image = UIImage(named: "ONLIGHT")
            lightLabel.text = "電気が点いています。"
        } else if lightValue.last! > intSensorValue {
            value = true
            lightImage.image = UIImage(named: "OFFLIGHT")
            lightLabel.text = "電気が消えています。"
        }
        
        //データベースを参照
        databaseRef = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeValue), userInfo: nil, repeats: true)
    }
        
    @objc func changeValue(_ sender: Timer) {
        intSensorValue = NSString(string: sensor).doubleValue

        if lightValue.last! < intSensorValue  {
            value = false
            lightImage.image = UIImage(named: "ONLIGHT")
            lightLabel.text = "電気が点いています。"
        } else if lightValue.last! > intSensorValue {
            value = true
            lightImage.image = UIImage(named: "OFFLIGHT")
            lightLabel.text = "電気が消えています。"
        }
        
        databaseRef.child(homecode).child("leafony/light/sensor1/Value/value").setValue(value)
//        databaseRef.child("leafony/light/sensor1/Value/value").setValue(value)
    }

}
