//
//  HandleRootVC.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/25.
//

import UIKit
import Amplify
import AmplifyPlugins

class HandleRootVC {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    var unsubscribeToken: UnsubscribeToken?
    
    func fetchCurrentAuthSession(window: UIWindow) {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
                DispatchQueue.main.async {
                    if session.isSignedIn != true {
                        self.setGuestVC(window: window)
                    } else {
                        self.setSignInVC(window: window)
                    }
                }
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }
    
    func setGuestVC(window: UIWindow) {
        let guestStoryboard: UIStoryboard = UIStoryboard(name: "Guest", bundle: nil)
        let guestFirstVC: GuestFirstViewController = guestStoryboard.instantiateViewController(withIdentifier: "guestFirstViewController") as! GuestFirstViewController
        navigationController = UINavigationController(rootViewController: guestFirstVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        print("setGuestVC")
        
        if UserDefaults.standard.bool(forKey: "isSignedIn") == false {
            return
        } else {
            UserDefaults.standard.set(false, forKey: "isSignedIn")
        }
    }
    
    func setSignInVC(window: UIWindow) {
        let signInStoryboard: UIStoryboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInFirstVC: SignInFirstViewController = signInStoryboard.instantiateViewController(withIdentifier: "signInFirstViewController") as! SignInFirstViewController
        navigationController = UINavigationController(rootViewController: signInFirstVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        print("setSignInVC")
        
        if UserDefaults.standard.bool(forKey: "isSignedIn") == true {
            return
        } else {
            UserDefaults.standard.set(true, forKey: "isSignedIn")
        }
    }
    
    func notifyAuthEvent() {
        unsubscribeToken = Amplify.Hub.listen(to: .auth) { payload in
            switch payload.eventName {
            case HubPayload.EventName.Auth.signedIn:
                NotificationCenter.default.post(name: .isSignedIn, object: nil, userInfo: ["isSignedIn" : true])
                print("User signed in")
                
            case HubPayload.EventName.Auth.signedOut:
                NotificationCenter.default.post(name: .isSignedIn, object: nil, userInfo: ["isSignedIn" : false])
                print("User signed out")
                
            default:
                break
            }
        }
    }
    
    func notifyAuthSessionExpiry() {
        unsubscribeToken = Amplify.Hub.listen(to: .auth) { payload in
            switch payload.eventName {
            case HubPayload.EventName.Auth.sessionExpired:
                NotificationCenter.default.post(name: .isSignedIn, object: nil, userInfo: ["isSignedIn" : false])
                print("Session expired")
                
            default:
                break
            }
        }
    }
    
}
