//
//  TabBar+.swift
//  R • music
//
//  Created by anna on 01.08.2022.
//

import UIKit

extension TabBarController: TabBarControllerDelegate {
    
    func maxSizeSongPlayer(viewModel: SearchViewModel.Cell?) {
        minTopAnchor.isActive = false
        maxTopAnchor.isActive = true
        bottomAnchor.constant = 0
        maxTopAnchor.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.songPlayer.miniSongPlayer.alpha = 0
            self.songPlayer.maxStackView.alpha = 1
            self.songPlayer.maskImageView.alpha = 1
        }
        guard let viewModel = viewModel else { return }
        self.songPlayer.setPlayer(viewModel: viewModel)
    }
    
    func minSizeSongPlayer() {
        maxTopAnchor.isActive = false
        bottomAnchor.constant = view.frame.height
        minTopAnchor.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.songPlayer.miniSongPlayer.alpha = 1
            self.songPlayer.maxStackView.alpha = 0
        }
    }
}
