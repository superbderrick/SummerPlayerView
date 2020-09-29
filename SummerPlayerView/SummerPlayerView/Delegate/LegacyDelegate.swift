

import UIKit
import AVKit

public enum SummerPlayerState {
    case readyToPlay
    case playing
    case pause
    case playedToTheEnd
    case error
}

public protocol LegacyDelegate where Self: UIView {
    
    var playerTimeDidChange: ((_ newTime: TimeInterval, _ duration: TimeInterval)->())? {get set}
    var playerDidChangeSize: ((PlayerDimension) -> ())? {get set}
    var playerCellForItem: ((UICollectionView, IndexPath)->(UICollectionViewCell))? {get set}
    var playerDidSelectItem: ((Int)->())? {get set}
    
    var totalDuration: CMTime? { get }
    var currentTime: CMTime? { get }
    
    func didLoadVideo(_ url: URL)
    func seekToTime(_ seekTime: CMTime)
    func playPause(_ isActive: Bool)
    func currentVideoIndex(_ index: Int ,_ url: URL )
    func didTappedPlayerScreenView(_ isTapped : Bool)
}



