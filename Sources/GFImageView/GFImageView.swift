//
//  GFImageView.swift
//
//  Created by Gualtiero Frigerio on 29/07/21.
//

import SwiftUI

/// Use this view to load a remote image
/// The view is compatible with iOS 13 and uses AsyncImage only on 15
/// You can specify a url for the image and an optional placeholder
/// to display in case of an error loading the remote image
@available (iOS 13.0, *)
public struct GFImageView: View {
    var imageUrl: URL?
    var placeHolderImage: Image?
    
    public init(imageUrl: URL?, placeHolderImage: Image? ) {
        self.imageUrl = imageUrl
        self.placeHolderImage = placeHolderImage
    }
    
    public var body: some View {
        if let url = imageUrl {
            if #available(iOS 15, *) {
                AsyncImage(url: url) { phase in
                    viewForPhase(phase)
                }
            }
            else {
                RemoteImageView(url: url)
            }
        }
        else {
            placeholder
        }
    }
    
    @ViewBuilder
    private var placeholder: some View {
        if let placeHolderImage = placeHolderImage {
            placeHolderImage
        }
        else {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
        }
    }
    
    @available(iOS 15.0, *)
    @ViewBuilder
    private func viewForPhase(_ phase:AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .failure(let error):
            let _ = print("error \(error)")
            placeholder
        @unknown default:
            let _ = print("unknown phase \(phase)")
            placeholder
        }
    }
}

@available (iOS 13.0, *)
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        GFImageView()
    }
}
