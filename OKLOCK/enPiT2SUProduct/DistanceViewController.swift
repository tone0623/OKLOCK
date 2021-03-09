//
//  DistanceViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/14.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let distanceSet = [20,50,100,200,500]
    let strDistance = ["20","50","100","200","500"]
    
    @IBOutlet weak var distancePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        distancePickerView.delegate = self
        distancePickerView.dataSource = self
        
        UserDefaults.standard.set(20, forKey: "kyori")
        
        //ピッカービューに秒のラベルを追加
        let kyoriLabel = UILabel()
        kyoriLabel.text = "メートル"
        kyoriLabel.sizeToFit()
        kyoriLabel.frame = CGRect(x: distancePickerView.bounds.width * 3 / 5 +  kyoriLabel.bounds.width * 4 / 5, y: distancePickerView.bounds.height * 1 / 2 - (kyoriLabel.bounds.height / 2), width: kyoriLabel.bounds.width, height: kyoriLabel.bounds.height)       //大きさの設定
        distancePickerView.addSubview(kyoriLabel)        //ピッカービューに追加
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distanceSet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = strDistance[row]
        return item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let row = pickerView.selectedRow(inComponent: 0)
        let kyori = distanceSet[row]
        //let kyori = self.pickerView(pickerView, titleForRow:  row, forComponent: 0)
        UserDefaults.standard.set(kyori, forKey: "kyori")
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
