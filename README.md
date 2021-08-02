# GFImageView

Remote image in SwiftUI.

Use this view to load remote images keeping backward compatibility with iOS 13. 
Internally AsyncImage is used when available, otherwise a custom view with an image loader represented by GFRemoteImageLoader. 

```swift
GFImageView(imageUrl: urlOfTheImage,
            placeHolderImage: Image(systemName: "xmark.octagon"))
    .frame(width: 100, height: 100)
```

if you don't specify a placeHolderImage the SF symbol exclamationmark.triangle is used. 

# License

GFImageView is available under the MIT license. See the LICENSE file for more info.
