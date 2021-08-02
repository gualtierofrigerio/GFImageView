//
//  GFRemoteImageLoader.swift
//
//  Created by Gualtiero Frigerio on 29/07/21.
//

import Combine
import Foundation

@available(iOS 13.0, *)
public class RemoteImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(url: URL) {
        loadFromURL(url)
    }
    
    private func loadFromURL(_ url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
