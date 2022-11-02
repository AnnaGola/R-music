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
    
//MARK: - Outlets
    
    @IBOutlet weak var table: UITableView!

//MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.showsVerticalScrollIndicator = false
        setupSearchBar()
        setupTableView()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map{ $0 as? UIWindowScene}
            .compactMap{ $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first //stackOverFlow
        
        let tabBarVC = keyWindow?.rootViewController as? TabBarController
        tabBarVC?.songPlayer.delegate = self
        
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
