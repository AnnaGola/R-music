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
        
        let search = SearchVC()
        let navVC = UINavigationController(rootViewController: search)
        navVC.tabBarItem.image = UIImage(named: "search")
        navVC.tabBarItem.title = "Search"
        search.navigationItem.title = "Search"
        navVC.navigationBar.prefersLargeTitles = true
        
        let playlist = PlaylistVC()
        let navVC2 = UINavigationController(rootViewController: playlist)
        navVC2.tabBarItem.image = UIImage(named: "library")
        navVC2.tabBarItem.title = "Playlist"
        playlist.navigationItem.title = "Playlist"
        navVC2.navigationBar.prefersLargeTitles = true
        
        viewControllers = [navVC, navVC2]
    }
}
