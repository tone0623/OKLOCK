//
//  SettingsTableViewController.swift
//  enPiT2SUProduct
//
//  Created by 小柳優斗 on 2019/11/01.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import  Firebase


class SettingsTableViewController: UITableViewController{
    
    var keyNum: Int = 0
    var lightNum: Int = 0
    var info: String!
    
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var settingTableView: UITableView!
    
    
    var data: String = ""
    
    let items = ["センサー1","センサー2","センサー3","センサー4","センサー5"]
    
    @IBOutlet weak var keySensor1Label: UILabel!
    
    @IBOutlet weak var keySensor2Label: UILabel!
    
    @IBOutlet weak var keySensor3Label: UILabel!
    
    @IBOutlet weak var keySensor4Label: UILabel!
    
    @IBOutlet weak var keySensor5Label: UILabel!
    
    @IBOutlet weak var lightSensor1Label: UILabel!
    
    @IBOutlet weak var lightSensor2Label: UILabel!
    
    @IBOutlet weak var lightSensor3Label: UILabel!
    
    @IBOutlet weak var lightSensor4Label: UILabel!
    
    @IBOutlet weak var lightSensor5Label: UILabel!
    
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsDidChange),
                                                  name: UserDefaults.didChangeNotification, object: nil)
        
        // UserDefaultsの情報を画面にセットする
        if let hour = UserDefaults.standard.value(forKey: "hour") as? String {
             timeLabel.text = hour + ":"
        }
        
        if let minute = UserDefaults.standard.value(forKey: "minute") as? String {
             timeLabel.text = minute + "分"
        }
        
        keySensor1Label.text = info
        lightSensor1Label.text = info
        

        
        
        
       

        
        
        
        
        
        //以下useddefaults使用
        if let key:[String] = UserDefaults.standard.array(forKey:"keyname") as? [String]{
            keyNum = key.count
        }
        
        if let light:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
            lightNum = light.count
        }
        
        switch keyNum {
            case 1:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                    keySensor1Label.text = keyName[0]
                }
            case 2:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                    keySensor1Label.text = keyName[0]
                    keySensor2Label.text = keyName[1]
                }
            case 3:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                    keySensor1Label.text = keyName[0]
                    keySensor2Label.text = keyName[1]
                    keySensor3Label.text = keyName[2]
                }
            case 4:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                keySensor1Label.text = keyName[0]
                keySensor2Label.text = keyName[1]
                keySensor3Label.text = keyName[2]
                keySensor4Label.text = keyName[3]
                }
            
            case 5:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                keySensor1Label.text = keyName[0]
                keySensor2Label.text = keyName[1]
                keySensor3Label.text = keyName[2]
                keySensor4Label.text = keyName[3]
                keySensor5Label.text = keyName[4]
                }
            default:
                return
        }
        
        switch lightNum {
            case 1:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                    lightSensor1Label.text = lightName[0]
                }
            case 2:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                    lightSensor1Label.text = lightName[0]
                    lightSensor2Label.text = lightName[1]
                }
            case 3:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                    lightSensor1Label.text = lightName[0]
                    lightSensor2Label.text = lightName[1]
                    lightSensor3Label.text = lightName[2]
                }
            case 4:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                lightSensor1Label.text = lightName[0]
                lightSensor2Label.text = lightName[1]
                lightSensor3Label.text = lightName[2]
                lightSensor4Label.text = lightName[3]
                }
            
            case 5:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                lightSensor1Label.text = lightName[0]
                lightSensor2Label.text = lightName[1]
                lightSensor3Label.text = lightName[2]
                lightSensor4Label.text = lightName[3]
                lightSensor5Label.text = lightName[4]
                }
            default:
                return
        }
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keySensor1Label.text = info
        lightSensor1Label.text = info
            var ref: DatabaseReference!
            ref = Database.database().reference()

            ref.child(homecode).child("leafony").child("key").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                self.keySensor1Label.text = name
            })
            
            ref.child(homecode).child("leafony").child("light").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
                          let value = snapshot.value as? NSDictionary
                          let name = value?["name"] as? String ?? ""
                          self.lightSensor1Label.text = name
                      })
        

    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of section
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // 「」のセクション
          return 1
        case 1: // 「」のセクション
          return 1
        case 2:
            return keyNum
        case 3:
            return lightNum
        case 4:
            return 1
        default: // ここが実行されることはないはず
          return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            return
        case 2:
            data = items[indexPath.row]
            //performSegue(withIdentifier: "Segue", sender: nil)
            return
        case 3:
            data = items[indexPath.row]
        case 4:
            let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "システムの設定を初期化してもよろしいですか？", preferredStyle: UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in //UserDefaultsの削除
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "syokikaSegue", sender: nil)
            })
            let canseltAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.default, handler:{
                (action: UIAlertAction!) -> Void in print("Cansel")
            })
            alert.addAction(canseltAction)
            alert.addAction(defaultAction)
            tableView.deselectRow(at: indexPath, animated: true)
            present(alert, animated: true, completion: nil)
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            let vc = segue.destination as! sensorNameChangeViewController
            vc.info = items[self.settingTableView.indexPathForSelectedRow!.row]
        }
        
        if segue.identifier == "Segue2"{
            let value = segue.destination as! lightNameChangeTableViewController
            value.info = items[self.settingTableView.indexPathForSelectedRow!.row]
            
        }
        

    }
    
    
    @objc func userDefaultsDidChange(_ notification: Notification) {
       // UserDefaultsの変更があったので画面の情報を更新する
        
       if let minute = UserDefaults.standard.value(forKey: "minute") as? String {
            timeLabel.text = minute + "分"
       }
        
        if let key:[String] = UserDefaults.standard.array(forKey:"keyname") as? [String]{
            keyNum = key.count
        }
        
        if let light:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
            lightNum = light.count
        }
        
        switch keyNum {
            case 1:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                    keySensor1Label.text = keyName[0]
                }
            case 2:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                    keySensor1Label.text = keyName[0]
                    keySensor2Label.text = keyName[1]
                }
            case 3:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                    keySensor1Label.text = keyName[0]
                    keySensor2Label.text = keyName[1]
                    keySensor3Label.text = keyName[2]
                }
            case 4:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                keySensor1Label.text = keyName[0]
                keySensor2Label.text = keyName[1]
                keySensor3Label.text = keyName[2]
                keySensor4Label.text = keyName[3]
                }
            
            case 5:
                if let keyName:[String] = UserDefaults.standard.array(forKey: "keyname") as? [String]{
                keySensor1Label.text = keyName[0]
                keySensor2Label.text = keyName[1]
                keySensor3Label.text = keyName[2]
                keySensor4Label.text = keyName[3]
                keySensor5Label.text = keyName[4]
                }
            default:
                return
        }
        
        switch lightNum {
            case 1:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                    lightSensor1Label.text = lightName[0]
                }
            case 2:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                    lightSensor1Label.text = lightName[0]
                    lightSensor2Label.text = lightName[1]
                }
            case 3:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                    lightSensor1Label.text = lightName[0]
                    lightSensor2Label.text = lightName[1]
                    lightSensor3Label.text = lightName[2]
                }
            case 4:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                lightSensor1Label.text = lightName[0]
                lightSensor2Label.text = lightName[1]
                lightSensor3Label.text = lightName[2]
                lightSensor4Label.text = lightName[3]
                }
            
            case 5:
                if let lightName:[String] = UserDefaults.standard.array(forKey: "lightname") as? [String]{
                lightSensor1Label.text = lightName[0]
                lightSensor2Label.text = lightName[1]
                lightSensor3Label.text = lightName[2]
                lightSensor4Label.text = lightName[3]
                lightSensor5Label.text = lightName[4]
                }
            default:
                return
        }
        
    }

     deinit {
       // UserDefaultsの変更の監視を解除する
       NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
     }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

