//
//  NotificationCenterExtension.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/05/06.
//

import Foundation

extension Notification.Name {
    static let isSignedIn = Notification.Name("isSignedIn")
    static let callFinished = Notification.Name("callFinished")
    static let incomingCall = Notification.Name("incomingCall")
}
