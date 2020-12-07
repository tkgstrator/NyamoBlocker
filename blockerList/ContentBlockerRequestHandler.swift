//
//  ContentBlockerRequestHandler.swift
//  css
//
//  Created by devonly on 2020-12-04.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func loadBlockerList(context: NSExtensionContext) {
        
        #if DEBUG
        // ローカルファイル読み込み
        let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
//        let fileManager = FileManager.default
//        let ruleFilePath = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.nyamoblocker.blockerList")?.appendingPathComponent("blockerList.json")
//        if fileManager.fileExists(atPath: ruleFilePath!.path) {
//            let attachment = NSItemProvider(contentsOf: ruleFilePath!)!
//
//            let item = NSExtensionItem()
//            item.attachments = [attachment]
//
//            context.completeRequest(returningItems: [item], completionHandler: nil)
//        } else {
//            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
//
//            let item = NSExtensionItem()
//            item.attachments = [attachment]
//
//            context.completeRequest(returningItems: [item], completionHandler: nil)
//        }
        #else
        let fileManager = FileManager.default
        let ruleFilePath = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.nyamoblocker.blockerList")?.appendingPathComponent("blockerList.json")
        if fileManager.fileExists(atPath: ruleFilePath!.path) {
            let attachment = NSItemProvider(contentsOf: ruleFilePath!)!
            
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        } else {
            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
            
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        }
        #endif
    }
    
    func beginRequest(with context: NSExtensionContext) {
        loadBlockerList(context: context)

        let enabled: Bool = UserDefaults(suiteName: "group.nyamoblocker.blockerList")?.object(forKey: "enabled") as? Bool ?? false

        switch enabled {
        case true:
            loadBlockerList(context: context)
        case false:
            loadBlockerList(context: context)
        }
    }
    
}
