//
//  ViewController.swift
//  enPiT2SUProduct
//
//  Created by Jun Ohkubo on 2019/09/04.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

//メイン画面のswiftファイル

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase
import CoreLocation
import UserNotifications

var flag = 0
var detailValue:Int = 0
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    var databaseRef: DatabaseReference!
    var lightStatus: [Bool] = []
    var keyStatus: [Bool] = []
    var idKey: [String] = []
    var idLight: [String] = []
    
    var distance = CLLocationDistance()
    let homecode = UserDefaults.standard.object(forKey: "homecode") as? String
    var homeFlag: Int = 1
    
    var timerSeconds: Timer?    //Timerインスタンスの保持(秒)
    var currentSeconds = 0.0
    var timerFlag = 0  //timerを同時に発動しないようにするフラグ
    
    var lightTuutiFlag = 0
    var keyTuutiFlag = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell
        
        if indexPath.row == 0 {
            var status: Bool = true
            cell.label1?.text = "カギ"
            for i in 0..<keyStatus.count {
                if !keyStatus[i]  {
                    status = false
                }
            }
            if status {
                cell.image1?.image = UIImage(named:"Lock")!
//                let content = UNMutableNotificationContent()
//                               content.title = "OKLOCK"
//                               content.body = "施錠されました。"
//                               let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
//                               UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            } else {
                cell.image1?.image = UIImage(named:"UnLock")!
//                if homeFlag == 0{
//                    let content = UNMutableNotificationContent()
//                    content.title = "OKLOCK"
//                    content.body = "【緊急】不在中の自宅の鍵が空きました。直ちに確認してください。"
//                    let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
//                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//                }
//                else{
//                    let content = UNMutableNotificationContent()
//                    content.title = "OKLOCK"
//                    content.body = "解錠されました。忘れずに鍵を閉めましょう。"
//                    let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
//                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//                }
               
            }
        } else if indexPath.row == 1 {
            var status: Bool = true
            cell.label1?.text = "電気"
            for i in 0..<lightStatus.count {
                if !lightStatus[i]  {
                    status = false
                }
            }
            if status {
                cell.image1?.image = UIImage(named:"OFFLIGHT")!
            } else {
                cell.image1?.image = UIImage(named:"ONLIGHT")!
            }
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailValue = indexPath.row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //データベースを参照
        databaseRef = Database.database().reference()
        
        //leafonyのvalueを取得（鍵の場合）
        databaseRef.child(homecode!).child("leafony/key/sensor1/Value").observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.keyStatus.append(obj)
                print(self.keyStatus)
                self.tableView.reloadData()
            }
        })
        //leafonyのvalueが変更されたらkeyStatusを変更（鍵の場合）
        databaseRef.child(homecode!).child("leafony/key/sensor1/Value").observe(.childChanged, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.keyStatus[0] = obj
                if self.keyStatus[0] == true{
                    let content = UNMutableNotificationContent()
                                                  content.title = "OKLOCK"
                                                  content.body = "施錠されました。"
                                                  let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
                                                  UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
                else {
                    let content = UNMutableNotificationContent()
                                                  content.title = "OKLOCK"
                                                  content.body = "解錠されました。忘れずに鍵を閉めましょう。"
                                                  let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
                                                  UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
                print(self.keyStatus)
                self.tableView.reloadData()
            }
        })
        
        //leafonyのvalueを取得（電気の場合）
        databaseRef.child(homecode!).child("leafony/light/sensor1/Value").observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.lightStatus.append(obj)
                self.tableView.reloadData()
            }
        })
        //leafonyのvalueが変更されたらlightStatusを変更（電気の場合）
        databaseRef.child(homecode!).child("leafony/light/sensor1/Value").observe(.childChanged, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.lightStatus[0] = obj
                if self.lightStatus[0] == true{
                    //電気の通知は外出時のみにする
                    let content = UNMutableNotificationContent()
                                                  content.title = "OKLOCK"
                                                  content.body = "消灯されました。"
                                                  let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
                                                  UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
                else{
                    let content = UNMutableNotificationContent()
                                                  content.title = "OKLOCK"
                                                  content.body = "点灯されました。"
                                                  let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
                                                  UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
                self.tableView.reloadData()
            }
        })
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        manager.delegate = self
        manager.allowsBackgroundLocationUpdates = true;
        
        setupLocationService()
    }
    
    //ここから位置情報をFirebaseに送る
   
    let manager = CLLocationManager()
    
    func setupLocationService() {
        manager.desiredAccuracy = kCLLocationAccuracyBest; // 位置情報取得の精度
        manager.distanceFilter = 10; // 位置情報取得する間隔、10m単位とする
        manager.pausesLocationUpdatesAutomatically = true   //移動していない場合は更新しない
        manager.startUpdatingLocation()
    }
    

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser!.uid
        let current = locations[0]
        let latitude = current.coordinate.latitude
        let longitude = current.coordinate.longitude
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)

        let data = [
            "latitude": latitude,
            "longitude": longitude]
     
    ref.child(homecode!).child("users").child("\(userID)").child("locations").updateChildValues(data)
        
        ref.child(homecode!).child("homeLocations").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let home = snapshot.value as? NSDictionary
            let homeLatitude = home?["latitude"] as? CLLocationDegrees
            let homeLongitude = home?["longitude"] as? CLLocationDegrees
            
            let homeLocation = CLLocation(latitude: homeLatitude!, longitude: homeLongitude!)
            
            self.distance = currentLocation.distance(from: homeLocation)
            print("distance:\(self.distance)")
            
            if self.distance > 60 {
                let data = ["\(userID)": 0]
                ref.child(self.homecode!).child("homeLocations").child("stayAtHome").updateChildValues(data)  //家にいなければ０をセット
            } else {
                let data = ["\(userID)": 1]
                ref.child(self.homecode!).child("homeLocations").child("stayAtHome").updateChildValues(data)  //家にいたら１をセット
            }
            
        }) { (error) in
            print("error=\(error.localizedDescription)")
        }
        
    ref.child(homecode!).child("homeLocations").child("stayAtHome").observe(DataEventType.value, with: { (snapshot) in
            let dic = snapshot.value as? NSDictionary
            
            if dic != nil {
                for (_,value) in dic! {
                    if value as! Int == 1 {
                        flag += 1
                    }
                }
            }
            
            print("flag:\(flag)")
            
            if flag == 0 {
                let flag2 = ["flag": 0]
                self.homeFlag = 0
            ref.child(self.homecode!).child("homeLocations").child("homeFlag").updateChildValues(flag2)  //誰かが家にいなければ0
                self.currentSeconds = 0
                self.timerSeconds?.invalidate()  //ストップウォッチを停止させるオプショナルチェーン
                self.timerFlag = 0
                
            ref.child(self.homecode!).child("leafony/light/sensor1/Value").observe(DataEventType.value, with: {(snapshot) in
                    let dic = snapshot.value as? NSDictionary
                    if dic != nil {
                        let status = dic?["value"] as! Bool
                        if status == false && self.lightTuutiFlag == 0 {
                            let lightContent = UNMutableNotificationContent()
                            lightContent.title = "OKLOCK"
                            lightContent.body = "電気を消し忘れています。"
                            let lightRequest = UNNotificationRequest(identifier: "immediately", content: lightContent, trigger: nil)
                            UNUserNotificationCenter.current().add(lightRequest, withCompletionHandler: nil)
                            self.lightTuutiFlag = 1
                        }
                  
                        if status == true {
                            self.lightTuutiFlag = 0
                        }
                    }
                })
                
            ref.child(self.homecode!).child("leafony/key/sensor1/Value").observe(DataEventType.value, with: {(snapshot) in
                    let dic = snapshot.value as? NSDictionary
                    if dic != nil {
                        let status = dic?["value"] as! Bool
                        if status == false && self.keyTuutiFlag == 0 {
                        let content = UNMutableNotificationContent()
                        content.title = "OKLOCK"
                        content.body = "不在中の鍵が開きました。"
                        // 直ぐに通知を表示
                        let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                            
                        self.keyTuutiFlag = 1
                        }
                        
                        if status == true {
                            self.keyTuutiFlag = 0
                        }
                        
                    }
                })
                
            } else {
                let flag2 = ["flag": 1]
                self.homeFlag = 1
            ref.child(self.homecode!).child("homeLocations").child("homeFlag").updateChildValues(flag2)  //誰かが家にいれば1
            ref.child(self.homecode!).child("leafony/key/sensor1/Value").observe(DataEventType.value, with: {(snapshot) in
                    let dic = snapshot.value as? NSDictionary
                    if dic != nil {
                        let status = dic?["value"] as! Bool
                        if status == false {
                            if self.timerFlag == 0 {
                                self.timerFlag = 1
                                self.start()
                            }
                        }
                    }
                })
            }
        flag = 0
        })

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error = \(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start() {
        timerSeconds = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        currentSeconds += 1.0
        //print("currentSeconds: \(currentSeconds)")
        
        if UserDefaults.standard.object(forKey: "minute") == nil {
            UserDefaults.standard.set(3, forKey: "minute")
        }
        let minute = UserDefaults.standard.object(forKey: "minute") as! Double
        //print("minute:\(minute)")
        
        if currentSeconds > minute * 60.0{
            currentSeconds = 0
            timerSeconds?.invalidate()
            timerFlag = 0
            let keyContent = UNMutableNotificationContent()
            keyContent.title = "OKLOCK"
            keyContent.body = "鍵が開いています。忘れずに鍵を閉めましょう。"
            let keyRequest = UNNotificationRequest(identifier: "immediately", content: keyContent, trigger: nil)
            UNUserNotificationCenter.current().add(keyRequest, withCompletionHandler: nil)
        }
    }
}

