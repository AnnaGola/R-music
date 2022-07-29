//
//  TabBarController.swift
//  R • music
//
//  Created by anna on 22.07.2022.
//

import UIKit
import SwiftUI

class TabBarController: UITabBarController {
    
//MARK: - Properties
    
    let songPlayer: SongPlayer = SongPlayer.loadSongPlayer()
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    private var minTopAnchor: NSLayoutConstraint!
    private var maxTopAnchor: NSLayoutConstraint!
    private var bottomAnchor: NSLayoutConstraint!
    
    
//MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)
        setupSongPlayer()
        searchVC.tabBarDelegate = self
        
        let playlist = Playlist()
        let hostVC = UIHostingController(rootView: playlist)
        
        viewControllers = [
            createVC(rootVC: searchVC, image: #imageLiteral(resourceName: "search") , title: "Search"),
            hostVC
        ]
    }
    
    func createVC(rootVC: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.image = image
        navVC.tabBarItem.title = title
        rootVC.navigationItem.title = title
        navVC.navigationBar.prefersLargeTitles = true
        return navVC
    }
    
    func setupSongPlayer() {
        
        songPlayer.translatesAutoresizingMaskIntoConstraints = false
        songPlayer.tabBarDelegate = self
        songPlayer.delegate = searchVC
        view.insertSubview(songPlayer, belowSubview: tabBar)
        
        maxTopAnchor = songPlayer.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minTopAnchor = songPlayer.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchor = songPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        songPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        bottomAnchor.isActive = true
        maxTopAnchor.isActive = true
    }
}

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
