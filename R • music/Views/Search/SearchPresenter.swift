import UIKit

class SearchPresenter: SearchPresentationLogic {
    var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        
        switch response {
        case .presentTracks(let trackModel):
            
            let cells = trackModel?.results.map({ track in
                cellViewModel(from: track)
            }) ?? []
            
            let searchViewModel = SearchViewModel.init(cells: cells)
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks(searchViewModel: searchViewModel))
            
        case .presentLoader:
            viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayLoader)
        }
    }
    
    private func cellViewModel(from track: Track) -> SearchViewModel.Cell {
        
        return SearchViewModel.Cell.init(iconUrlString: track.artworkUrl100 ?? "",
                                         trackName: track.trackName,
                                         collectionName: track.collectionName ?? "",
                                         artistName: track.artistName,
                                         previewUrl: track.previewUrl ?? "")
        
    }
}
