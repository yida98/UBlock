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
        Storage.shared.apps = AlphabetizedList<AppFile>()
        Storage.shared.appCategoryNames = Set<String>()
        Storage.shared.urls = Dictionary<URL, AppFile>()
        Storage.shared.appCategories = AlphabetizedList<AppCategory>()
        AppFinder.findApps()
    }
        
    static func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        
    }
    
}

// MARK: Retrieve User Information

extension HomeViewModel {
    
}
