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
  
  var networkService = NetworkService()
  var presenter: SearchPresentationLogic?
  var service: SearchWorker?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchWorker()
    }
      
      switch request {
      case .getTracks(let searchText):
          networkService.parsJsonData(searchText: searchText) { [weak self] trackModel in
              self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(trackModel: trackModel))
          }
      }
  }
}
