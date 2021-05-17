//
//  HandleUserDefaults.swift
//  FakeCallApp1
//
//  Created by Motoshi Suzuki on 2021/04/15.
//

import Foundation

class HandleUserDefaults: UserDefaults {
        
    func checkFirstLaunch() {
        guard string(forKey: "isFirstLaunch") == nil  else {
            print("Welcome back !!")
            return
        }
        
        set("This is first launch", forKey: "isFirstLaunch")
//        set("ringtone", forKey: "soundName")
//        set([true, false, false, false, false], forKey: "soundCheckmark")
        set("Graham Bell", forKey: "caller")
        
        print("Welcome to FakeCallApp1")
        
    }
    
}
