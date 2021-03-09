//
//  BluetoothManager.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/12/03.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import CoreBluetooth

enum NotificationKey: String {
    case centralManagerDidUpdateState
    case didDiscoverPeripheral
    case didConnectPeripheral
    case didDisconnectPeripheral

    func notificationName() -> NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }
}

class BluetoothManager: NSObject {
    /* Create shared instance. */
    static let shared = BluetoothManager.init()
    let manager = CBCentralManager.init()

    override init() {
        super.init()
        self.manager.delegate = self
    }
}

/* Use notification, because two classes want to receive delegate. */
extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        NotificationCenter.default.post(
            name: NotificationKey.centralManagerDidUpdateState.notificationName(),
            object: nil
        )
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        debugPrint("Did discover peripheral. peripheral: \(peripheral), rssi: \(RSSI), UUID: \(peripheral.identifier), advertisementData: \(advertisementData)");
        NotificationCenter.default.post(
            name: NotificationKey.didDiscoverPeripheral.notificationName(),
            object: peripheral
        )
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        debugPrint("Did connect to peripheral: \(peripheral)")
        NotificationCenter.default.post(
            name: NotificationKey.didConnectPeripheral.notificationName(),
            object: peripheral
        )
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        debugPrint("Did Disconnect to peripheral: \(peripheral)")
        if let error = error {
            debugPrint("with error \(error.localizedDescription)")
            return
        }

        NotificationCenter.default.post(
            name: NotificationKey.didDisconnectPeripheral.notificationName(),
            object: peripheral
        )
    }
}

