//
//  UserDefaults+.swift
//  R • music
//
//  Created by anna on 30.07.2022.
//

import UIKit

extension UserDefaults {
    
    static let addedKeySong = "addedKeySong"
    
    func savedSong() -> [SearchViewModel.Cell] {
        let defaults = UserDefaults.standard
        
        guard let savedSongs = defaults.object(forKey: UserDefaults.addedKeySong) as? Data else { return [] }
        
        guard let decodedSong = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedSongs) as? [SearchViewModel.Cell] else { return [] }
        
        return decodedSong
    }
    
}
