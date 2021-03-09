//
//  Constants.swift
//  enPiT2SUProduct
//
//  Created by Kase Yudai on 2019/12/03.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import Foundation

enum BluetoothUUID: String {
    //case scanUuid     = ""
    case leafony      = "442F1570-8A00-9A28-CBE1-E1D4212D53EB"
    case sensor       = "442F1571-8A00-9A28-CBE1-E1D4212D53EB"
    case writeValue   = "442F1572-8A00-9A28-CBE1-E1D4212D53EB"
}

enum DisplayUnit {
    case degree

    func toString() -> String {
        switch self {
        case .degree:
            return ""
        /*  case //ここに他のセンサ情報を追加 */
        }
    }
}

enum Monitor: String {
    case luminous = "Lum"
    case angle = "Ang"
    case humidity = "..." // <- 湿度の定義を追加
    /*  case //ここに他のセンサ情報を追加 */
 

    func convertUnit() -> DisplayUnit {
        switch self {
        case .luminous:
            return .degree
        case .angle:
            return .degree
        /*  case //ここに他のセンサ情報を追加 */
        default:
            return .degree
        }
    }

}

enum Signal: String {
    case send = "SND"

    func data() -> Data? {
        return self.rawValue.data(using: .utf8)
    }
}

