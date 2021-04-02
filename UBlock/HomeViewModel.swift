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
                print("Error at \(filteredURL)! \(error)")
            }
        }
        
    }
    
    private func getAppIcon(url: URL) -> NSImage {
        if let infoPlistURL = findInfoPlist(appURL: url) {
            if let iconName = getPlistObject(infoPlistURL, key: "CFBundleIconFile") as? String {
                var iconRule = FileRule(value: iconName, rule: .endsWith)
                if !iconName.hasSuffix(".icns") {
                    iconRule = FileRule(value: iconName+".icns", rule: .endsWith)
                }
                
                if let iconURL = fileManager.recursiveGetFirstOccurence(url, matchRules: [iconRule]) {
                    return iconURL.asNSImage() ?? NSImage()
                }
            }
        } else {
            debugPrint("[ERROR] \(url.path) has no info.plist!!")
        }
        
        return NSImage()
    }
    
    private func findInfoPlist(appURL: URL) -> URL? {
        
        let rule = FileRule(value: "Info.plist", rule: .endsWith)
        
        let result = fileManager.recursiveGetFirstOccurence(appURL, matchRules: [rule])
        
        return result
    }
    
    private func getPlistObject(_ plistURL: URL, key: Any) -> Any? {
        guard let dictionary = NSDictionary(contentsOf: plistURL) else {
            fatalError("[ERROR] NOT AN INFO.PLIST!!")
        }
        
        return dictionary.object(forKey: key)
    }
}

extension FileManager {
    
    func getContents(_ url: URL, with components: String = "",propertiesForKeys: [URLResourceKey]?, options: DirectoryEnumerationOptions) -> [URL] {
        var fullURL = url
        fullURL.appendPathComponent(components)
        do {
            let contents = try self.contentsOfDirectory(at: fullURL, includingPropertiesForKeys: propertiesForKeys, options: options)
            return contents
        } catch {
            debugPrint("Error")
        }
        return [URL]()
    }
    
    func recursiveGetFirstOccurence(_ url: URL, matchRules: [FileRule]) -> URL? {
        let queue = Queue<URL>()
        queue.enqueue(url)
        while !queue.isEmpty {
            if let item = queue.dequeue() {
                if item.matches(matchRules: matchRules) { return item }
                if item.isDirectory {
                    queue.enqueue(getContents(item, propertiesForKeys: [], options: []))
                }
            }
        }

        return nil
    }
    
    func recursiveGetContents(_ url: URL, matchRules: [FileRule]) -> [URL] {
        var result = [URL]()
        let contents = getContents(url, propertiesForKeys: [], options: [])
        
        for content in contents {
            if content.isDirectory {
                result.append(contentsOf: recursiveGetContents(content, matchRules: matchRules))
            }
            if content.matches(matchRules: matchRules) {
                result.append(content)
            }
        }
        
        return result
    }
    
}
