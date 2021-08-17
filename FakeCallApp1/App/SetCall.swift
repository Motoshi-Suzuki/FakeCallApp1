//
//  SetCall.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/29.
//

import Foundation
import AWSPinpoint

class SetCall {
        
    func createMessageRequest() -> AWSPinpointTargetingSendMessagesRequest {
        
        let sendMessageRequest = AWSPinpointTargetingSendMessagesRequest()!
        let messageRequest = AWSPinpointTargetingMessageRequest()
        let addressConfig = AWSPinpointTargetingAddressConfiguration()!
        let messageConfig = AWSPinpointTargetingDirectMessageConfiguration()
        let apnsMessage = AWSPinpointTargetingAPNSMessage()
        
        addressConfig.channelType = AWSPinpointTargetingChannelType.apnsVoipSandbox
        messageRequest?.addresses = [SharedInstance.deviceToken : addressConfig]
        
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
        guard SharedInstance.deviceToken != "No DeviceToken" else {
            let message = "No DeviceToken found internally"
            NotificationCenter.default.post(name: .internalError, object: nil, userInfo: ["message" : message])
            print(message)
            return
        }
        
        let request = self.createMessageRequest()

        AWSPinpointTargeting.default().sendMessages(request) { (response, error) in
            switch response {
            case .some(let response):
                print("'sendMessages' request succeeded \(response)")
            case nil:
                print("'sendMessages' request failed \(String(describing: error))")
            }
            
            if let result = response?.messageResponse?.result {
                for (_, value) in result {
                    let messageResult: AWSPinpointTargetingMessageResult = value
                    if messageResult.statusCode != NSNumber(200) {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .pinpointError, object: nil, userInfo: ["statusMessage" : messageResult.statusMessage as Any])
                        }
                        print("Pinpoint error occured \(messageResult)")
                    } else {
                        print("'startCall' request completely succeeded")
                    }
                }
            }
        }
    }

    
}
