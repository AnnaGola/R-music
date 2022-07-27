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
    
    var minTopAnchor: NSLayoutConstraint!
    var maxTopAnchor: NSLayoutConstraint!
    var bottumAnchor: NSLayoutConstraint!
    
    func setupSongPlayer() {
        
        let songPlayer: SongPlayer = SongPlayer.loadSongPlayer()
        songPlayer.tabBarDelegate = self
        view.insertSubview(songPlayer, belowSubview: tabBar)
        
        songPlayer.translatesAutoresizingMaskIntoConstraints = false
        maxTopAnchor = songPlayer.topAnchor.constraint(equalTo: view.topAnchor)
        minTopAnchor = songPlayer.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -65)
        songPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        songPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottumAnchor = songPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        
        bottumAnchor.isActive = true
        maxTopAnchor.isActive = true
    }
}

extension TabBarController: TabBarControllerDelegate {
    
    func minSizeSongPlayer() {
        maxTopAnchor.isActive = false
        minTopAnchor.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func maxSizeSongPlayer() {
        maxTopAnchor.isActive = true
        minTopAnchor.isActive = false
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
}
