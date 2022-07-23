//
//  SearchVC.swift
//  R • music
//
//  Created by anna on 22.07.2022.
//

import UIKit
import Alamofire

class SearchVC: UITableViewController {
    
    var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let songs = [Track(artistName: "Billie Eilish", trackName: "bad guy", collectionName: ""),
                 Track(artistName: "Adele", trackName: "hello", collectionName: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = "\(song.trackName)\n\(song.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "library")
        return cell
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://itunes.apple.com/search?term=\(searchText)"
            
            AF.request(url).responseData { data in
                if let error = data.error {
                    print("errrroroorooror \(error)")
                    return
                }
                
                guard let data = data.data else { return }
                
                let decoder = JSONDecoder()
                do {
                    let track = try decoder.decode(TrackModel.self, from: data)
                    print(track)
                } catch {
                    print(error)
                }
        }
      })
    }
}
