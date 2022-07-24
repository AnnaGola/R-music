//
//  SearchVC+.swift
//  R • music
//
//  Created by anna on 23.07.2022.
//

import UIKit


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: TrackCell.reuseTrackCellID, for: indexPath) as! TrackCell
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
        
        var cellColor = cell.trackImageView.backgroundColor
        cellColor  = #colorLiteral(red: 0.8330247998, green: 0.6323849559, blue: 0.5387441516, alpha: 1)
        cell.trackImageView.image = UIImage(named: cellViewModel.iconUrlString ?? String(describing: cellColor))
        cell.artistNameLabel.text = cellViewModel.artistName
        cell.albumNameLabel.text = cellViewModel.collectionName
        cell.songNameLabel.text = cellViewModel.trackName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
        })
    }
}
