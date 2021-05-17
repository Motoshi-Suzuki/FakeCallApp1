//
//  SignInFirstViewController.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/23.
//

import UIKit
import Amplify
import AmplifyPlugins

class SignInFirstViewController: UIViewController {
    
    var privacyPolicyButton: UIBarButtonItem?
    var signOutButton: UIBarButtonItem?
    let handleRootVC = HandleRootVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        handleRootVC.notifyAuthSessionExpiry()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentCallingVC), name: .incomingCall, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let leftBarIcon = UIImage(systemName: "info.circle")
        privacyPolicyButton = UIBarButtonItem(image: leftBarIcon, style: .plain, target: self, action: #selector(privacyPolicyButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = privacyPolicyButton
        
        signOutButton = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOutButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = signOutButton
    }
    
    @objc private func privacyPolicyButtonTapped(_ sender: UIBarButtonItem) {
        let signInStoryboard: UIStoryboard = UIStoryboard(name: "SignIn", bundle: nil)
        let privacyVC: PrivacyPolicyViewController = signInStoryboard.instantiateViewController(withIdentifier: "privacyPolicyViewController") as! PrivacyPolicyViewController
        let privacyNC = UINavigationController(rootViewController: privacyVC)
        present(privacyNC, animated: true, completion: nil)
    }
    
    @objc func signOutButtonTapped(_ sender: UIBarButtonItem) {
        self.signOutLocally()
    }
    
    func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
                self.handleRootVC.notifyAuthEvent()

            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    @objc private func presentCallingVC() {
        let isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
        guard isSignedIn == true else {
            return
        }
        let signInStoryboard: UIStoryboard = UIStoryboard(name: "SignIn", bundle: nil)
        let callingVC: CallingViewController = signInStoryboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
        callingVC.modalPresentationStyle = .fullScreen
        callingVC.modalTransitionStyle = .crossDissolve
        present(callingVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
