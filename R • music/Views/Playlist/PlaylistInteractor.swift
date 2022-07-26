//
//  PlaylistInteractor.swift
//  R • music
//
//  Created by anna on 26.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PlaylistBusinessLogic {
  func makeRequest(request: Playlist.Model.Request.RequestType)
}

class PlaylistInteractor: PlaylistBusinessLogic {

  var presenter: PlaylistPresentationLogic?
  var service: PlaylistService?
  
  func makeRequest(request: Playlist.Model.Request.RequestType) {
    if service == nil {
      service = PlaylistService()
    }
  }
  
}
