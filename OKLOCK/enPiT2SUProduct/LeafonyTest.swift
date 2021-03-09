//
//  LeafonyTest.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/17.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseDatabase

//鍵が開いているか閉まっているかを判定する値を格納
var keyValue: [Double] = []

class LeafonyTest: UIViewController {
    
    var databaseRef: DatabaseReference!
    var intSensorValue: Double = 0
    var value = true
    
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    
    @IBOutlet weak var keyImage: UIImageView!
    @IBOutlet weak var keyLabel: UILabel!
    @IBAction func resetButton(_ sender: UIButton) {
        keyOpen.removeLast()
        keyClose.removeLast()
    }
    @IBAction func completeButton(_ sender: UIButton) {
//        databaseRef.child("leafony/key/name1/value").setValue(value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        intSensorValue = NSString(string: sensor2).doubleValue
        keyValue.append((keyOpen.last! + keyClose.last!) / 2)
        UserDefaults.standard.set(keyValue, forKey: "keyvalue")

        if keyValue.last! < intSensorValue  {
            value = true
            keyImage.image = UIImage(named: "Lock")
            keyLabel.text = "鍵が閉まっています。"
        } else if keyValue.last! > intSensorValue {
            value = false
            keyImage.image = UIImage(named: "UnLock")
            keyLabel.text = "鍵が開いています。"
        }
        
        //データベースを参照
        databaseRef = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changeValue), userInfo: nil, repeats: true)
    }
    
    @objc func changeValue(_ sender: Timer) {
        intSensorValue = NSString(string: sensor2).doubleValue
        
        if keyValue.last! > intSensorValue  {
            value = true
            keyImage.image = UIImage(named: "Lock")
            keyLabel.text = "鍵が閉まっています。"
        } else if keyValue.last! < intSensorValue {
            value = false
            keyImage.image = UIImage(named: "UnLock")
            keyLabel.text = "鍵が開いています。"
        }
        
        databaseRef.child(homecode).child("leafony/key/sensor1/Value/value").setValue(value)
//        databaseRef.child("leafony/key/sensor1/Value/value").setValue(value)
    }

}
