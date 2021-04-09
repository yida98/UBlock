//
//  Constants.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-01.
//

import Foundation

struct Constants {
    
    static let directoryPath: String = FileManager.default.currentDirectoryPath
    static let sampleIconURL: URL = URL(fileURLWithPath: directoryPath+"Sample.jpeg")
    
    static let boundWidth: CGFloat = 150
}

enum CFBundleKey: String {
    case CFBundleIconFile
    case CFBundleIconName
}
