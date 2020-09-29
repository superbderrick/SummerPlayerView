

import Foundation
import AVKit


public enum ScreenMode {
    case tiny
    case fullScreen
}

open class SummerPlayerView: UIView {
    
    public var playerCellForItem: ((UICollectionView, IndexPath)->(UICollectionViewCell))? = nil
    
    public var totalDuration: CMTime? {
        return self.queuePlayer.currentItem?.asset.duration
    }
    
    public var currentTime: CMTime? {
        return self.queuePlayer.currentTime()
    }
    
    private var contents: [Content]?
    
    private var isTouched = false
    
    private var currentVideoIndex = 0
    
    private var queuePlayer: AVQueuePlayer!
    
    private var playerLayer: AVPlayerLayer?
    
    private let playListView = PlayListView()
    
    private var playerScreenView = PlayerScreenView()
    
    private var playerControlView = PlayerControllView()
    
    private var configuration: SummerPlayerViewConfiguration = InternalConfiguration()
    
    private var theme: SummerPlayerViewTheme = MainTheme()
    
    private var internalDelegate: LegacyDelegate?
    
    open var delegate: SummerPlayerViewDelegate?
    
    
    
    
    
    required public init(configuration: SummerPlayerViewConfiguration?, theme: SummerPlayerViewTheme?, viewRect: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.bounds = viewRect
        
        if let theme = theme {
            self.theme = theme
        }
        if let configuration = configuration {
            self.configuration = configuration
        }
        
        setupPlayer()
        setupSummerPlayerView(viewRect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupPlayer()
        setupSummerPlayerView(nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupPlayer()
        setupSummerPlayerView(nil)
    }
    
    private func regulatePlayerView(isFullScreen:Bool) {
        var playerViewRect : CGRect
        
        if isFullScreen {
            playerViewRect = self.bounds
        } else {
            playerViewRect = Utills.getWholeViewRect(self.bounds)!
        }
        
        playerLayer?.frame = playerViewRect
    }
    
    
    func didRegisterPlayerItemCell(_ identifier: String, collectioViewCell cell: UICollectionViewCell.Type) {
        playListView.didRegisterPlayerItemCell(identifier, collectioViewCell: cell)
    }
    
    public func setPlayList(currentItem: Content, items: [Content]) {
        
        self.contents = items
        self.currentVideoIndex = 0
        
        if let url = URL(string: currentItem.url) {
            didLoadVideo(url)
        }
        
        playListView.setPlayList(currentItem: currentItem, items: items)
    }
    
    
    private func setupSummerPlayerView( _ viewRect: CGRect?) {
        if(viewRect != nil) {
            let wholeViewRect = Utills.getWholeViewRect(viewRect!)
            
            setupInsideViews(wholeViewRect , wholeRect: viewRect)
            
            bringSubviewToFront(playListView)
            bringSubviewToFront(playerControlView)
            bringSubviewToFront(playerScreenView)
            
        }
        
    }
    
    
    private func setupPlayer() {
        queuePlayer = AVQueuePlayer()
        queuePlayer.addObserver(playListView, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer?.backgroundColor = UIColor.black.cgColor
        playerLayer?.videoGravity = .resizeAspect
        
        regulatePlayerView(isFullScreen: false)
        
        self.layer.addSublayer(playerLayer!)
        
        queuePlayer.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 100),
            queue: DispatchQueue.main,
            using: { [weak self] (cmtime) in
                self?.playerScreenView.videoDidChange(cmtime)
            })
        
    }
    
    private func setupInsideViews(_ standardRect: CGRect? , wholeRect : CGRect?) {
        
        guard configuration.hideControls else { return }
        
        guard (standardRect != nil) else { return }
        
        self.playerScreenView = PlayerScreenView(frame: CGRect(x: standardRect!.origin.x, y: 0, width: standardRect!.width, height: standardRect!.height))
        self.playerScreenView.delegate = self
        
        addSubview(self.playerScreenView)
        
        let quarterViewRect = Utills.getQuarterViewRect(wholeRect!)
        
        self.playerControlView = PlayerControllView(frame: CGRect(x: quarterViewRect!.origin.x, y: 0, width: quarterViewRect!.width, height: quarterViewRect!.height))
        self.playerControlView.delegate = self
        
        addSubview(self.playerControlView)
        
        playListView.createOverlayViewWith(wholeViewWidth: wholeRect!.size.width,configuration: configuration, theme: theme)
        
        playListView.delegate = self
        playListView.translatesAutoresizingMaskIntoConstraints = false
        playListView.isHidden = false
        addSubview(playListView)
        playListView.backgroundColor = .clear
        playListView.pinEdges(to: self)
        
    }
    
}


extension SummerPlayerView:PlayerControlViewDelegate {
    func didPressedAirPlayButton() {
        
    }
    
    func didPressedPreviousButton() {
        playerScreenView.resetPlayerUI()
        
        if let latestItems = contents {
            if(currentVideoIndex == 0) {
                currentVideoIndex = latestItems.count-1
            } else if(currentVideoIndex > 0) {
                currentVideoIndex -= 1
            }
            let newURL = URL(string: latestItems[currentVideoIndex].url)
            resetPlayer(newURL!)
        }
    }
    
    func didPressedNextButton() {
        playerScreenView.resetPlayerUI()
        
        if let latestItems = contents {
            if(currentVideoIndex >= 0 && currentVideoIndex < latestItems.count-1) {
                currentVideoIndex += 1
            } else if(currentVideoIndex == latestItems.count-1 ) {
                currentVideoIndex = 0
            }
            let newURL = URL(string: latestItems[currentVideoIndex].url)
            resetPlayer(newURL!)
        }
        
    }
    
    func didPressedBackButton() {
        self.queuePlayer.pause()
        self.playerLayer?.removeFromSuperlayer()
        
        delegate?.didPressedBackButton()
        
    }
}

extension SummerPlayerView: LegacyDelegate {
    func didSelectItem(_ index: Int) {
        
    }
    
    
    func didTappedPlayerScreenView(_ isTapped: Bool) {
        
        if configuration.hideControls {
            
            self.playListView.isHidden = true
            self.playerControlView.isHidden = true
            
            isTouched = true
            
        } else {
            self.playListView.isHidden = false
            self.playerControlView.isHidden = false
            isTouched = false
            
            
        }
        configuration.hideControls = !configuration.hideControls
        
        regulatePlayerView(isFullScreen: isTouched)
    }
    
    func currentVideoIndex(_ index: Int, _ url: URL) {
        
        currentVideoIndex = index
        resetPlayer(url)
    }
    
    func didLoadVideo(_ url: URL) {
        resetPlayer(url)
    }
    
    func seekToTime(_ seekTime: CMTime) {
        self.queuePlayer.currentItem?.seek(to: seekTime, completionHandler: nil)
    }
    
    func playPause(_ isActive: Bool) {
        isActive ? queuePlayer.play() : queuePlayer.pause()
    }
    
    private func resetPlayer(_ url:URL) {
        queuePlayer.removeAllItems()
        
        let playerItem = AVPlayerItem.init(url: url)
        queuePlayer.insert(playerItem, after: nil)
        queuePlayer.play()
        
        
        if let title = self.contents?[currentVideoIndex].title {
            playerScreenView.videoDidStart(title: title)
        }
        
    }
}

extension SummerPlayerView:PlayListViewDelegate {
    func changedPlayerStatus(state: SummerPlayerState) {
        
    }
    
    func didPressedCollectionView(index: Int) {
        
    }
    
}

extension UIView {
    
    public func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    
}



