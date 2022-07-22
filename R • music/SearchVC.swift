//
//  SearchVC.swift
//  R • music
//
//  Created by anna on 22.07.2022.
//

import UIKit

class SearchVC: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let songs = [TrackModel(trackName: "bad guy", artistName: "Billie Eilish"),
                TrackModel(trackName: "hello", artistName: "Adele")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSearchBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
