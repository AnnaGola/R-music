//
//  SearchModels.swift
//  R • music
//
//  Created by anna on 23.07.2022.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getTracks(searchText: String)
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentTracks(trackModel: TrackModel?)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayTracks(searchViewModel: SearchViewModel)
            }
        }
    }
}

struct SearchViewModel {
    
    struct Cell: TrackCellProtocol {
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
        var previewUrl: String?
    }
    
    let cells: [Cell]
    
}
