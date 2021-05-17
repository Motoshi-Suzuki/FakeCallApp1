//
//  GuestFirstViewController.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/12.
//

import UIKit
import Amplify
import AmplifyPlugins

class GuestFirstViewController: UIViewController {
    
    var privacyPolicyButton: UIBarButtonItem?
    var signInButton: UIBarButtonItem?
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
        
        signInButton = UIBarButtonItem(title: "Sign in", style: .plain, target: self, action: #selector(signInButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = signInButton
    }
    
    @objc private func privacyPolicyButtonTapped(_ sender: UIBarButtonItem) {
        let guestStoryboard: UIStoryboard = UIStoryboard(name: "Guest", bundle: nil)
        let privacyVC: PrivacyPolicyViewController = guestStoryboard.instantiateViewController(withIdentifier: "privacyPolicyViewController") as! PrivacyPolicyViewController
        let privacyNC = UINavigationController(rootViewController: privacyVC)
        present(privacyNC, animated: true, completion: nil)
    }
    
    @objc func signInButtonTapped(_ sender: UIBarButtonItem) {
        self.signInWithWebUI()
    }
    
    func signInWithWebUI() {
        Amplify.Auth.signInWithWebUI(presentationAnchor: self.view.window!) { result in
            switch result {
            case .success(let authSignInResult):
                print("Sign in succeeded")
                self.signInNextStep(result: authSignInResult)
                self.handleRootVC.notifyAuthEvent()

            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
    
    func signInNextStep(result: AuthSignInResult) {
        switch result.nextStep {
        case .confirmSignInWithNewPassword(let info):
            print("New password additional info \(String(describing: info))")
        case .resetPassword(let info):
            print("Reset password additional info \(String(describing: info))")
        case .confirmSignUp(let info):
            print("Confirm signup additional info \(String(describing: info))")
        case .done:
            print("Signin complete")
        default:
            break
        }
    }
    
    @objc private func presentCallingVC() {
        let isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
        guard isSignedIn == false else {
            return
        }
        let guestStoryboard: UIStoryboard = UIStoryboard(name: "Guest", bundle: nil)
        let callingVC: CallingViewController = guestStoryboard.instantiateViewController(withIdentifier: "callingViewController") as! CallingViewController
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
