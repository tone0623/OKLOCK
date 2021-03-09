//
//  ShowInvitationCode.swift
//  enPiT2SUProduct
//
//  Created by 酒巻里衣 on 2019/12/31.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class ShowInvitationCode: UIViewController {
    @IBOutlet weak var showInvitationCode: UILabel!
    
    override func viewDidLoad() {
        let code = UserDefaults.standard.object(forKey: "homecode")
        
        showInvitationCode.text = (code as! String)
        
        
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
