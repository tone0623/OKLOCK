//
//  saisousinnViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/12/06.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseAuth

class saisousinnViewController: UIViewController {


    @IBAction func saisouTapped(_ sender: Any) {
        var user = Auth.auth().currentUser;

        user?.sendEmailVerification() { [weak self] error in
            guard let self = self else { return }
            if error == nil {
    
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
