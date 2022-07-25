//
//  SongPalyer.swift
//  R • music
//
//  Created by anna on 24.07.2022.
//

import UIKit
import SDWebImage
import AVKit

class SongPlayer: UIView {
    
    @IBOutlet weak var blurryBackgroundImageView: UIImageView!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var songPlayerSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var allTimeLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var minVolumeImageView: UIImageView!
    @IBOutlet weak var maxVolumeImageView: UIImageView!
    @IBOutlet weak var playOrPauseButton: UIButton!
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }

    @IBAction func dragDownSwipe(_ sender: UIButton) {
        self.removeFromSuperview()
    }

    @IBAction func leftScrollPressed(_ sender: UIButton) {
    }

    @IBAction func playOrPausePressed(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            playOrPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.pause()
            playOrPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }

    @IBAction func rightScrollPressed(_ sender: UIButton) {
    }

    @IBAction func volumeSliderChanged(_ sender: UISlider) {
    }

    @IBAction func songTimeSliderChanged(_ sender: UISlider) {
    }
    
    
    func setPlayer(viewModel: SearchViewModel.Cell) {
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        playSong(previewUrl: viewModel.previewUrl)
        
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        songImageView.sd_setImage(with: url)
        
        let string5 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "5x5")
        guard let url = URL(string: string5 ?? "") else { return }
        blurryBackgroundImageView.sd_setImage(with: url)
    }
    
    func playSong(previewUrl: String?) {
        
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}
