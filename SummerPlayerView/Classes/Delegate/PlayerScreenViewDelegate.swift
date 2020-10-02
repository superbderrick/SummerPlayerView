

import UIKit
import AVKit

protocol PlayerScreenViewDelegate {
    var playerCellForItem: ((UICollectionView, IndexPath)->(UICollectionViewCell))? {get set}
    var totalDuration: CMTime? { get }
    var currentTime: CMTime? { get }
    func didLoadVideo(_ url: URL)
    func playPause(_ isActive: Bool)
    func currentVideoIndex(_ index: Int ,_ url: URL )
    func didTappedPlayerScreenView(_ isTapped : Bool)
    func seekToTime(_ seekTime: CMTime)
    func didChangeSliderValue(_ seekTime: CMTime)
    func didSelectItem(_ index:Int)
    func didPressedMoreButton()
}



