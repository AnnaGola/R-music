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
        tabBar.tintColor = #colorLiteral(red: 0.8448515534, green: 0.6441723704, blue: 0.5505579114, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setupSongPlayer()
        searchVC.tabBarDelegate = self
        
        var playlist = Playlist()
        playlist.tabBarDelegate = self
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
    
    func createCVC(rootVC: UICollectionViewController, image: UIImage, title: String) -> UIViewController {
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
