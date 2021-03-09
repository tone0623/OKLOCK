//
//  HelpDetailViewController.swift
//  enPiT2SUProduct
//
//  Created by 利根川涼介 on 2019/11/15.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class HelpDetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var info: HelpInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
navigationItem.title = info.name
        label.text = info.description
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
