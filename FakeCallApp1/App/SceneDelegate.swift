//
//  SceneDelegate.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/01/25.
//

import UIKit
import Amplify
import AmplifyPlugins

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let handleRootVC = HandleRootVC()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window?.windowScene = windowScene
        
        if let window = self.window {
            handleRootVC.fetchCurrentAuthSession(window: window)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeRootVC(_:)), name: .isSignedIn, object: nil)
        
        if let urlInfo: Optional = connectionOptions.urlContexts {
            self.scene(scene, openURLContexts: urlInfo!)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    @objc func changeRootVC(_ notification: Notification) {
        guard let isSignedIn = notification.userInfo?["isSignedIn"] as? Bool else {
            print("Value of 'Key : isSignedIn' was not notified")
            return
        }        
        if let window = self.window {
            if isSignedIn != true {
                DispatchQueue.main.async {
                    self.handleRootVC.setGuestVC(window: window)
                }
            } else {
                DispatchQueue.main.async {
                    self.handleRootVC.setSignInVC(window: window)
                }
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        print("URLContexts: \(URLContexts)")
        print("url: \(url.absoluteURL)") // https://app.donnywals.com/post/10
        print("scheme: \(String(describing: url.scheme))") // https
        print("host: \(String(describing: url.host))") // app.donnywals.com
        print("path: \(url.path)") // /post/10
        print("components: \(url.pathComponents)") // ["/", "posts", "10"]
        
        guard let urlHost = url.host else {
            return
        }
        
        let urlHostString: String = urlHost as String
        
        if urlHostString == "guest" {
            if let window = self.window {
                handleRootVC.setGuestVC(window: window)
            }
//        } else if urlHostString == "signin" {
//            if let window = self.window {
//                handleRootVC.setSignInVC(window: window)
//            }
        } else {
            print("Invalid url host")
            return
        }
    }
    
}
