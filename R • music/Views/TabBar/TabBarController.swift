//
//  TabBarController.swift
//  R • music
//
//  Created by anna on 22.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSongPlayer()
        tabBar.tintColor = #colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
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
        
        let songPlayer: SongPlayer = SongPlayer.loadSongPlayer()
        view.insertSubview(songPlayer, belowSubview: tabBar)
    }
}
