import UIKit
import SDWebImage

class TrackCell: UITableViewCell {
    
    static let reuseTrackCellID = String(describing: TrackCell.self)
    
    //MARK: - Properties
        
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var cell: SearchViewModel.Cell?
    let userDefaults = UserDefaults.standard

    @IBAction func addSongTapped(_ sender: UIButton) {
        savingSong()
    }
    
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
        
        let savedSongs = userDefaults.savedSong()
        let isAdded = savedSongs.firstIndex(where: {
            $0.trackName == self.cell?.trackName && $0.artistName == self.cell?.artistName }) != nil
        
        if isAdded {
            addButton.isHidden = true
        } else {
            addButton.isHidden = false
        }
        
        songNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        albumNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconUrlString ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
    
    func savingSong() {
        guard let cell = cell else { return }
        var arrayOfSongs = userDefaults.savedSong()
        addButton.isHidden = true
        
        arrayOfSongs.append(cell)
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: arrayOfSongs, requiringSecureCoding: false) {
            userDefaults.set(savedData, forKey: UserDefaults.addedKeySong)
        }
    }
}
