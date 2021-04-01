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
//    private var publisher: AnyPublisher<[NSMetadataItem], Never>
    let query = NSMetadataQuery()
    
    init() {
        self.apps = AlphabetizedList<AppFile>()
        findApps()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    func findApps() {
        let fileManager = FileManager.default
        do {
            let applicationsURL = fileManager.urls(for: .applicationDirectory, in: .systemDomainMask)
            let results = try fileManager.contentsOfDirectory(at: applicationsURL[0], includingPropertiesForKeys: [URLResourceKey.thumbnailKey], options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            print(results)
            for url in results {
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
                    })
                    .store(in: &cancellableSet)
            }
        } catch {
            print("Error! \(error)")
        }
    }
    
    private func generateThumbnail(for url: URL) -> AnyPublisher<NSImage, Error> {
        return Future<NSImage, Error> { promise in
            
            let size: CGSize = CGSize(width: 60, height: 90)
            
            // Create the thumbnail request.
            let request = QLThumbnailGenerator.Request(fileAt: url,
                                                       size: size,
                                                       scale: 1,
                                                       representationTypes: .all)
            
            let generator = QLThumbnailGenerator.shared
            generator.generateRepresentations(for: request) { (thumbnail, type, error) in
                if let tn = thumbnail {
                    promise(.success(tn.nsImage))
                } else if thumbnail == nil || error != nil {
                    // Handle the error case gracefully.
                    if let er = error {
                        promise(.failure(er))
                    }
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
