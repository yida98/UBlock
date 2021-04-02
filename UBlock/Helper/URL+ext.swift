//
//  URL+ext.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-01.
//

import Foundation
import AppKit

extension URL {
    var isDirectory: Bool {
        let values = try? resourceValues(forKeys: [.isDirectoryKey])
        return values?.isDirectory ?? false
    }
}

protocol MatchRule {
    associatedtype RuleType
    
    func matches(matchRule: RuleType) -> Bool
}
    
struct FileRule {
    var value: String
    var rule: FileRule.Rule
    
    enum Rule {
        case endsWith
        case startsWith
        case contains
    }
}

extension URL: MatchRule {
    typealias RuleType = FileRule
    
    func matches(matchRule: FileRule) -> Bool {
        switch matchRule.rule {
        case FileRule.Rule.endsWith:
            return path.hasSuffix(matchRule.value)
        case FileRule.Rule.startsWith:
            return path.hasPrefix(matchRule.value)
        case FileRule.Rule.contains:
            return path.contains(matchRule.value)
        }
    }
    
    func matches(matchRules: [FileRule]) -> Bool {
        for matchRule in matchRules {
            if !matches(matchRule: matchRule) {
                return false
            }
        }
        return true
    }

}

extension URL {
    func asNSImage() -> NSImage? {
        do {
            let data = try Data(contentsOf: self)
            if let icon = NSImage(data: data) {
                icon.size = CGSize(width: 60, height: 90)
                return icon
            }
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
