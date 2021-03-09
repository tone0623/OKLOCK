//
//  FirstView.swift
//  enPiT2SUProduct
//
//  Created by 酒巻里衣 on 2019/12/31.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class FirstView: UIViewController {

    @IBAction func tappedInvitationButton(_ sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "invitation")
    }
    
    @IBAction func tappedRegistButton(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "invitation")
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
