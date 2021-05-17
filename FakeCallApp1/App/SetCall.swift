//
//  SetCall.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/29.
//

import Foundation
import AWSPinpoint

class SetCall {
    
    let deviceToken = UserDefaults.standard.string(forKey: "deviceToken")
    
    func createMessageRequest() -> AWSPinpointTargetingSendMessagesRequest {
        
        let sendMessageRequest = AWSPinpointTargetingSendMessagesRequest()!
        let messageRequest = AWSPinpointTargetingMessageRequest()
        let addressConfig = AWSPinpointTargetingAddressConfiguration()!
        let messageConfig = AWSPinpointTargetingDirectMessageConfiguration()
        let apnsMessage = AWSPinpointTargetingAPNSMessage()
        
        addressConfig.channelType = AWSPinpointTargetingChannelType.apnsVoipSandbox
        messageRequest?.addresses = [deviceToken! : addressConfig]
        
        apnsMessage?.apnsPushType = "voip"
        apnsMessage?.action = .openApp
        apnsMessage?.title = "Title"
        apnsMessage?.body = "This is voip push from FakeCallApp1"
        apnsMessage?.timeToLive = 10
        messageConfig?.apnsMessage = apnsMessage
        messageRequest?.messageConfiguration = messageConfig
        
        sendMessageRequest.applicationId = "eaf06058c9034c59a8143d9d0b8a05c7"
        sendMessageRequest.messageRequest = messageRequest
        
        return sendMessageRequest
    }
    
    func startCall() {
        guard deviceToken != nil else {
            print("DeviceToken was nil")
            return
        }
        let request = self.createMessageRequest()

        AWSPinpointTargeting.default().sendMessages(request) { (response, error) in
            switch response {
            case .some(let response):
                print("'startCall' succeeded \(response)")
            case nil:
                print("'startCall' failed \(String(describing: error))")
            }
        }
    }

    
}
