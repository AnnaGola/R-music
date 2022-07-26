//
//  PlaylistPresenter.swift
//  R • music
//
//  Created by anna on 26.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PlaylistPresentationLogic {
  func presentData(response: Playlist.Model.Response.ResponseType)
}

class PlaylistPresenter: PlaylistPresentationLogic {
  weak var viewController: PlaylistDisplayLogic?
  
  func presentData(response: Playlist.Model.Response.ResponseType) {
  
  }
  
}
