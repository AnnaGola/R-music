//
//  TrackCell.swift
//  R • music
//
//  Created by anna on 24.07.2022.
//

import UIKit

protocol TrackCellProtocol {
    var iconUrlString: String? { get }
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
}

class TrackCell: UITableViewCell {
    
    static let reuseTrackCellID = "TrackCell"
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addSongTapped(_ sender: UIButton) {
    }
    
    func setCell(viewModel: TrackCellProtocol) {
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        albumNameLabel.text = viewModel.collectionName
        //image
    }
    
}
