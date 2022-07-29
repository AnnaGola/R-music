//
//  SearchVC+.swift
//  R • music
//
//  Created by anna on 23.07.2022.
//

import UIKit

//MARK: - Delegate/DataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: TrackCell.reuseTrackCellID, for: indexPath) as! TrackCell
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
        
        cell.trackImageView.backgroundColor = #colorLiteral(red: 0.8330247998, green: 0.6323849559, blue: 0.5387441516, alpha: 1)
        cell.setCell(viewModel: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = searchViewModel.cells[indexPath.row]
        
        self.tabBarDelegate?.maxSizeSongPlayer(viewModel: cellViewModel)
    }
}

//MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
        })
    }
}

//MARK: - PlayAnotherSong

extension SearchViewController: PlayAnotherSong {
    
    private func getSong(isNextSong: Bool) -> SearchViewModel.Cell? {
        
        guard let indexPath = table.indexPathForSelectedRow else { return nil }
        table.deselectRow(at: indexPath, animated: true)
        
        var nextIndexPath: IndexPath!
        
        if isNextSong {
            nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if nextIndexPath.row == searchViewModel.cells.count {
                nextIndexPath.row = 0
            }
        } else {
            nextIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if nextIndexPath.row == -1 {
                nextIndexPath.row = searchViewModel.cells.count - 1
            }
        }
        table.selectRow(at: nextIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = searchViewModel.cells[nextIndexPath.row]
        
        return cellViewModel
    }
    
    
    func playPrevSong() -> SearchViewModel.Cell? {
        return getSong(isNextSong: false)
    }
    
    func playNextSong() -> SearchViewModel.Cell? {
        return getSong(isNextSong: true)
    }
}
