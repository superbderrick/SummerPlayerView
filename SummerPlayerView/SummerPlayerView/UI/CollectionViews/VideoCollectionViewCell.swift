

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    let videoThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
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
        addSubview(titleLabel)
        
        videoThumbnail.pinEdges(to: self)
        titleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -10).isActive = true
    }
    private func applyTheme(_ theme: SummerPlayerViewTheme) {
        titleLabel.textColor = theme.playListItemsTextColor
    }
    func setData(_ playListItem: Content?, theme: SummerPlayerViewTheme = MainTheme()) {
        guard let playListItem = playListItem else {
            return
        }
        titleLabel.text = playListItem.totalTime
        videoThumbnail.image = UIImage(named: playListItem.thumbnail)
        applyTheme(theme)
    }
}
