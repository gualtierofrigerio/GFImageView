//
//  GFRemoteImageView.swift
//
//  Created by Gualtiero Frigerio on 29/07/21.
//

import SwiftUI

/// Load a remote image
/// You can use it in iOS 13 as it doesn't call AsyncImage
@available (iOS 13.0, *)
public struct RemoteImageView: View {
    @ObservedObject var imageLoader: RemoteImageLoader
    @State var image:UIImage = UIImage()
    
    public init(url: URL) {
        imageLoader = RemoteImageLoader(url: url)
    }
    
    public var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

@available (iOS 13.0, *)
struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: URL(string: "https://upload.wikimedia.org/wikipedia/en/9/95/Test_image.jpg")!)
    }
}

