//
//  ContentView.swift
//  nyamoblocker
//
//  Created by devonly on 2020-12-04.
//

import SwiftUI

struct ContentView: View {
    @State var isEnable: [Bool] = [false, false, false]
    @State var version: String = String(describing: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!)
    
    var body: some View {
        NavigationView {
//            Text("Version: \(version)")
//                .frame(maxWidth: .infinity)
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $isEnable[0]) {
                        Text("Block Ads")
                    }
                    Text("Update List")
                }
                Section(header: Text("Support")) {
                    Text("Follow @Herlingum")
                }
            }
            .navigationBarTitle("Nyamo Blocker")
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
