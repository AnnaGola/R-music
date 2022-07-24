//
//  TrackCellProtocol.swift
//  R • music
//
//  Created by anna on 24.07.2022.
//

import UIKit

protocol TrackCellProtocol {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}
