

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    let videoThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black
        label.alpha = 0.8
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(videoThumbnail)
        addSubview(totalTimeLabel)
        
        videoThumbnail.pinEdges(targetView: self)
        totalTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        totalTimeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        totalTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        totalTimeLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -10).isActive = true
    }
    private func applyTheme(_ theme: SummerPlayerViewTheme) {
        totalTimeLabel.textColor = theme.totalTimeLabelTextColor
        totalTimeLabel.font = theme.totalTimeLableTextFont
        totalTimeLabel.backgroundColor = theme.totalTimeLableBackground
    }
    func setData(_ playListItem: Content?, theme: SummerPlayerViewTheme) {
        guard let playListItem = playListItem else {
            return
        }
        totalTimeLabel.text = playListItem.totalTime
        
        if let image = UIImage(named: playListItem.thumbnail) {
            videoThumbnail.image = image
        } else {
            videoThumbnail.image = UIImage(named: "sf" , in: Bundle(for: VideoCollectionViewCell.self),compatibleWith: nil)
        }
        
        applyTheme(theme)
    }
}
