//
//  PlayerControlView.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/04.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

class PlayerControlView: UIView {
    
    lazy var addButton: UIButton = {
        let addButton = UIButton(type: .contactAdd)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    lazy var contentView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "WoodTexture")
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        contentView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return contentView
    }()
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        headerTitle.text = "Custom View"
        headerTitle.textAlignment = .center
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        headerView.alpha = 0.3

        headerView.addSubview(headerTitle)
        headerView.addSubview(addButton)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    
    private var isPlaying: Bool = false
    
    lazy private var playButton: UIButton = {
        let playButton = UIButton()
        playButton.frame = CGRect(x: 0.0,y: 0.0,width: 720,height: 220)
        playButton.addTarget(self, action: #selector(self.clickPlayButton(_:)), for: .touchUpInside)
        return playButton
    }()
    
    @objc func clickPlayButton(_ sender: UIButton) {
        isPlaying = !isPlaying
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private func setupView() {
        addSubview(contentView)
        addSubview(headerView)
        setupTopLayout()
        setupBottomLayout()
    }
    
    private func setupTopLayout() {
        NSLayoutConstraint.activate([
            //pin headerTitle to headerView
            headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            //layout addButton in headerView
            addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            
            //pin headerView to top
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 40),
            
            //layout contentView
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func setupBottomLayout() {
        
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override var intrinsicContentSize: CGSize {
      //preferred content size, calculate it if some internal state changes
      return CGSize(width: 300, height: 300)
    }
    
}



//in playground we should have a red rectangle


//    func setupPlayerControlView(configuration: SummerPlayerViewConfiguration, theme: SummerPlayerViewTheme, header: UIView? , rect:CGRect?) {
//
//        guard (rect != nil) else { return }
//
//        self.bounds = rect!
//        if configuration.canShowPlayPause {
//            addPlayPauseButton(rect: rect)
//            applyTheme(theme)
//        }
//
//    }
//
//    private func addPlayPauseButton(rect:CGRect?) {
//        // play/pause button
//        addSubview(playButton)
//
////
////        playButton.translatesAutoresizingMaskIntoConstraints = false
////        playButton.widthAnchor.constraint(equalToConstant: rect!.size.width )
////                 .isActive = true // ---- 3
//    }
//
//    private func applyTheme(_ theme: SummerPlayerViewTheme) {
//        playButton.tintColor = theme.buttonTintColor
//        changePlayOrPauseButtonImage(true,theme)
//
//    }
//
//    private func changePlayOrPauseButtonImage(_ isPlaying : Bool ,_ theme:SummerPlayerViewTheme) {
//        playButton.setImage((isPlaying ? theme.pauseButtonImage : theme.playButtonImage), for: .normal)
//    }
//
//    public func changePlayerStatus(playerStstus:Bool) {
//        isPlaying = playerStstus
//
//    }


//}
