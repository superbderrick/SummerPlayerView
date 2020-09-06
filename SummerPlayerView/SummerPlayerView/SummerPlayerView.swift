

import Foundation
import AVKit


public enum PlayerDimension {
    case embed
    case fullScreen
}

open class SummerPlayerView: UIView {
    
    // MARK: - Constants
    
    public var playerStateDidChange: ((SummerPlayerState)->())? = nil
    
    public var playerTimeDidChange: ((TimeInterval, TimeInterval)->())? = nil
    
    public var playerOrientationDidChange: ((PlayerDimension) -> ())? = nil
    
    public var playerDidChangeSize: ((PlayerDimension) -> ())? = nil
    
    public var playerCellForItem: ((UICollectionView, IndexPath)->(UICollectionViewCell))? = nil
    
    public var playerDidSelectItem: ((Int)->())? = nil
    
    public var didSelectOptions: ((PlayerItem) -> ())? = nil
    
    // MARK: - Instance Variables
    
    private var task: DispatchWorkItem? = nil
    
    private var queuePlayer: AVQueuePlayer!
    
    private var playerLayer: AVPlayerLayer?
    
    let playListView = PlayListView()
    
    var playControlView = PlayerControlView()
    
    var wholeStandardViewRect = CGRect()
    
    var configuration: SummerPlayerViewConfiguration = InternalConfiguration()
    
    var theme: SummerPlayerViewTheme = MainTheme()
    
    public var fullScreenView: UIView? = nil
    
    public var totalDuration: CMTime? {
        return self.queuePlayer.currentItem?.asset.duration
    }
    
    public var currentTime: CMTime? {
        return self.queuePlayer.currentTime()
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.1
        view.isOpaque = false
        view.isHidden = true
        return view
    }()
    
    required public init(configuration: SummerPlayerViewConfiguration?, theme: SummerPlayerViewTheme?, header: UIView?, viewRect: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
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
        
        regulatePlayerView(isFullScreen: false)
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
    
    // MARK: - Helper Methods
    
    func didRegisterPlayerItemCell(_ identifier: String, collectioViewCell cell: UICollectionViewCell.Type) {
        playListView.didRegisterPlayerItemCell(identifier, collectioViewCell: cell)
    }
    
    public func setPlayList(currentItem: PlayerItem, items: [PlayerItem], fullScreenView: UIView? = nil) {
        
        self.fullScreenView = fullScreenView
        
        if let url = URL(string: currentItem.url) {
            didLoadVideo(url)
        }
        
        playListView.setPlayList(currentItem: currentItem, items: items)
    }
    
    
    private func setupSummerPlayerView(_ header: UIView? , _ viewRect: CGRect?) {
        if(viewRect != nil) {
            let wholeStandardRect = getwholeStandardViewRect(viewRect!)
            
            setupPlayer()
            
            setupInsideViews(header,wholeStandardRect)
            
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(backgroundView)
            
            bringSubviewToFront(playListView)
            bringSubviewToFront(playControlView)
            
            backgroundView.pinEdges(to: self)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tap.cancelsTouchesInView = false
            tap.delegate = self
            addGestureRecognizer(tap)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.onOrientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        
        
    }
    
    @objc func onOrientationChanged() {
        if let didChangeOrientation = playerOrientationDidChange {
            didChangeOrientation(configuration.dimension)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        print("handleTap ")
        
        var isTouched = false
        
        if configuration.hideControls {
            playListView.isHidden = true
            self.playControlView.isHidden = true
            backgroundView.isHidden = true
            task?.cancel()
            
            isTouched = true
        } else {
            playListView.isHidden = false
            self.playControlView.isHidden = false
            backgroundView.isHidden = false
            task = DispatchWorkItem {
                //self.playListView.isHidden = true
                //self.playControlView.isHidden = true
                self.backgroundView.isHidden = true
                self.configuration.hideControls = !self.configuration.hideControls
            }
            print("handleTap maybe false ")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(10), execute: task!)
            isTouched = false
        }
        configuration.hideControls = !configuration.hideControls
        
        regulatePlayerView(isFullScreen: isTouched)
        
    }
    
    
    private func setupPlayer() {
        queuePlayer = AVQueuePlayer()
        queuePlayer.addObserver(playListView, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer?.backgroundColor = UIColor.black.cgColor
        playerLayer?.videoGravity = .resizeAspect
        
        self.layer.addSublayer(playerLayer!)
        queuePlayer.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 1, preferredTimescale: 100),
            queue: DispatchQueue.main,
            using: { [weak self] (cmtime) in
                print(cmtime)
                self?.playControlView.videoDidChange(cmtime)
        })
        
    }
    
    private func setupInsideViews(_ header: UIView?,_ standardRect: CGRect?) {
        
        guard configuration.hideControls else { return }
        
        guard (standardRect != nil) else { return }
        
        self.playControlView = PlayerControlView(frame: CGRect(x: standardRect!.origin.x, y: 0, width: standardRect!.width, height: standardRect!.height))
        
        self.playControlView.delegate = self
        addSubview(self.playControlView)
        
        
        playListView.createOverlayViewWith(configuration: configuration, theme: theme, header: header)
        playListView.delegate = self
        playListView.translatesAutoresizingMaskIntoConstraints = false
        playListView.isHidden = false
        addSubview(playListView)
        playListView.backgroundColor = .clear
        playListView.pinEdges(to: self)
        
    }
    
    private func setupPlayerControlView() {
        
    }
    
}

// MARK: MBVideoPlayerControlsDelegate

extension SummerPlayerView: SummerPlayerControlsDelegate {
    
    public func didLoadVideo(_ url: URL) {
        
        queuePlayer.removeAllItems()
        
        let playerItem = AVPlayerItem.init(url: url)
        queuePlayer.insert(playerItem, after: nil)
        queuePlayer.play()
        
        playControlView.videoDidStart()
        
        if let player = playerStateDidChange {
            player(.readyToPlay)
        }
    }
    
    public func seekToTime(_ seekTime: CMTime) {
        print(seekTime)
        self.queuePlayer.currentItem?.seek(to: seekTime, completionHandler: nil)
    }
    
    public func playPause(_ isActive: Bool) {
        isActive ? queuePlayer.play() : queuePlayer.pause()
    }
}

// MARK: MBVideoPlayerControlsDelegate

extension SummerPlayerView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.classForCoder == UIButton.classForCoder() { return false }
        return true
    }
}

// MARK: MBVideoPlayerControlsDelegate

extension UIView {
    public func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    
    public func getwholeStandardViewRect(_ viewRect:CGRect) -> CGRect? {
        var wholeStandardRect : CGRect
        let xAXIS = viewRect.size.width * 0.25
        
        let yAXIS :CGFloat = 0.0
        let WIDTH = viewRect.size.width/2
        let HEIGHT = viewRect.size.height * 0.6
        
        wholeStandardRect = CGRect(x: xAXIS, y: yAXIS, width: WIDTH, height: HEIGHT)
        
        return wholeStandardRect
    }
}



