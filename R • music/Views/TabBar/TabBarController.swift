//
//  TabBarController.swift
//  R • music
//
//  Created by anna on 22.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let songPlayer: SongPlayer = SongPlayer.loadSongPlayer()
    var minTopAnchor: NSLayoutConstraint!
    var maxTopAnchor: NSLayoutConstraint!
    var bottomAnchor: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSongPlayer()
        tabBar.tintColor = #colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)
        
        searchVC.tabBarDelegate = self
        
        viewControllers = [
            createVC(rootVC: searchVC, image: #imageLiteral(resourceName: "search") , title: "Search"),
            createVC(rootVC: PlaylistVC(), image: #imageLiteral(resourceName: "library"), title: "Playlist")
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
        
        songPlayer.tabBarDelegate = self
        view.insertSubview(songPlayer, belowSubview: tabBar)
        
        songPlayer.translatesAutoresizingMaskIntoConstraints = false
        maxTopAnchor = songPlayer.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minTopAnchor = songPlayer.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        songPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomAnchor = songPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        bottomAnchor.isActive = true
        maxTopAnchor.isActive = true
    }
}

extension TabBarController: TabBarControllerDelegate {
    func maxSizeSongPlayer(viewModel: SearchViewModel.Cell?) {
        maxTopAnchor.constant = 0
        maxTopAnchor.isActive = true
        minTopAnchor.isActive = false
        bottomAnchor.constant = 0
        
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
