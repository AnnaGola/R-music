//
//  TrackModel.swift
//  R • music
//
//  Created by anna on 22.07.2022.
//

import UIKit


struct TrackModel: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var artistName: String
    var trackName: String
    var collectionName: String?
    var artworkUrl100: String?
    var previewUrl: String?
}
