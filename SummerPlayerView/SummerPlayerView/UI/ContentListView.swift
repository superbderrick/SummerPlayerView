

import UIKit
import AVKit


class ContentListView: UIView {
    
    lazy private var activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
    
    lazy private var contentListStackView: UIStackView = {
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
    
    
    private var contents: [Content]?
    
    private var currentContent: Content?
    
    private var isActive: Bool = false
    
    var delegate: PlayerScreenViewDelegate?
    
    
    
    var configuration = InternalConfiguration()
    
    var theme:SummerPlayerViewTheme = defaultTheme()
    
    private var topC: NSLayoutConstraint?
    private var bottomC: NSLayoutConstraint?
    private var rightC: NSLayoutConstraint?
    private var leftC: NSLayoutConstraint?
    
    private var cellId = "videoCellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPlayList(currentItem: Content, items: [Content]) {
        contents = items
        self.currentContent = currentItem
        collectionView.reloadData()
        
    }
    
    func createOverlayViewWith(wholeViewWidth: CGFloat,configuration: SummerPlayerViewConfig, theme: SummerPlayerViewTheme) {
        
        self.theme = theme
        addSubview(activityView)
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor , constant: -50).isActive = true
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addSubview(bottomControlsStackView)
        bottomControlsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        bottomControlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        if configuration.showVideoList {
            addPlayList()
        }
        
        applyTheme(theme)
    }
    
    private func applyTheme(_ theme: SummerPlayerViewTheme) {
        activityView.color = theme.activityViewColor
        collectionView.backgroundColor = theme.contentsListviewBackground
        
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
                        
                        self.activityView.isHidden = true
                    } else {
                        self.activityView.isHidden = false
                    }
                }
            }
        }
    }
    
    
    private func addPlayList() {
        addSubview(backgroundView)
        addSubview(contentListStackView)
        
        backgroundView.pinEdges(targetView: contentListStackView)
        
        contentListStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        contentListStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        contentListStackView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        contentListStackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15).isActive = true
        
        
        contentListStackView.addSubview(collectionView)
        collectionView.pinEdges(targetView: contentListStackView)
    }
}

extension ContentListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = delegate?.playerCellForItem {
            return cell(collectionView, indexPath)
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? VideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setData(contents?[indexPath.row], theme: self.theme)
            return cell
        }
    }
    
}

extension ContentListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectItem(indexPath.row)
        if let item = contents?[indexPath.row], let url = URL(string: item.url) {
            delegate?.didLoadVideo(url)
            delegate?.currentVideoIndex(indexPath.row,url)
         
        }
    }
    
}


