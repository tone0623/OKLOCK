//
//  SettingDistanceViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/19.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit

class SettingDistanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var distancePickerView: UIPickerView!
    
    let distanceSet = ["20メートル","50メートル","100メートル","200メートル","500メートル"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        distancePickerView.delegate = self
        distancePickerView.dataSource = self
        
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
           let item = distanceSet[row]
           return item
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           let row = pickerView.selectedRow(inComponent: 0)
           let kyori = self.pickerView(pickerView, titleForRow:  row, forComponent: 0)
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

