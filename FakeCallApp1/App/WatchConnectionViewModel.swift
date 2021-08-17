//
//  WatchConnectionViewModel.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/08/16.
//

import WatchConnectivity

final class WatchConnectionViewModel: NSObject {
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension WatchConnectionViewModel: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("Activation of iOS app has completed.")
        }
    }
}
