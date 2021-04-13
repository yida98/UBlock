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
    
    private let query = NSMetadataQuery()
        
    private let fileManager = FileManager.default
    
    init() {
        AppFinder.findApps()
    }
        
    
}

// MARK: Retrieve User Information

extension HomeViewModel {
    
}
