import UIKit
import SDWebImage
import AVKit

class SongPlayer: UIView {

//MARK: - Outlets
    
    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
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
    @IBOutlet weak var playOrPauseButton: UIButton!

    
//MARK: - Actions

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
    
    
//MARK: - Properties
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()

    var delegate: PlayAnotherSong?
    weak var tabBarDelegate: TabBarControllerDelegate?
    

//MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songPlayerSlider.thumbTintColor = .gray
        songPlayerSlider.maximumTrackTintColor = .systemGray4
        songPlayerSlider.minimumTrackTintColor = .systemGray2
        setupGestures()
        backgroundImageView.blurBackgroung(style: .dark)
        maskImageView.addLayer(color: .black, opacity: 2, offSet: .zero, radius: 25, scale: true)
        songImageView.addRadius(cornerRadius: 10)
        maxStackView.insertSubview(maskImageView, at: 0)
    }

    
    func playSong(previewUrl: String?) {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func monitorTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.bigSongIamge()
        }
    }
    
    func observeCurrentTime() {
        let time = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            self?.currentTimeLabel.text = time.createString()
            
            let duration = self?.player.currentItem?.duration
            let currentDuration = ((duration ?? CMTimeMake(value: 1, timescale: 1)) - time).createString()
            self?.allTimeLabel.text = "-\(currentDuration)"
            self?.updateTimeSlider()
        }
    }
    
    func updateTimeSlider() {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTime / duration
        self.songPlayerSlider.value = Float(percentage)
    }

    
//MARK: - Animation
    
    func bigSongIamge() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.songImageView.transform = .identity
            self.maskImageView.transform = .identity
        }
    }
    
    func smallSongImage() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            let scaleMax: CGFloat = 0.8
            let scaleMin: CGFloat = 0.7
            self.songImageView.transform = CGAffineTransform(scaleX: scaleMax, y: scaleMax)
            self.maskImageView.transform = CGAffineTransform(scaleX: scaleMin, y: scaleMin + 0.05)
        }
    }
    
    func playOrPauseState() {
        if player.timeControlStatus == .paused {
            player.play()
            playOrPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            miniPlayOrPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            bigSongIamge()
        } else {
            player.pause()
            playOrPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            miniPlayOrPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            smallSongImage()
        }
    }
    
//MARK: - Setup Player
    
    func setPlayer(viewModel: SearchViewModel.Cell) {
        miniNameOfTheSong.text = viewModel.trackName
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        playSong(previewUrl: viewModel.previewUrl)
        monitorTime()
        observeCurrentTime()
        playOrPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        miniPlayOrPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        
        let string600 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        miniImageOfTheSong.sd_setImage(with: url)
        songImageView.sd_setImage(with: url)
        
        let string8 = viewModel.iconUrlString?.replacingOccurrences(of: "100x100", with: "8x8")
        guard let url = URL(string: string8 ?? "") else { return }
        backgroundImageView.sd_setImage(with: url)
    }
    
    
//MARK: - Setup Gestures
    
    func setupGestures() {
        miniSongPlayer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resizing)))
        miniSongPlayer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(paning)))
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dissmissPlayer)))
    }
                             
    @objc func paning(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .began:
            maskImageView.alpha = 0
        case .changed:
            paningChanged(gesture: gesture)
        case .ended:
            paningEnded(gesture: gesture)
        default:
            print("default state in padding")
        }
    }
    
    func paningChanged(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        let newTransperancy = 1 + translation.y / 50
        self.miniSongPlayer.alpha = newTransperancy < 0 ? 0 : newTransperancy
        self.maxStackView.alpha = -translation.y / 50
    }
    
    func paningEnded(gesture: UIPanGestureRecognizer) {
        let tranlation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.transform = .identity
            if tranlation.y < -25 && velocity.y < -50 {
                self.tabBarDelegate?.maxSizeSongPlayer(viewModel: nil)
            } else {
                self.miniSongPlayer.alpha = 1
                self.maxStackView.alpha = 0
            }
        }
    }
    
    @objc func dissmissPlayer(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.superview)
            maxStackView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            let translation = gesture.translation(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.maxStackView.transform = .identity
                
                if translation.y > 100 {
                    self.tabBarDelegate?.minSizeSongPlayer()
                }
            }
        default:
            let translation = gesture.translation(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
                self.maxStackView.transform = .identity
                if translation.y > 100 {
                    self.tabBarDelegate?.minSizeSongPlayer()
                }
            }
        }
    }
    
     @objc func resizing() {
         self.tabBarDelegate?.maxSizeSongPlayer(viewModel: nil)
    }
}
