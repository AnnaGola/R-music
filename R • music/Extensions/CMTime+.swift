import UIKit
import CoreMedia

extension CMTime {
    func createString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minuts = totalSeconds / 60
        let timeFormString = String(format: "%02d:%02d", minuts, seconds)
        return timeFormString
    }
}

