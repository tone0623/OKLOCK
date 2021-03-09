//
//  SettingsTimeViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/02.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class SettingsTimeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let timeSet = [3,5,10,30,60]
    let strTime = ["3","5","10","30","60"]
    
//    let timeSet = [["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"],["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]]
    
    
    @IBOutlet weak var timePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self

        //ピッカービューに秒のラベルを追加
        let minLabel = UILabel()
        minLabel.text = "分"
        minLabel.sizeToFit()
        minLabel.frame = CGRect(x: timePickerView.bounds.width * 3 / 5 +  minLabel.bounds.width * 4 / 5, y: timePickerView.bounds.height * 4 / 5 - (minLabel.bounds.height / 2), width: minLabel.bounds.width, height: minLabel.bounds.height)       //大きさの設定
        timePickerView.addSubview(minLabel)        //ピッカービューに追加
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeSet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 200
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = strTime[row]
        return item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let row = pickerView.selectedRow(inComponent: 0)
        let minute = timeSet[row]
        
        //let minute = self.pickerView(pickerView, titleForRow: row, forComponent: 0)
        //let minute2 = minute!.prefix(minute!.count - 1)
        
      UserDefaults.standard.set(minute, forKey: "minute")
        
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
