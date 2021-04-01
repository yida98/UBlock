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
    
    init() {
        self.apps = AlphabetizedList<AppFile>()
        findApps()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private func findApps() {
        let fileManager = FileManager.default
        
        let applicationsURLs = fileManager.urls(for: .allApplicationsDirectory, in: .allDomainsMask)
        let filteredURLs = applicationsURLs.filter { fileManager.fileExists(atPath: $0.path) }
        for filteredURL in filteredURLs {
            do {
                let results = try fileManager.contentsOfDirectory(at: filteredURL, includingPropertiesForKeys: [URLResourceKey.thumbnailKey], options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                let filteredResults = results.filter { $0.path.hasSuffix(".app") }

                for url in filteredResults {
                    generateThumbnail(for: url)
                        .sink(receiveCompletion: { (completion) in
                            switch completion {
                                case .failure:
                                    debugPrint("[ERROR] Thumbnail generation error!!")
                                case .finished:
                                    debugPrint("Finished generating thumbnail...")
                            }

                        }, receiveValue: {
                            self.apps.insert(AppFile(name: fileManager.displayName(atPath: url.path), image: $0))
                            self.apps.reindex()
                        })
                        .store(in: &cancellableSet)
                }
            } catch {
                print("Error at \(filteredURL)! \(error)")
            }
        }
        
    }
    
    private func generateThumbnail(for url: URL) -> AnyPublisher<NSImage, Error> {
        return Future<NSImage, Error> { promise in
            
            let size: CGSize = CGSize(width: 10, height: 90)
            
            // Create the thumbnail request.
            let request = QLThumbnailGenerator.Request(fileAt: url,
                                                       size: size,
                                                       scale: 1,
                                                       representationTypes: .all)
            
            let generator = QLThumbnailGenerator.shared
            generator.generateBestRepresentation(for: request) { (thumbnailRepresentation, error) in
                if let thumbnail = thumbnailRepresentation {
                    promise(.success(thumbnail.nsImage))
                } else if let er = error {
                    promise(.failure(er))
                }
            }

        }.eraseToAnyPublisher()
    }
//
//    private func fetchApps() {
//        let predicate = NSPredicate(format: "kMDItemContentType == 'com.apple.application-bundle'")
//
//        NotificationCenter.default.addObserver(self, selector: #selector(queryDidFinish(_:)), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: nil)
//        query.predicate = predicate
//        query.start()
//    }
//
//    @objc
//    private func queryDidFinish(_ notification: NSNotification) {
//        print("Did receive")
//        for result in query.results {
//            guard let item = result as? NSMetadataItem else {
//                print("NOT METADATAITEM?!")
//                continue
//            }
//            print("result: \(item.value(forAttribute: kMDItemDisplayName as String) ?? "")")
//        }
//    }
//
}

extension URL {
    var isDirectory: Bool {
        let values = try? resourceValues(forKeys: [.isDirectoryKey])
        return values?.isDirectory ?? false
    }
}
