

import UIKit
import AVKit


class PlayListView: UIView {
    
    lazy private var activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
    
    lazy private var playListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy private var bottomControlsStackView: UIStackView  = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.8
        return view
    }()
    
    private lazy var collectionView: UICollectionView =  {
        let layout = UICollectionViewFlowLayout()
        
        let test:CGFloat = self.frame.size.width * 0.25
        layout.itemSize = CGSize(width: 200, height: 100)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    private var playerItems: [PlayerItem]?
    
    /// current video item which is playing now
    private var currentItem: PlayerItem?
    
    /// this controls player state whether it's paused or playing
    private var isActive: Bool = false
    
    var delegate: LegacyDelegate?
    
    /// custom header which comes as a default header
    var videoPlayerHeader: SummerVideoPlayerHeaderView?
    
    /// default configuration for player
    var configuration = InternalConfiguration()
    
    /// default theme for the player
    var theme = MainTheme()
    
    /// all four constraints of the player from mainContainer which we are using to make it fullScreen
    private var topC: NSLayoutConstraint?
    private var bottomC: NSLayoutConstraint?
    private var rightC: NSLayoutConstraint?
    private var leftC: NSLayoutConstraint?
    
    // default collectionviewcellid
    private var cellId = "videoCellId"
    
    // MARK: - View Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPlayList(currentItem: PlayerItem, items: [PlayerItem]) {
        playerItems = items
        self.currentItem = currentItem
        collectionView.reloadData()
        videoPlayerHeader?.setItem(currentItem)
    }
    
    func createOverlayViewWith(wholeViewWidth: CGFloat,configuration: SummerPlayerViewConfiguration, theme: SummerPlayerViewTheme, header: UIView?) {
        
        addSubview(activityView)
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(bottomControlsStackView)
        bottomControlsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        bottomControlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        if configuration.canShowVideoList {
            addPlayList()
        }
        
        applyTheme(theme)
    }
    
    private func applyTheme(_ theme: SummerPlayerViewTheme) {
        activityView.color = theme.activityViewColor
        collectionView.backgroundColor = theme.playListItemsBackgroundColor
    }
    
    private func setHeaderView(_ header: UIView) {
        addSubview(header)
        header.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        header.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
    }
    
    func didRegisterPlayerItemCell(_ identifier: String, collectioViewCell cell: UICollectionViewCell.Type) {
        collectionView.register(cell.self, forCellWithReuseIdentifier: identifier)
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    guard let `self` = self else { return }
                    if newStatus == .playing || newStatus == .paused {
                        if let player = self.delegate?.playerStateDidChange {
                            player((self.isActive ? SummerPlayerState.pause : SummerPlayerState.playing))
                        }
                        self.activityView.isHidden = true
                    } else {
                        self.activityView.isHidden = false
                    }
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc func resizeButtonTapped(_ sender:UIButton) {
        if let player = delegate?.playerDidChangeSize {
            player(configuration.dimension)
        }
        
        switch configuration.dimension {
        case .embed:
            if let _ = delegate?.fullScreenView?.bounds {
                if let view = delegate?.fullScreenView {
                    leftC = delegate?.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                    rightC = delegate?.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                    topC = delegate?.topAnchor.constraint(equalTo: view.topAnchor)
                    bottomC = delegate?.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    if let leftC = leftC, let rightC = rightC, let bottomC = bottomC, let topC = topC {
                        NSLayoutConstraint.activate([leftC, rightC, topC, bottomC])
                        layoutIfNeeded()
                    }
                }
            }
            
            configuration.dimension = .fullScreen
        case .fullScreen:
            if let leftC = leftC, let rightC = rightC, let bottomC = bottomC, let topC = topC {
                NSLayoutConstraint.deactivate([leftC, rightC, topC, bottomC])
                layoutIfNeeded()
                
            }
            configuration.dimension = .embed
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func addPlayList() {
        // background view
        addSubview(backgroundView)
        addSubview(playListStackView)
        
        backgroundView.pinEdges(to: playListStackView)
        // videos stackview
        playListStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        playListStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        playListStackView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        playListStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15).isActive = true
        
        // collectionView
        playListStackView.addSubview(collectionView)
        //
        collectionView.pinEdges(to: playListStackView)
    }
}

// MARK: - UICollectionView Delegate & Datasource

extension PlayListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playerItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = delegate?.playerCellForItem {
            return cell(collectionView, indexPath)
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? VideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(playerItems?[indexPath.row], theme: theme)
            return cell
        }
    }
    
}

extension PlayListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let player = delegate?.playerDidSelectItem {
            player(indexPath.row)
        }
        if let item = playerItems?[indexPath.row], let url = URL(string: item.url) {
            delegate?.didLoadVideo(url)
            delegate?.currentVideoIndex(indexPath.row,url)
            videoPlayerHeader?.setItem(item)
        }
    }
    
}


