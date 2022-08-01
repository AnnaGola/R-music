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
    var minTopAnchor: NSLayoutConstraint!
    var maxTopAnchor: NSLayoutConstraint!
    var bottomAnchor: NSLayoutConstraint!
    
    
//MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 0.8425114751, green: 0.6422668695, blue: 0.550950408, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupSongPlayer()
        searchVC.tabBarDelegate = self
        
        let playlist = Playlist()
        let hostVC = UIHostingController(rootView: playlist)
        hostVC.tabBarItem.image = #imageLiteral(resourceName: "library")
        hostVC.tabBarItem.title = "Playlist"
        
        
        viewControllers = [
            hostVC,
            createVC(rootVC: searchVC, image: #imageLiteral(resourceName: "search") , title: "Search")
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
