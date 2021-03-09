//
//  asobiViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/12/04.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class asobiViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBAction func button(_ sender: Any) {
        
        view.endEditing(true)

               if let name = text1.text, let message = text2.text {
                   let messageData = ["name": name, "message": message]
                guard let currentUid = Auth.auth().currentUser?.uid else { return }

                  print("Current user id is \(currentUid)")

                let i = 30
                let k = 670
                let ik = ["ido": i, "keido": k]
                databaseRef.child("users").child("location").setValue(ik)

                   text2.text = ""
               }
    }
    
    @IBOutlet weak var viewButtom: NSLayoutConstraint!
    
      var databaseRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef = Database.database().reference()

        databaseRef.observe(.childAdded, with: { snapshot in
               if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                   let currentText = self.textView.text
                   self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
               }
           })
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
//        
        
        func keyboardWillShow(_ notification: NSNotification){
            if let userInfo = notification.userInfo, let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                viewButtom.constant = keyboardFrameInfo.cgRectValue.height
            }

        }

        func keyboardWillHide(_ notification: NSNotification){
        viewButtom.constant = 0
        }
        
        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
