//
//  SearchPresenter.swift
//  R • music
//
//  Created by anna on 23.07.2022.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit


protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
  
      switch response {
      case .some:
          print("presenter some")
          
      case .presentTracks(let trackModel):
          
          let cells = trackModel?.results.map({ track in
              cellViewModel(from: track)
          }) ?? []
          
          let searchViewModel = SearchViewModel.init(cells: cells)
          print("presentor present tracks")
          viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
      }
  }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        
        return SearchViewModel.Cell.init(iconUrlString: track.artworkUrl100 ?? "",
                                         trackName: track.trackName,
                                         collectionNAme: track.collectionName ?? "",
                                         artistName: track.artistName)
        
    }
}
