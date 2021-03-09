//
//  lightNameChangeTableViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/22.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import Firebase

class lightNameChangeTableViewController: UITableViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var lightNameTextField: UITextField!
    
    var info: String!
    var value: Int!
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lightNameTextField.delegate = self
        
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
        
        ref.child(homecode).child("leafony").child("light").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
             let value = snapshot.value as? NSDictionary
             let name = value?["name"] as? String ?? ""
             self.lightNameTextField.text = name
         })
        
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

     
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
               // keyboardを隠す
               textField.resignFirstResponder()

                var ref: DatabaseReference!
                 ref = Database.database().reference()
                 
                let lightNameData = ["name": lightNameTextField.text]
                ref.child(homecode).child("leafony").child("light").child("name").setValue(lightNameData)
                
                
               return true
             }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    if viewController is SettingsTableViewController {
        
        var ref: DatabaseReference!
         ref = Database.database().reference()
         
        let lightNameData = ["name": lightNameTextField.text]
        ref.child(homecode).child("leafony").child("light").child("name").setValue(lightNameData)
        
        
    
    }
}
}
