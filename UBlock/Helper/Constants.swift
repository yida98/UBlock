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
    
    static let magnitude: [String] = ["Day", "Week", "Month", "Year"]
    static let selectionDefault = " "
}

enum CFBundleKey: String {
    case CFBundleIconFile
    case CFBundleIconName
}

enum Size {
    case small
    case medium
    case large
}
