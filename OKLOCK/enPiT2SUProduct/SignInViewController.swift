//
//  SignInViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/12/06.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapSignInButton(_ sender: Any) {
        let email = emailText.text ?? ""
           let password = passordText.text ?? ""
            
           Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
               guard let self = self else { return }
               if let user = result?.user {
                print(user.uid)
                
                let invitation = UserDefaults.standard.object(forKey: "invitation") as! Int
                
                if invitation == 0 {
                    self.performSegue(withIdentifier: "Segue", sender: nil)
                } else {
//                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                    self.performSegue(withIdentifier: "code", sender: nil)
                }
                
            }
               self.showErrorIfNeeded(error)
           }
    }
    

    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
         
        let message = errorMessage(of: error) // エラーメッセージを取得
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
            return message
        }
         
        switch errcd {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
        // これは一例です。必要に応じて増減させてください
        default: break
        }
        return message
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
