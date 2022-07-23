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
                case some
                case getTracks
            }
        }
        
        struct Response {
            enum ResponseType {
                case some
                case presentTracks
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks
            }
        }
    }
}
