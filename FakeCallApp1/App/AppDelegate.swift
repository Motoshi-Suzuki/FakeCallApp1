//
//  AppDelegate.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/01/25.
//

import UIKit
import PushKit
import CallKit
import AVFoundation
import Amplify
import AmplifyPlugins
import AWSPinpoint

@main
class AppDelegate: UIResponder, UIApplicationDelegate, PKPushRegistryDelegate {
    
    let voipRegistry = PKPushRegistry(queue: .main)
    var callProvider: CXProvider?
    let callController = CXCallController()
    var pinpoint: AWSPinpoint?
//    let playSound = PlaySound()
    let handleUserDefaults = HandleUserDefaults()
    let watchConnectivity = WatchConnectionViewModel()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSPinpointAnalyticsPlugin())
            try Amplify.configure()
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
        
        let pinpointConfiguration = AWSPinpointConfiguration.defaultPinpointConfiguration(launchOptions: launchOptions)
        pinpointConfiguration.debug = true
        pinpoint = AWSPinpoint(configuration: pinpointConfiguration)
       
        handleUserDefaults.checkFirstLaunch()
        self.registarVoipPushes()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func registarVoipPushes() {
        voipRegistry.delegate = self
        voipRegistry.desiredPushTypes = [PKPushType.voIP]
    }
    
    // CXProvider of CallKit: reporting out-of-band notifications
    override init() {
        callProvider = CXProvider(configuration: CXProviderConfiguration.custom)
        super.init()
        if let provider = callProvider {
            provider.setDelegate(self, queue: nil)
        }
    }
    
    // get DeviceToken and send it to Pinpoint and Watch app.
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        
        let deviceToken: Data = pushCredentials.token
        guard deviceToken.count > 0 else {
            print("Could not get DeviceToken.")
            return
        }
        
        SharedInstance.deviceToken = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        UserDefaults.standard.set(SharedInstance.deviceToken, forKey: "deviceToken")
        
        // Send DeviceToken to Pinpoint.
        pinpoint?.notificationManager.interceptDidRegisterForRemoteNotifications(withDeviceToken: deviceToken)
        print("DeviceToken: \(SharedInstance.deviceToken)")
    }
    
    // Called when received Voip Push
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        guard type == .voIP else {
            return
        }
        
        let callUpdate = CXCallUpdate()
        let callHandle = CXHandle(type: .generic, value: "caller's name")
        let uuid = UUID()
        let savedCallerName = UserDefaults.standard.string(forKey: "caller")
        
        callUpdate.remoteHandle = callHandle
        callUpdate.localizedCallerName = savedCallerName
        callUpdate.hasVideo = false
        callUpdate.supportsDTMF = false
        callUpdate.supportsGrouping = false
        callUpdate.supportsHolding = false
        
        callProvider?.reportNewIncomingCall(with: uuid, update: callUpdate, completion: { (error) in
            if let error = error {
                print("Failed to report new incoming call \(error)")
                
            } else {
                CallManager.shared.addCall(uuid: uuid)
                completion()
            }
        })
    }
    
    func requestTransaction(with action: CXCallAction, completionHandler: ((Error?) -> Void)?) {
        let transaction = CXTransaction(action: action)
        callController.request(transaction) { (error) in
            completionHandler?(error)
        }
    }
    
    func answerCall(with uuid: UUID, completionHandler: ((Error?) -> Void)? = nil) {
        print("func answerCall")
        let answerCallAction = CXAnswerCallAction(call: uuid)
        self.requestTransaction(with: answerCallAction, completionHandler: completionHandler)
    }
    
    func endCall(with uuid: UUID, completionHandler: ((Error?) -> Void)? = nil) {
        let endCallAction = CXEndCallAction(call: uuid)
        self.requestTransaction(with: endCallAction, completionHandler: completionHandler)
    }
    
    func reportCallEnded(with uuid : UUID, endedAt: Date, reason: CXCallEndedReason) {
        callProvider?.reportCall(with: uuid, endedAt: endedAt, reason: reason)
    }
    
    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if audioSession.category != .playAndRecord {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord,
                                             options: AVAudioSession.CategoryOptions.allowBluetooth)
            }
            if audioSession.mode != .voiceChat {
                try audioSession.setMode(.voiceChat)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}


extension CXProviderConfiguration {
    
    // CXProviderConfiguration,CallKit: specify the behavior and capabilities of calls
    static var custom: CXProviderConfiguration {
        let configuration = CXProviderConfiguration()
        configuration.supportedHandleTypes = [.phoneNumber, .generic]
        configuration.maximumCallGroups = 1
        configuration.maximumCallsPerCallGroup = 1
        configuration.supportsVideo = false
        if let icon = UIImage(systemName: "person.crop.circle") {
            configuration.iconTemplateImageData = icon.pngData()
        }
//        configuration.ringtoneSound = "\(String(describing: UserDefaults.standard.string(forKey: "soundName"))).mp3"
        
        return configuration
    }
}


extension AppDelegate: CXProviderDelegate {
    
    func providerDidReset(_ provider: CXProvider) {
        // Stop audio
        // End all calls because they are no longer valid
        // Remove all calls from the app's list of call
//        playSound.stopTalkingSound()
        CallManager.shared.removeAllCalls()
        print("providerDidReset")
    }
    
    // called after user accepted incoming call
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        NotificationCenter.default.post(name: .incomingCall, object: nil)
        print("User accepted incoming call.")
//        playSound.playTalkingSound()
        self.configureAudioSession()
        action.fulfill()
    }
    
    // called after user finished calling
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
//        playSound.stopTalkingSound()
        CallManager.shared.removeCall(uuid: action.callUUID)
        NotificationCenter.default.post(name: .callFinished, object: nil)
        
        // Send message to Watch app.
        if SharedInstance.triggerdFromWatch != false {
            if self.watchConnectivity.session.activationState == .activated {
                let info: [String : Any] = ["UserInfo" : "Call Finished"]
                self.watchConnectivity.session.transferUserInfo(info)
            } else {
                print("Session is not activated.")
            }
            SharedInstance.triggerdFromWatch = false
        }
        
        action.fulfill()
        print("---Call Finished---")
    }

}
