

import UIKit
import AVKit

 protocol LegacyDelegate where Self: UIView {
    
    var playerCellForItem: ((UICollectionView, IndexPath)->(UICollectionViewCell))? {get set}
    var totalDuration: CMTime? { get }
    var currentTime: CMTime? { get }
    func didLoadVideo(_ url: URL)
    func seekToTime(_ seekTime: CMTime)
    func playPause(_ isActive: Bool)
    func currentVideoIndex(_ index: Int ,_ url: URL )
    func didTappedPlayerScreenView(_ isTapped : Bool)
    func didSelectItem(_ index:Int)
}



