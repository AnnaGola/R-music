//
//  PlaylistViewController.swift
//  R • music
//
//  Created by anna on 26.07.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PlaylistDisplayLogic: class {
  func displayData(viewModel: Playlist.Model.ViewModel.ViewModelData)
}

class PlaylistViewController: UIViewController, PlaylistDisplayLogic {

  var interactor: PlaylistBusinessLogic?
  var router: (NSObjectProtocol & PlaylistRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = PlaylistInteractor()
    let presenter             = PlaylistPresenter()
    let router                = PlaylistRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: Playlist.Model.ViewModel.ViewModelData) {

  }
  
}
