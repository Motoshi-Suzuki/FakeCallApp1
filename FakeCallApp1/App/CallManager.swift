//
//  CallManager.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/02/01.
//

import Foundation
import CallKit

class CallManager {
    // 1
    static let shared = CallManager()

    let callController = CXCallController()

    // 2
    private(set) var callIDs: [UUID] = []

    // MARK: Call Management
    func containsCall(uuid: UUID) -> Bool {
        return CallManager.shared.callIDs.contains(where: { $0 == uuid })
    }

    func addCall(uuid: UUID) {
        self.callIDs.append(uuid)
    }

    func removeCall(uuid: UUID) {
        self.callIDs.removeAll { $0 == uuid }
    }

    func removeAllCalls() {
        self.callIDs.removeAll()
    }
}
