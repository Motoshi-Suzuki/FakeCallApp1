//
//  ContentView.swift
//  FakeCallApp1-Watch Extension
//
//  Created by Motoshi Suzuki on 2021/08/14.
//

import SwiftUI

struct ContentView: View {
    
    var watchConnectivity = IosConnectionViewModel()
    @State private var ready = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text(self.ready ? "Fake Phone" : "Not Ready")
                .font(.title3)
            StartCallButton(ready: $ready)
        }
        .onAppear {
            self.checkDeviceToken()
        }
        .onReceive(NotificationCenter.default.publisher(for: .gotDeviceToken), perform: { _ in
            self.gotDeviceToken()
        })
    }
    
    private func checkDeviceToken() {
        if WatchInstance.deviceToken == "No DeviceToken" {
            print("DeviceToken for Watch app is not ready.")
        } else {
            self.ready = true
        }
    }
    
    private func gotDeviceToken() {
        if WatchInstance.deviceToken != "No DeviceToken" {
            self.ready = true
        }
    }
}

struct StartCallButton: View {
    @Binding var ready: Bool
    
    var body: some View {
        Button(action: {
            print("Button")
        }, label: {
            Circle()
                .fill(self.ready ? Color(.green) : Color(.gray))
                .frame(width: 140, height: 140)
                .overlay(
                    Image(systemName: "phone.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                )
        })
        .frame(width: 140, height: 140)
        .disabled(self.ready != true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
