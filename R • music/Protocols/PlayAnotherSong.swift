//
//  PlayAnotherSong.swift
//  R • music
//
//  Created by anna on 25.07.2022.
//

import UIKit

protocol PlayAnotherSong {
    func playPrevSong() -> SearchViewModel.Cell?
    func playNextSong() -> SearchViewModel.Cell?
}


