//
//  SearchInteractor.swift
//  R • music
//
//  Created by anna on 23.07.2022.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {

  var presenter: SearchPresentationLogic?
  var service: SearchWorker?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchWorker()
    }
      
      switch request {
      case .some:
          print("interactor some")
          presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks)
      case .getTracks:
          print("interactor get tracks")
          presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks)
      }
  }
  
}
