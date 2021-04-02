//
//  AppFile.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation
import AppKit

struct AppFile: Named, Indexed, Hashable {
    var name: String
    var image: NSImage?
    var id: Int = 0
}