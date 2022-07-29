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
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: cell, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "song")
        }
    }
}
