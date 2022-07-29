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
        
    }
    
//MARK: - Methods
    
    override class func awakeFromNib() {
           super.awakeFromNib()
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           trackImageView.image = nil
    }
    
    func setCell(viewModel: TrackCellProtocol) {
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        albumNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
}
