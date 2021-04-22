//
//  AppFinder.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-12.
//

import Foundation
import AppKit

class AppFinder {
        
    static private let fileManager = FileManager.default
    
    static func findApps() -> Bool {
        
        let applicationsURLs = AppFinder.fileManager.urls(for: .allApplicationsDirectory, in: .allDomainsMask)
        let filteredURLs = applicationsURLs.filter { fileManager.fileExists(atPath: $0.path) }
        for filteredURL in filteredURLs {
            do {
                let results = try AppFinder.fileManager.contentsOfDirectory(at: filteredURL, includingPropertiesForKeys: nil, options: [])
                let filteredResults = results.filter { $0.path.hasSuffix(".app") }

                for appURL in filteredResults {
                    let appFile = AppFile(name: AppFinder.fileManager.displayName(atPath: appURL.path), image: getAppIconURL(from: appURL))
                    
                    Storage.shared.apps.insert(appFile)
                }
                return true
            } catch {
                print("[ERROR] \(filteredURL)! \(error)")
            }
        }
        return false
        
    }
    
    private func killProcess() {
        let process = Process()
        
        let runningApps = NSWorkspace().runningApplications
        
        
    }
    
    static private func getAppIconURL(from url: URL) -> URL? {
        if let infoPlistURL = findInfoPlist(appURL: url) {
            var name: String?
            if let iFile = getPlistObject(infoPlistURL, key: CFBundleKey.CFBundleIconFile.rawValue) as? String {
                name = iFile
            } else if let iName = getPlistObject(infoPlistURL, key: CFBundleKey.CFBundleIconName.rawValue) as? String {
                name = iName
            }
            if let iconName = name {
                var iconRule = FileRule(value: iconName, rule: .endsWith)
                if !iconName.hasSuffix(".icns") {
                    iconRule = FileRule(value: iconName+".icns", rule: .endsWith)
                }
                
                if let iconURL = AppFinder.fileManager.recursiveGetFirstOccurence(url, matchRules: [iconRule]) {
                    return iconURL
                } else {
                    let wildIconRule = FileRule(value: ".icns", rule: .endsWith)
                    if let iconURL = AppFinder.fileManager.recursiveGetFirstOccurence(url, matchRules: [wildIconRule]) {
                        return iconURL
                    }
                    debugPrint("[ERROR] Could not find \(iconName) for \(url)")
                }
                
            }
        }
        
        return nil
    }
    
    static private func findInfoPlist(appURL: URL) -> URL? {
        
        let rule = FileRule(value: "/Info.plist", rule: .endsWith)
        
        let result = AppFinder.fileManager.recursiveGetFirstOccurence(appURL, matchRules: [rule])
        if result == nil { debugPrint("[ERROR] \(appURL) HAS NO INFO.PLIST!!") }
        return result
    }
    
    static private func getPlistObject(_ plistURL: URL, key: Any) -> Any? {
        guard let dictionary = NSDictionary(contentsOf: plistURL) else {
            fatalError("[ERROR] NOT AN INFO.PLIST!!")
        }
        
        return dictionary.object(forKey: key)
    }
}
