import UIKit

class SearchInteractor: SearchBusinessLogic {
    var networkService = NetworkService()
    var presenter: SearchPresentationLogic?
    
    func makeRequest(request: Search.Model.Request.RequestType) {
        switch request {
        case .getTracks(let searchText):
            presenter?.presentData(response: Search.Model.Response.ResponseType.presentLoader)
            networkService.getData(searchText: searchText) { [weak self] trackModel in
                self?.presenter?.presentData(response: Search.Model.Response.ResponseType.presentTracks(trackModel: trackModel))
            }
        }
    }
}
