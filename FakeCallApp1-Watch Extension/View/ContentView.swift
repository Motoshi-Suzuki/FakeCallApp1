//
//  ContentView.swift
//  FakeCallApp1-Watch Extension
//
//  Created by Motoshi Suzuki on 2021/08/14.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 8.0) {
            if viewModel.calling {
                Text("Calling...")
            } else {
                Text(viewModel.ready ? "Fake Phone" : "Not Ready")
            }
            
            Button(action: {
                viewModel.triggerCall()
            }, label: {
                if viewModel.calling {
                    CallingButtonDesign()
                } else if viewModel.ready {
                    ReadyButtonDesign()
                } else {
                    NotReadyButtonDesign()
                }
            })
            .buttonStyle(PlainButtonStyle())
            .frame(width: 140, height: 140)
            .disabled(viewModel.calling != false)
        }
        .onAppear {
            viewModel.checkConnectivity()
        }
        .onReceive(NotificationCenter.default.publisher(for: .callFinished), perform: { _ in
            viewModel.calling = false
        })
    }
}

struct ReadyButtonDesign: View {
    var body: some View {
        Circle()
            .fill(Color(.green))
            .frame(width: 140, height: 140)
            .overlay(
                Image(systemName: "phone.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            )
    }
}

struct NotReadyButtonDesign: View {
    var body: some View {
        Circle()
            .fill(Color(.gray))
            .frame(width: 140, height: 140)
            .overlay(
                VStack {
                    Text("Tap to check")
                    Text("availability")
                }
            )
    }
}

struct CallingButtonDesign: View {
    var body: some View {
        Circle()
            .fill(Color(.red))
            .frame(width: 140, height: 140)
            .overlay(
                Image(systemName: "phone.fill.arrow.up.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
