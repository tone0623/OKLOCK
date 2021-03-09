//
//  BluetoothViewController.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/12/03.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import CoreBluetooth
import FirebaseDatabase

var mainPeripheral: CBPeripheral? = nil
var sensor = String()

//電気の場合
class BluetoothViewController: UIViewController {
    
    var databaseRef: DatabaseReference!
    var intSensorValue: Double = 0
    var lightID: [String] = []
    
    let homecode = UserDefaults.standard.object(forKey: "homecode") as! String

//    @IBOutlet var containerView: UIView!
    @IBOutlet var display: UILabel!
    @IBOutlet var unit: UILabel!
    @IBOutlet var connectDiscoonnectButton: UIButton!
    @IBOutlet weak var deviceLabel: UILabel!
    //    @IBOutlet var connectButtonLight: NSLayoutConstraint!
//    @IBOutlet var displayLeft: NSLayoutConstraint!
//    @IBOutlet var unitRight: NSLayoutConstraint!
    let baseWidth: CGFloat = 667 // for calculate label positon.
    var initialized = false

    var autoConnect: Bool = false
    var peripheral: CBPeripheral? {
        // When you update peripheral property, exec this block.
        didSet {
            self.connectDiscoonnectButton.setTitle(
                self.peripheral == nil ? "接続する" : "接続を解除する",
                for: .normal
            )
            // if disconnect peripheral, then cleanup display.
            if self.peripheral == nil {
                self.display.text = nil
                leafonyID = ""
                self.deviceLabel.text = "接続されていません"
            } else {
                self.deviceLabel.text = peripheral?.name
                leafonyID = peripheral!.name!
                lightID.append(leafonyID)
                mainPeripheral = self.peripheral
//                databaseRef.child("leafony/light/ID/id").setValue(lightID)
            }
        }
    }
    var monitoringTarget: Monitor = .luminous
    //デモ用コード
    var monitoringTarget2: Monitor = .angle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.hidesBackButton = true

        self.connectDiscoonnectButton.titleLabel?.adjustsFontSizeToFitWidth = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(disconnectPeripheral(notification:)),
            name: NotificationKey.didDisconnectPeripheral.notificationName(),
            object: nil
        )
        
        //データベースを参照
        databaseRef = Database.database().reference()
        
//        //leafonyのIDを取得（電気の場合）
//        databaseRef.child("leafony/light/ID").observe(.childAdded, with: { snapshot in
//            if let obj = snapshot.value as? [String] {
//                self.lightID = obj
//            }
//        })
    }

//    override func viewDidLayoutSubviews() {
//        // Adjust view layout.
//        super.viewDidLayoutSubviews()
//        if !initialized {
//            let ratio = self.containerView.frame.size.width / self.baseWidth
//            self.connectButtonLight.constant = self.connectButtonLight.constant * ratio
//            self.displayLeft.constant = self.displayLeft.constant * ratio
//            self.unitRight.constant = self.unitRight.constant * ratio
//            initialized = true
//        }
//    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func showPeripheralList() {
        if let peripheral = self.peripheral, peripheral.state == .connected {
            /* Disconnect peripheral if its already connected */
            BluetoothManager.shared.manager.cancelPeripheralConnection(peripheral)
        } else if let peripheral = self.peripheral {
            /* Device is not connected, cancel pending connection */
            BluetoothManager.shared.manager.cancelPeripheralConnection(peripheral)
        } else {
            /* Show peripheral list view. */
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PeripheralListViewController") as? PeripheralListViewController {
                vc.delegate = self
                let nav = UINavigationController.init(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            }
        }
    }

    /**
     * Get sensor value using regular expression.
     */
    func getSensorValueFrom(string: String, target: Monitor) -> String? {
        guard let regexp = try? NSRegularExpression(pattern: "^\(target.rawValue) ([0-9.]+) "),
            let results = regexp.firstMatch(in: string, options: .reportProgress, range: NSRange(location: 0, length: string.count)) else {
                return nil
        }
        debugPrint(string)
        let range = results.range(at: 1)
        debugPrint(range)
        let startIndex = string.index(string.startIndex, offsetBy: range.location)
        let endIndex = string.index(startIndex, offsetBy: range.length)
        debugPrint(target," ",startIndex," ",endIndex," ",string[startIndex...endIndex])
        return String(string[startIndex...endIndex])
    }
}

extension BluetoothViewController: PeripheralListViewControllerDelegate {
    func didConnectPeripheral(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        self.peripheral?.delegate = self
        self.peripheral?.discoverServices(nil)
    }
}

// CBPeripheralDelegate methods.
extension BluetoothViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        debugPrint("didDiscoverServices: \(peripheral)")
        if let error = error {
            debugPrint("Discovered services for \(peripheral) with error: \(error.localizedDescription)")
            return
        }

        peripheral.services?.forEach { service in
            if service.uuid.uuidString == BluetoothUUID.leafony.rawValue {
                self.peripheral?.discoverCharacteristics(
                    [
                        CBUUID.init(string: BluetoothUUID.sensor.rawValue),
                        CBUUID.init(string: BluetoothUUID.writeValue.rawValue)
                    ],
                    for: service
                )
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        debugPrint("didDiscoverCharacteristicsFor: \(peripheral), service: \(service)")

        if let error = error {
            debugPrint("Discovered characteristics for \(service.uuid) with error: \(error.localizedDescription)")
            return
        }

        if service.uuid.uuidString == BluetoothUUID.leafony.rawValue {
            service.characteristics?.forEach { characteristic in
                if characteristic.uuid.uuidString == BluetoothUUID.sensor.rawValue {
                    debugPrint("Found a Custom Read Characteristic")
                    self.peripheral?.setNotifyValue(true, for: characteristic)
                }
                if characteristic.uuid.uuidString == BluetoothUUID.writeValue.rawValue,
                    let data = Signal.send.data() {
                    self.peripheral?.writeValue(data, for: characteristic, type: .withResponse)
                    debugPrint("Found a Custom Write Characteristic - Write SND command")
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        debugPrint("didUpdateValueFor: \(peripheral), characteristic: \(characteristic)")
        if let error = error {
            debugPrint("Error updating value for characteristic \(characteristic.uuid) error: \(error.localizedDescription)")
            return
        }

        /* Leafony */
        if characteristic.uuid.uuidString == BluetoothUUID.sensor.rawValue,
            let data = characteristic.value,
            let string = String.init(data: data, encoding: .utf8) {
            debugPrint("updated: \(string)")

            if let sensorValue = self.getSensorValueFrom(string: string, target: self.monitoringTarget) {
                let unit = self.monitoringTarget.convertUnit()
                self.display.text = sensorValue
                sensor = sensorValue
                intSensorValue = NSString(string: sensor).doubleValue
                databaseRef.child(homecode).child("leafonyValue/lightSensor/sensorValue").setValue(intSensorValue)
                
                self.unit.text = unit.toString()
            }
            //デモ用コード
            if let sensorValue = self.getSensorValueFrom(string: string, target: self.monitoringTarget) {
                sensor2 = sensorValue
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        debugPrint("didWriteValueFor: \(peripheral), characteristic: \(characteristic)")
        if let error = error {
            debugPrint("Error writing value for characteristic \(characteristic.uuid) error: \(error.localizedDescription)")
            return
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        debugPrint("didUpdateNotificationStateFor: \(peripheral), characteristic: \(characteristic)")
        if let error = error {
            debugPrint("Error updating notification state for characteristic \(characteristic.uuid) error: \(error.localizedDescription)")
            return
        }

        debugPrint("Updated notification state for characteristic \(characteristic.uuid) newState:\(characteristic.isNotifying ? "Notifying": "Not Notifying")")
    }
}

extension BluetoothViewController {
    @objc
    func disconnectPeripheral(notification: NSNotification) {
        self.peripheral = nil
    }
}
