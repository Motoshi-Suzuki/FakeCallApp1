//
//  ContentViewModel.swift
//  FakeCallApp1-Watch Extension
//
//  Created by Motoshi Suzuki on 2021/08/21.
//

import Foundation

final class ContentViewModel: ObservableObject {
    
    private let watchConnectivity = IosConnectionViewModel()
    @Published var ready = false
    @Published var calling = false
    
    func checkConnectivity() {
        guard self.watchConnectivity.session.activationState == .activated else {
            print("WCSession is not activated.")
            return
        }
        if self.watchConnectivity.session.isReachable {
            self.ready = true
        } else {
            self.ready = false
        }
    }
    
    func triggerCall() {
        if self.ready != false && self.watchConnectivity.session.isReachable {
            self.calling = true
            let message: [String : Any] = ["Message" : "Start Call Now"]
            self.watchConnectivity.session.sendMessage(message, replyHandler: nil) { error in
                print(error.localizedDescription)
            }
            print("---StartCall triggerd from Watch app.---")
        }
        // Check availability of Interactive messaging.
        self.checkConnectivity()
    }
}
