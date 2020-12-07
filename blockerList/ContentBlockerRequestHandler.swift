//
//  ContentBlockerRequestHandler.swift
//  css
//
//  Created by devonly on 2020-12-04.
//

import UIKit
import MobileCoreServices

let groupID = "group.nyamoblocker.blockerList"

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func loadBlockerList(context: NSExtensionContext) {
        
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
    }
    
    func beginRequest(with context: NSExtensionContext) {
        let fileManager = FileManager.default
        let ruleFilePath = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupID)?.appendingPathComponent("blockerList.json")
        
        if fileManager.fileExists(atPath: ruleFilePath!.path) {
            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
//            let attachment = NSItemProvider(contentsOf: ruleFilePath!)!
            
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        } else {
            let attachment = NSItemProvider(contentsOf: Bundle.main.url(forResource: "blockerList", withExtension: "json"))!
            
            let item = NSExtensionItem()
            item.attachments = [attachment]
            
            context.completeRequest(returningItems: [item], completionHandler: nil)
        }
    }
    
}
