import UIKit
import Alamofire

class NetworkService {
    
    func getData(searchText: String, complition: @escaping (TrackModel?) -> Void) {
        
        let url = "https://itunes.apple.com/search"
        let params = ["term": "\(searchText)", "limit": "100", "media": "music"]
    
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default).responseData { data in
            if let error = data.error {
                print(error.localizedDescription)
                complition(nil)
                return
            }
            
            guard let data = data.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let tracks = try decoder.decode(TrackModel.self, from: data)
                complition(tracks)
            } catch let jsonError {
                print(jsonError.localizedDescription)
                complition(nil)
            }
        }
    }
}
