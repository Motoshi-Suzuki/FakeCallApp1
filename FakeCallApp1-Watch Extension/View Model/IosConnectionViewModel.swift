//
//  IosConnectionViewModel.swift
//  FakeCallApp1-Watch Extension
//
//  Created by Motoshi Suzuki on 2021/08/16.
//

import WatchConnectivity

final class IosConnectionViewModel: NSObject {
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension IosConnectionViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("Activation for WatchOS's WatchConnectivity has completed.")
        }
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        guard let info = userInfo["UserInfo"] else {
            return
        }
        print("---Watch app received the UserInfo.---", "\n\(info)")
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .callFinished, object: nil)
        }
    }
    
}
