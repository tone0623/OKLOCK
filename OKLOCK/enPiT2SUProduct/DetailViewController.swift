//
//  DetailViewController.swift
//  enPiT2SUProduct
//
//  Created by 工藤翔大 on 2019/10/26.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var databaseRef: DatabaseReference!
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String
    //statusを保持する変数
    var keyStatus: [Bool] = []
    var lightStatus: [Bool] = []
    //nameを保持する変数
    var nameKey: [String] = []
    var nameLight: [String] = []

    @IBOutlet weak var TableLabel: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        //鍵の場合
        if detailValue == 0 {
            count = nameKey.count
        //電気の場合
        } else if detailValue == 1 {
            count = nameLight.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellA", for: indexPath) as! DetailTableViewCell
        
        //鍵の場合
        if detailValue == 0 {
            for i in 0...nameKey.count {
                if indexPath.row == i {
                    print(i)
                    print("保存されている鍵の値\(keyStatus[i])")
                    print("保存されている鍵の名前\(nameKey[i])")
                    cell.labelA?.text = nameKey[i]
                    if keyStatus[i]  {
                        cell.imageA?.image = UIImage(named: "Lock")
                    } else {
                        cell.imageA?.image = UIImage(named: "UnLock")
                    }
                }
            }
        //電気の場合
        } else if detailValue == 1 {
            for i in 0..<keyStatus.count {
                if indexPath.row == i {
                    print("保存されている電気の値\(lightStatus[i])")
                    print("保存されている電気の名前\(nameLight[i])")
                    cell.labelA?.text = nameLight[i]
                    if lightStatus[i] {
                        cell.imageA?.image = UIImage(named: "OFFLIGHT")
                    } else {
                        cell.imageA?.image = UIImage(named: "ONLIGHT")
                    }
                }
            }
        }
            
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //データベースを参照
        databaseRef = Database.database().reference()
        
        //データの読み込み
        //leafonyのvalueを取得（鍵の場合）
       //過去　FB4B3891-C482-9F69-75D7-BD20EE8D77AD
        databaseRef.child(homecode).child("leafony/key/sensor1/Value").observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.keyStatus.append(obj)
                print(self.keyStatus)
                self.TableLabel.reloadData()
            }
        })
        //leafonyのvalueが変更されたらkeyStatusを変更（鍵の場合）
        databaseRef.child(homecode).child("leafony/key/sensor1/Value").observe(.childChanged, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.keyStatus[0] = obj
                print(self.keyStatus)
                self.TableLabel.reloadData()
            }
        })
        //leafonyのnameを取得（鍵の場合）
        databaseRef.child(homecode).child("leafony/key/sensor1/Name").observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? String {
                self.nameKey.append(obj)
                print(self.nameKey)
                self.TableLabel.reloadData()
            }
        })
        //leafonyのvalueを取得（電気の場合）
        databaseRef.child(homecode).child("leafony/light/sensor1/Value").observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.lightStatus.append(obj)
                self.TableLabel.reloadData()
            }
        })
        //leafonyのvalueが変更されたらlightStatusを変更（電気の場合）
        databaseRef.child(homecode).child("leafony/light/sensor1/Value").observe(.childChanged, with: { snapshot in
            if let obj = snapshot.value as? Bool {
                self.lightStatus[0] = obj
                self.TableLabel.reloadData()
            }
        })
        //leafonyのnameを取得（電気の場合）
        databaseRef.child(homecode).child("leafony/light/sensor1/Name").observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? String {
                self.nameLight.append(obj)
                print(self.nameLight)
                self.TableLabel.reloadData()
            }
        })
        
        TableLabel.delegate = self
        TableLabel.dataSource = self
        
        TableLabel.tableFooterView = UIView(frame: .zero)
    }

}

