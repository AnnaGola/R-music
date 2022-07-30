//
//  TrackCell.swift
//  R • music
//
//  Created by anna on 24.07.2022.
//

import UIKit
import SDWebImage

class TrackCell: UITableViewCell {
    
//MARK: - Identifier
    
    static let reuseTrackCellID = "TrackCell"
    
//MARK: - Outlets
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
   
//MARK: - Actions
    
    @IBAction func addSongTapped(_ sender: UIButton) {
        savingSong()
    }
    
//MARK: - Properties
    
    var cell: SearchViewModel.Cell?
    
    
//MARK: - Methods
    
    override class func awakeFromNib() {
           super.awakeFromNib()
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           trackImageView.image = nil
    }
    
    func setCell(viewModel: SearchViewModel.Cell) {
        
        self.cell = viewModel
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        albumNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
    
    func savingSong() {
        let userDefaults = UserDefaults.standard
        guard let cell = cell else { return }
        var listOfSongs = [SearchViewModel.Cell]()
        
        if let savedSong = userDefaults.object(forKey: "song") as? Data {
            if let decodedSongs = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedSong) as? [SearchViewModel.Cell] {
                listOfSongs = decodedSongs
            }
        }
        listOfSongs.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: listOfSongs, requiringSecureCoding: false) {
            userDefaults.set(savedData, forKey: "song")
        }
    }
}
