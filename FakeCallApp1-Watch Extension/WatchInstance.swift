//
//  WatchInstance.swift
//  FakeCallApp1-Watch Extension
//
//  Created by Motoshi Suzuki on 2021/08/17.
//

import Foundation

struct WatchInstance {
    static var deviceToken = "No DeviceToken"
}

extension Notification.Name {
    static let gotDeviceToken = Notification.Name("gotDeviceToken")
}
