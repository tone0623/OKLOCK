//
//  PeripheralListViewController.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/12/03.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit
import CoreBluetooth

let CellIdentifier = "Cell"

protocol PeripheralListViewControllerDelegate {
    func didConnectPeripheral(peripheral: CBPeripheral)
}

class PeripheralListViewController: UITableViewController {
    var delegate: PeripheralListViewControllerDelegate?
    var thermometers: [CBPeripheral] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Peripheral List"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(
            title: "Dismiss",
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )

        // Recieve notification setting.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(centralManagerDidUpdateState(notification:)),
            name: NotificationKey.centralManagerDidUpdateState.notificationName(),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(centralManagerDidDiscover(notification:)),
            name: NotificationKey.didDiscoverPeripheral.notificationName(),
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(centralManagerDidConnect(notification:)),
            name: NotificationKey.didConnectPeripheral.notificationName(),
            object: nil
        )
        // for just initialize BluetoothManager.
        _ = BluetoothManager.shared
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BluetoothManager.shared.manager.scanForPeripherals(
            //withServices: [CBUUID.init(string: BluetoothUUID.scanUuid.rawValue)], //scanUuidß
            withServices: nil,
            options: [CBCentralManagerScanOptionAllowDuplicatesKey:false]
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    /**
     * Check this hardware has Bluetooth Low Energy capability.
     */
    func isLECapableHardware() -> Bool {
        var state = ""
        switch BluetoothManager.shared.manager.state {
        case .unsupported:
            state = "The platform/hardware doesn't support Bluetooth Low Energy."
        case .unauthorized:
            state = "The app is not authorized to use Bluetooth Low Energy."
        case .poweredOff:
            state = "Bluetooth is currently powered off."
        case .poweredOn:
            return true
        default:
            return false
        }

        debugPrint("Central manager state: \(state)")

        let alert = UIAlertController(title: "HealthThermomater", message: state, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)

        return false
    }
}

// UITableViewDelegate methods.
extension PeripheralListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.thermometers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let peripheral = self.thermometers[indexPath.row]
        cell.textLabel?.text = peripheral.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let peripheral = self.thermometers[indexPath.row]
        BluetoothManager.shared.manager.connect(peripheral, options: nil)
    }
}

// Notification methods.
extension PeripheralListViewController {
    /**
     * Call when Bluetooth LE central state changed.
     */
    @objc
    func centralManagerDidUpdateState(notification: NSNotification) {
        _ = self.isLECapableHardware()
    }

    /**
     * Call when discover new peripheral.
     */
    @objc
    func centralManagerDidDiscover(notification: NSNotification) {
        if let peripheral = notification.object as? CBPeripheral, !self.thermometers.contains(peripheral) {
            debugPrint("Did discover peripheral. peripheral: \(peripheral)");
            if peripheral.name != nil {
                self.thermometers.append(peripheral)
            }
        }
    }

    /**
     * Call when success to connect peripheral.
     */
    @objc
    func centralManagerDidConnect(notification: NSNotification) {
        if let peripheral = notification.object as? CBPeripheral {
            debugPrint("Did connect to peripheral: \(peripheral)")
            self.delegate?.didConnectPeripheral(peripheral: peripheral)
            self.dismissViewController()
        }
    }
}

