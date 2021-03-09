//
//  LeafonyNameSetting2.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/11/15.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseDatabase

//センサー(電気)の名前を格納
var lightName: [String] = []

class LeafonyNameSetting2: UIViewController, UITextFieldDelegate {
    
    var databaseRef: DatabaseReference!
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func addName(_ sender: UIButton) {
        lightName.append(textField.text!)
        UserDefaults.standard.set(lightName, forKey: "lightname")
        if let light = UserDefaults.standard.array(forKey: "lightname") {
            print(light)
        }
        databaseRef.child(homecode).child("leafony/light/sensor1/Name/name").setValue(textField.text)
        textField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データベースを参照
        databaseRef = Database.database().reference()

        textField.delegate = self
    }
    
    //textField、もしくはtextView以外の場所がタッチされた時に呼び出される
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //textFieldで完了がタップされた時に呼び出される
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

