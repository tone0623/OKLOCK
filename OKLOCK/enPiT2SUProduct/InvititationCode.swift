//
//  InvititationCode.swift
//  enPiT2SUProduct
//
//  Created by 酒巻里衣 on 2019/12/27.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class InvititationCode: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        let code = textField.text ?? ""
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let dic = snapshot.value as? NSDictionary
            var flag = 0
            for (key, _) in dic! {
                let strKey = key as! String
//                print(strKey)
                if strKey == code {
                    flag = 1
                    UserDefaults.standard.set(code, forKey: "homecode")
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
            }
            if flag == 0 {
                self.showAlert(self)
            } else {
                self.performSegue(withIdentifier: "main", sender: nil)
            }
            
        }) { (error) in
            print("error=\(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //招待コードが正しくないときに出すアラート
    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: "エラー", message: "招待コードが正しくありません", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        
        self.present(
            alert,
            animated: true,
            completion: {
                print("アラートが表示された")
        })
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
