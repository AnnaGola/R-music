//
//  TabBarControllerDelegate.swift
//  R • music
//
//  Created by anna on 27.07.2022.
//

import UIKit

protocol TabBarControllerDelegate: class {
    func minSizeSongPlayer()
    func maxSizeSongPlayer(viewModel: SearchViewModel.Cell?)
}
