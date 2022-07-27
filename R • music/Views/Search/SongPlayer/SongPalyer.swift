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
    
    @IBOutlet weak var miniSongPlayer: UIView!
    @IBOutlet weak var miniNameOfTheSong: UILabel!
    @IBOutlet weak var miniImageOfTheSong: UIImageView!
    @IBOutlet weak var miniPlayOrPauseButton: UIButton!
    @IBOutlet weak var maxStackView: UIStackView!
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
    
    weak var delegate: PlayAnotherSong?
    weak var tabBarDelegate: TabBarControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songImageView.layer.cornerRadius = 5
        songPlayerSlider.thumbTintColor = .gray
        songPlayerSlider.maximumTrackTintColor = .systemGray4
        songPlayerSlider.minimumTrackTintColor = .systemGray2
    }

    //MARK: - Animation
    
    func bigSongIamge() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.songImageView.transform = .identity
        }
    }
    
    func smallSongImage() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            let scale: CGFloat = 0.8
            self.songImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func playOrPauseState() {
        if player.timeControlStatus == .paused {
            player.play()
            playOrPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlayOrPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            bigSongIamge()
        } else {
            player.pause()
            playOrPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlayOrPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            smallSongImage()
        }
    }
    
    
    //MARK: - IBActions
    
    @IBAction func dragDownSwipe(_ sender: UIButton) {
        
        self.tabBarDelegate?.minSizeSongPlayer()
    }

    @IBAction func leftScrollPressed(_ sender: UIButton) {
        let cellViewModel = delegate?.playPrevSong()
        guard let cellSong = cellViewModel else { return }
        self.setPlayer(viewModel: cellSong)
    }

    @IBAction func playOrPausePressed(_ sender: UIButton) {
        playOrPauseState()
    }

    @IBAction func rightScrollPressed(_ sender: UIButton) {
        let cellViewModel = delegate?.playNextSong()
        guard let cellSong = cellViewModel else { return }
        self.setPlayer(viewModel: cellSong)
    }

    @IBAction func volumeSliderChanged(_ sender: UISlider) {
        player.volume = volumeSlider.value
    }

    @IBAction func songTimeSliderChanged(_ sender: UISlider) {
        let percentage = songPlayerSlider.value
        guard let duration = player.currentItem?.duration else { return }
        let durationSec = CMTimeGetSeconds(duration)
        let timeInSecs = Float64(percentage) * durationSec
        let seekTime = CMTimeMakeWithSeconds(timeInSecs, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    
    // MARK: - Setup
    
    func setPlayer(viewModel: SearchViewModel.Cell) {
        miniNameOfTheSong.text = viewModel.trackName
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        playSong(previewUrl: viewModel.previewUrl)
        observeCurrentTime()
        playOrPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                            
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        miniImageOfTheSong.sd_setImage(with: url)
        songImageView.sd_setImage(with: url)
    }
    
    func playSong(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func observeCurrentTime() {
        let time = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            self?.currentTimeLabel.text = time.createString()
            
            let duration = self?.player.currentItem?.duration
            let currentDuration = ((duration ?? CMTimeMake(value: 1, timescale: 1)) - time).createString()
            self?.allTimeLabel.text = "\(currentDuration)"
            self?.updateTimeSlider()
        }
    }
    
    func updateTimeSlider() {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTime / duration
        self.songPlayerSlider.value = Float(percentage)
        
    }
}
