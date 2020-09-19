

import Foundation

public struct PlayerItem {
    let title: String
    let url: String
    let thumbnail: String
    
    public init(title:String, url: String, thumbnail: String) {
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
    }
}
