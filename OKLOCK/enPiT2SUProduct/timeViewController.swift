//
//  timeViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/14.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class timeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {


    let timeSet = [3,5,10,30,60]
    let strTime = ["3","5","10","30","60"]
    
    @IBOutlet weak var timePickerVIew: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(3, forKey: "minute")
            
        
        timePickerVIew.delegate = self
        timePickerVIew.dataSource = self
        
        //ピッカービューに秒のラベルを追加
        let minLabel = UILabel()
        minLabel.text = "分"
        minLabel.sizeToFit()
        minLabel.frame = CGRect(x: timePickerVIew.bounds.width * 3 / 5 +  minLabel.bounds.width * 4 / 5, y: timePickerVIew.bounds.height * 3 / 5 - (minLabel.bounds.height / 2), width: minLabel.bounds.width, height: minLabel.bounds.height)       //大きさの設定
        timePickerVIew.addSubview(minLabel)        //ピッカービューに追加
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
//        let minute = self.pickerView(pickerView, titleForRow: row, forComponent: 0)
//        let minute2 = minute!.prefix(minute!.count - 1)
        
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
