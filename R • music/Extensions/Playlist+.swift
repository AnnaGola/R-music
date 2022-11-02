import UIKit
import SwiftUI

extension Playlist: PlayAnotherSong {
    
    func playPrevSong() -> SearchViewModel.Cell? {

        let index = songs.firstIndex(of: song)
        guard let currentIndex = index else { return nil }
        
        var prevIndex: SearchViewModel.Cell
        if currentIndex - 1 == -1 {
            prevIndex = songs[songs.count - 1]
        } else {
            prevIndex = songs[currentIndex - 1]
        }
        self.song = prevIndex
        return prevIndex
    }
    
    func playNextSong() -> SearchViewModel.Cell? {
        
        let index = songs.firstIndex(of: song)
        guard let currentIndex = index else { return nil }
        
        var nextIndex: SearchViewModel.Cell
            if currentIndex + 1 == songs.count {
                nextIndex = songs[0]
            } else {
                nextIndex = songs[currentIndex + 1]
            }
        
        self.song = nextIndex
        return nextIndex
    }
}

