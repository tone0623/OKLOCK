//
//  AddressRegistration.swift
//  enPiT2SUProduct
//
//  Created by 酒巻里衣 on 2019/10/28.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

//住所登録画面用のswiftファイル

import UIKit
import MapKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class AddressRegistration: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    var locationFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.allowsBackgroundLocationUpdates = true; // バックグランドモードで使用する場合YESにする必要がある
        manager.desiredAccuracy = kCLLocationAccuracyBest; // 位置情報取得の精度
        manager.distanceFilter = 10; // 位置情報取得する間隔、10m単位とする
        manager.pausesLocationUpdatesAutomatically = true

        if (CLLocationManager.authorizationStatus() != .authorizedAlways) {
            manager.requestAlwaysAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("locations : \(locations)")
            let current = locations[0]
            UserDefaults.standard.set(current.coordinate.latitude, forKey: "latitude")  //緯度の保存
            UserDefaults.standard.set(current.coordinate.longitude, forKey: "longitude")  //経度の保存
            
            latitude = UserDefaults.standard.object(forKey: "latitude") as! Double  //緯度の値をグローバル変数に代入
            longitude = UserDefaults.standard.object(forKey: "longitude") as! Double  //経度の値をグローバル変数に代入

            let region = MKCoordinateRegion(center: current.coordinate, latitudinalMeters: 500, longitudinalMeters: 500);  //mapを表示する範囲
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = current.coordinate
            annotation.title = "自宅の位置"
            mapView.addAnnotation(annotation)  //自宅の位置にピンを刺す
            
            //サーバーに住所の追加
            var ref: DatabaseReference!
            ref = Database.database().reference()
    //        let data = ["latitude": latitude, "longtude": longitude]
    //        let userID = Auth.auth().currentUser!.uid
            
            let homecode = random(length: 5)  //ホームコード。これが招待コードにもなる。
            UserDefaults.standard.set(homecode, forKey: "homecode")
    //        ref.child(homecode).child("users").child("\(userID)").child("locations").setValue(data)
            
            
            CLGeocoder().reverseGeocodeLocation(current) { placemarks, error in
                guard
                    let placemark = placemarks?.first, error == nil,
                    let administrativeArea = placemark.administrativeArea, // 都道府県
                    let locality = placemark.locality, // 市区町村
                    let thoroughfare = placemark.thoroughfare, // 地名(丁目)
                    let subThoroughfare = placemark.subThoroughfare // 番地
                    else {
                        self.addressLabel.text = ""
                        return
                    }
                
                self.addressLabel.text = """
                \(administrativeArea)\(locality)\(thoroughfare)\(subThoroughfare)
                """
            }
            
            let homedata = ["latitude": latitude, "longitude": longitude, "homecode": homecode] as [String : Any]
            //let userID = Auth.auth().currentUser!.uid
//            let data = ["flag": 1]
            ref.child(homecode).child("homeLocations").setValue(homedata)
//            ref.child(homecode).child("homeLocations").child("homeFlag").setValue(data)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error = \(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ランダムな英数字を作成する関数
    func random(length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var random = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            random += NSString(characters: &nextChar, length: 1) as String
        }
        
        return random
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
