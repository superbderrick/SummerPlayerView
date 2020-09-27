

import Foundation
import AVKit


public enum PlayerDimension {
    case embed
    case fullScreen
}

open class SummerPlayerView: UIView {
    
    public var playerStateDidChange: ((SummerPlayerState)->())? = nil
    
    public var playerTimeDidChange: ((TimeInterval, TimeInterval)->())? = nil
    
    public var playerOrientationDidChange: ((PlayerDimension) -> ())? = nil
    
    public var playerDidChangeSize: ((PlayerDimension) -> ())? = nil
    
    public var playerCellForItem: ((UICollectionView, IndexPath)->(UICollectionViewCell))? = nil
    
    public var playerDidSelectItem: ((Int)->())? = nil
    
    private var playerItems: [PlayerItem]?
    
    private var task: DispatchWorkItem? = nil
    
    private var queuePlayer: AVQueuePlayer!
    
    private var playerLayer: AVPlayerLayer?
    
    let playListView = PlayListView()
    
    var playerScreenView = PlayerScreenView()
    
    var playerControlView = PlayerControllView()
    
    var configuration: SummerPlayerViewConfiguration = InternalConfiguration()
    
    var theme: SummerPlayerViewTheme = MainTheme()
    
    var delegate: LegacyDelegate?
    
    open var sDelegate: SummerPlayerViewDelegate?
    
    public var fullScreenView: UIView? = nil
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.2
        view.isOpaque = false
        view.isHidden = true
        return view
    }()
    
    public var totalDuration: CMTime? {
        return self.queuePlayer.currentItem?.asset.duration
    }
    
    public var currentTime: CMTime? {
        return self.queuePlayer.currentTime()
    }
    
    private var currentVideoIndex = 0
    
    
    required public init(configuration: SummerPlayerViewConfiguration?, theme: SummerPlayerViewTheme?, header: UIView?, viewRect: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.bounds = viewRect
        
        if let theme = theme {
            self.theme = theme
        }
        if let configuration = configuration {
            self.configuration = configuration
        }
        
        setupSummerPlayerView(header,viewRect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupSummerPlayerView(nil,nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSummerPlayerView(nil,nil)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func regulatePlayerView(isFullScreen:Bool) {
        var playerViewRect : CGRect
        let xAXIS = self.bounds.size.width * 0.25
        let yAXIS :CGFloat = 0.0
        let WIDTH = self.bounds.size.width/2
        let HEIGHT = self.bounds.size.height * 0.6
        
        if isFullScreen {
            playerViewRect = self.bounds
        } else {
            playerViewRect = CGRect(x: xAXIS, y: yAXIS, width: WIDTH, height: HEIGHT)
        }
        
        playerLayer?.frame = playerViewRect
    }
    
    
    func didRegisterPlayerItemCell(_ identifier: String, collectioViewCell cell: UICollectionViewCell.Type) {
        playListView.didRegisterPlayerItemCell(identifier, collectioViewCell: cell)
    }
    
    public func setPlayList(currentItem: PlayerItem, items: [PlayerItem], fullScreenView: UIView? = nil) {
        
        self.fullScreenView = fullScreenView
        
        self.playerItems = items
        self.currentVideoIndex = 0
        
        if let url = URL(string: currentItem.url) {
            didLoadVideo(url)
        }
        
        playListView.setPlayList(currentItem: currentItem, items: items)
    }
    
    
    private func setupSummerPlayerView(_ header: UIView? , _ viewRect: CGRect?) {
        if(viewRect != nil) {
            let wholeViewRect = Utills.getWholeViewRect(viewRect!)
            
            setupPlayer()
            
            setupInsideViews(header,wholeViewRect , wholeRect: viewRect)
            
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(backgroundView)
            
            bringSubviewToFront(playListView)
            bringSubviewToFront(playerControlView)
            bringSubviewToFront(playerScreenView)
            
            backgroundView.pinEdges(to: self)
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.onOrientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        
    }
    
    @objc func onOrientationChanged() {
        if let didChangeOrientation = playerOrientationDidChange {
            didChangeOrientation(configuration.dimension)
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
    
    private func setupInsideViews(_ header: UIView?,_ standardRect: CGRect? , wholeRect : CGRect?) {
        
        guard configuration.hideControls else { return }
        
        guard (standardRect != nil) else { return }
        
        self.playerScreenView = PlayerScreenView(frame: CGRect(x: standardRect!.origin.x, y: 0, width: standardRect!.width, height: standardRect!.height))
        
        self.playerScreenView.delegate = self
        addSubview(self.playerScreenView)
        
        let quarterViewRect = Utills.getQuarterViewRect(wholeRect!)
        
        self.playerControlView = PlayerControllView(frame: CGRect(x: quarterViewRect!.origin.x, y: 0, width: quarterViewRect!.width, height: quarterViewRect!.height))
        
        self.playerControlView.delegate = self
        addSubview(self.playerControlView)
        
        playListView.createOverlayViewWith(wholeViewWidth: wholeRect!.size.width,configuration: configuration, theme: theme, header: header)
        playListView.delegate = self
        playListView.translatesAutoresizingMaskIntoConstraints = false
        playListView.isHidden = false
        addSubview(playListView)
        playListView.backgroundColor = .clear
        playListView.pinEdges(to: self)
        
    }
    
    
}


extension SummerPlayerView:PlayerControlViewDelegate {
    public func didPressedAirPlayButton() {
        
    }
    
    public func didPressedPreviousButton() {
        playerScreenView.resetPlayerUI()
        
        if let latestItems = playerItems {
            if(currentVideoIndex == 0) {
                currentVideoIndex = latestItems.count-1
            } else if(currentVideoIndex > 0) {
                currentVideoIndex -= 1
            }
            let newURL = URL(string: latestItems[currentVideoIndex].url)
            resetPlayer(newURL!)
        }
    }
    
    public func didPressedNextButton() {
        playerScreenView.resetPlayerUI()
        
        if let latestItems = playerItems {
            if(currentVideoIndex >= 0 && currentVideoIndex < latestItems.count-1) {
                currentVideoIndex += 1
            } else if(currentVideoIndex == latestItems.count-1 ) {
                currentVideoIndex = 0
            }
            let newURL = URL(string: latestItems[currentVideoIndex].url)
            resetPlayer(newURL!)
        }
        
    }
    
    public func didPressedBackButton() {
        self.queuePlayer.pause()
        self.playerLayer?.removeFromSuperlayer()
        
        sDelegate?.didPressedBackButton()
        
    }
}

extension SummerPlayerView: LegacyDelegate {
    public func didTappedPlayerScreenView(_ isTapped: Bool) {
        print("didTappedPlayerScreenvIew \(isTapped)")
        
        var isTouched = false
        
        if configuration.hideControls {

            playListView.isHidden = true
            self.playerControlView.isHidden = true
            backgroundView.isHidden = true
            task?.cancel()

            isTouched = true


        } else {
            playListView.isHidden = false
            self.playerControlView.isHidden = false
            backgroundView.isHidden = false
            task = DispatchWorkItem {
                self.backgroundView.isHidden = true
                self.configuration.hideControls = !self.configuration.hideControls
            }

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10), execute: task!)
            isTouched = false

        }
        configuration.hideControls = !configuration.hideControls
        
        regulatePlayerView(isFullScreen: isTouched)
    }
    
    public func currentVideoIndex(_ index: Int, _ url: URL) {
        
        currentVideoIndex = index
        resetPlayer(url)
    }
    
    public func didLoadVideo(_ url: URL) {
        resetPlayer(url)
    }
    
    public func seekToTime(_ seekTime: CMTime) {
        print(seekTime)
        self.queuePlayer.currentItem?.seek(to: seekTime, completionHandler: nil)
    }
    
    public func playPause(_ isActive: Bool) {
        isActive ? queuePlayer.play() : queuePlayer.pause()
    }
    
    private func resetPlayer(_ url:URL) {
        queuePlayer.removeAllItems()
        
        let playerItem = AVPlayerItem.init(url: url)
        queuePlayer.insert(playerItem, after: nil)
        queuePlayer.play()
        
    
        if let title = self.playerItems?[currentVideoIndex].title {
            playerScreenView.videoDidStart(title: title)
        }
        
        if let player = playerStateDidChange {
            player(.readyToPlay)
        }
    }
}

extension SummerPlayerView:PlayListViewDelegate {
    public func didPressedCollectionView(index: Int) {
        
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



