//
//  ContentView.swift
//  nyamoblocker
//
//  Created by devonly on 2020-12-04.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    @State var isEnable: Bool = UserDefaults(suiteName: "group.nyamoblocker.blockerList")?.object(forKey: "enabled") as? Bool ?? false
    @State var version: String = String(describing: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!)
    private let userDefaults = UserDefaults(suiteName: "group.nyamoblocker.blockerList")
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    Toggle("Block Ads", isOn: $isEnable)
                        .onReceive([isEnable].publisher.first()) { value in
                            userDefaults?.set(value, forKey: "enabled")
                        }
                    NavigationLink(destination: UpdateListView()) {
                        Text("Update List")
                    }
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

struct UpdateListView: View {
    private var blockListURL = "https://raw.githubusercontent.com/tkgstrator/NyamoBlocker/main/blockerList/blockerList.json"
    let destination: DownloadRequest.Destination = { _, _ in
//        let documentsURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.nyamoblock.blockerList")?.appendingPathComponent("blockerList.json")
        let pathUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.nyamoblocker.blockerList")!.appendingPathComponent("blockerList.json")
        let documentsURL = FileManager.default.urls(for: .sharedPublicDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent("blockerList.json")
        print(pathUrl.path)
        return (pathUrl, [.removePreviousFile, .createIntermediateDirectories])
    }
    var body: some View {
        Group {
            Text("Update")
                .navigationBarTitle("Update")
            Spacer()
        }
        .onAppear(){
            AF.download(blockListURL, to: destination)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                    case .failure(let error):
                        print(error)
                    }
                    
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
