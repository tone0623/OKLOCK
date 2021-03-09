//
//  SettingsCompleted.swift
//  enPiT2SUProduct
//
//  Created by 酒巻里衣 on 2019/11/18.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class SettingsCompleted: UIViewController {
    
    @IBAction func settingButtonTapped(_ sender: UIButton) {
//        BluetoothManager.shared.manager.cancelPeripheralConnection(mainPeripheral!)
    }
    @IBAction func mainButtonTapped(_ sender: UIButton) {
        //起動を判定するlaunchedBeforeという論理型のKeyをUserDefaultsに用意
        UserDefaults.standard.set(true, forKey: "launchedBefore")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

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
