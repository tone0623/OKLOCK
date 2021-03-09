//
//  sensorNameChangeViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/19.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import Firebase


class sensorNameChangeViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var sensorTextField: UITextField!
    
    var info: String!
    var value: Int!
    
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sensorTextField.delegate = self
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        switch info {
        case "センサー1":
            value = 0
        case "センサー2":
            value = 1
        case "センサー3":
            value = 2
        case "センサー4":
            value = 3
        case "センサー5":
            value = 4
        default:
            return
        }
        
        ref.child(homecode).child("leafony").child("key").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            self.sensorTextField.text = name
        })
        
        
        
//        if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
//            sensorTextField.text = keyName[value]
//        }
        
        navigationController?.delegate = self
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
               // #warning Incomplete implementation, return the number of sections
               return 1
           }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               // #warning Incomplete implementation, return the number of rows
               return 1
           }

//           func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//               //変更後の内容を作成
//               let tmpStr = textField.text! as NSString
//               let replacedString = tmpStr.replacingCharacters(in: range, with: string)
//
//
//               if var keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
//                   keyName.remove(at: 0)
//               keyName.insert(textField.text!, at: 0)
//
//                   UserDefaults.standard.set(keyName, forKey: "keyname")
//                      }
//
//               return true
//           }

        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           // keyboardを隠す
           textField.resignFirstResponder()

            
            
             var ref: DatabaseReference!
             ref = Database.database().reference()
             
            let nameData = ["name": sensorTextField.text]
            ref.child(homecode).child("leafony").child("key").child("name").setValue(nameData)
            
//            let tmpStr = textField.text! as NSString
//                          let replacedString = tmpStr.replacingCharacters(in: range, with: string)
//            if var keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
//                keyName.remove(at: value)
//            keyName.insert(textField.text!, at: value)
//                UserDefaults.standard.set(keyName, forKey: "keyname")
//                   }
            
           return true
         }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is SettingsTableViewController {
            
            
                var ref: DatabaseReference!
                ref = Database.database().reference()
            let nameData = ["name": sensorTextField.text]
                 ref.child(homecode).child("leafony").child("key").child("name").setValue(nameData)
            

            
//            if var keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
//                keyName.remove(at: value)
//            keyName.insert(sensorTextField.text!, at: value)
//                UserDefaults.standard.set(keyName, forKey: "keyname")
//                   }
            
        }
    }
        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

