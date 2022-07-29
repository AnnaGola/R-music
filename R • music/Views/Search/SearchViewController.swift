//
//  SearchViewController.swift
//  R • music
//
//  Created by anna on 23.07.2022.
//  Copyright (c) 2022. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchDisplayLogic {
  
    
//MARK: - Properties
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    let searchController = UISearchController(searchResultsController: nil)
    var searchViewModel = SearchViewModel.init(cells: [])
    var timer: Timer?
    lazy var loader = Loader()
    weak var tabBarDelegate: TabBarControllerDelegate?
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.showsVerticalScrollIndicator = false
        setupSearchBar()
        setupTableView()
        setup()
    }
    
//MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: TrackCell.reuseTrackCellID)
        table.tableFooterView = loader
    }
    
//MARK: - Routing

    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        
        switch viewModel {
        case .displayTracks(let searchViewModel):
            self.searchViewModel = searchViewModel
            table.reloadData()
            loader.hideActivityIndicator()
        case .displayLoader:
            loader.showActivityIndicator()
        }
    }
}
