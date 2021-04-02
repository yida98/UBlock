//
//  FileManager+ext.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-01.
//

import Foundation

extension FileManager {
    
    func getContents(_ url: URL, with components: String = "",propertiesForKeys: [URLResourceKey]?, options: DirectoryEnumerationOptions) -> [URL] {
        var fullURL = url
        fullURL.appendPathComponent(components)
        do {
            let contents = try contentsOfDirectory(at: fullURL, includingPropertiesForKeys: propertiesForKeys, options: options)
            return contents
        } catch {
            debugPrint(error)
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
