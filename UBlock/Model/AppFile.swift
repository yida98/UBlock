//
//  AppFile.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-03-31.
//

import Foundation
import AppKit

struct AppFile: Named, Indexed, Hashable, Codable {
    var name: String
    var image: URL?
    var id: Int = 0
    
    init(name: String, image: URL?) {
        self.name = name
        self.image = image
    }
    
    func getImage() -> NSImage? {
        if let url = image {
            return url.asNSImage()
        }
        return nil
    }
    
}
