//
//  HomeViewModel.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation
import Combine
import AppKit
import QuickLookThumbnailing

class HomeViewModel: ObservableObject {
    
    var apps: AlphabetizedList<AppFile>
    let query = NSMetadataQuery()
    
    private let fileManager = FileManager.default
    
    init() {
        self.apps = AlphabetizedList<AppFile>()
        findApps()
    }
        
    private func findApps() {
        
        let applicationsURLs = fileManager.urls(for: .allApplicationsDirectory, in: .allDomainsMask)
        let filteredURLs = applicationsURLs.filter { fileManager.fileExists(atPath: $0.path) }
        for filteredURL in filteredURLs {
            do {
                let results = try fileManager.contentsOfDirectory(at: filteredURL, includingPropertiesForKeys: nil, options: [])
                let filteredResults = results.filter { $0.path.hasSuffix(".app") }

                for appURL in filteredResults {
                    
                    apps.insert(AppFile(name: fileManager.displayName(atPath: appURL.path), image: getAppIcon(url: appURL)))
                }
            } catch {
                print("[ERROR] \(filteredURL)! \(error)")
            }
        }
        
    }
    
    private func killProcess() {
        let process = Process()
        
        let runningApps = NSWorkspace().runningApplications
        
        
    }
}

// MARK: Retrieve Apps
extension HomeViewModel {
    
    private func getAppIcon(url: URL) -> NSImage {
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
                
                if let iconURL = fileManager.recursiveGetFirstOccurence(url, matchRules: [iconRule]) {
                    if let image = iconURL.asNSImage() {
                        return image
                    } else { debugPrint("[ERROR] Could not produce image from \(iconURL.path)!!")}
                } else {
                    let wildIconRule = FileRule(value: ".icns", rule: .endsWith)
                    if let iconURL = fileManager.recursiveGetFirstOccurence(url, matchRules: [wildIconRule]) {
                        if let image = iconURL.asNSImage() {
                            return image
                        } else { debugPrint("[ERROR] Could not produce image from \(iconURL.path)!!")}
                    }
                    debugPrint("[ERROR] Could not find \(iconName) for \(url)")
                }
                
            }
        }
        
        return NSImage()
    }
    
    private func findInfoPlist(appURL: URL) -> URL? {
        
        let rule = FileRule(value: "/Info.plist", rule: .endsWith)
        
        let result = fileManager.recursiveGetFirstOccurence(appURL, matchRules: [rule])
        if result == nil { debugPrint("[ERROR] \(appURL) HAS NO INFO.PLIST!!") }
        return result
    }
    
    private func getPlistObject(_ plistURL: URL, key: Any) -> Any? {
        guard let dictionary = NSDictionary(contentsOf: plistURL) else {
            fatalError("[ERROR] NOT AN INFO.PLIST!!")
        }
        
        return dictionary.object(forKey: key)
    }
    
}
