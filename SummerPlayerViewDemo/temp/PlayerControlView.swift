//
//  PlayerControlView.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/04.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit
import AVKit

class PlayerControlView: UIView {
    
    private var isPlaying: Bool = false
    
    lazy private var playerTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy private var fullTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "0.0"
        timeLabel.textColor = UIColor.white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.textAlignment = .center
        return timeLabel
    }()
    
    lazy private var playerSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(self.changeSeekSlider(_:)), for: .valueChanged)
        return slider
    }()
    
    lazy private var addButton: UIButton = {
        let addButton = UIButton()
        if let image = UIImage(named: "more") {
            addButton.setImage(image, for: .normal)
        }
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    lazy private var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        headerTitle.text = "SummerPlayer view is working"
        headerTitle.textColor = UIColor.white
        headerTitle.textAlignment = .center
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    lazy private var topView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        headerView.alpha = 0.9
        headerView.addSubview(headerTitle)
        headerView.addSubview(addButton)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy private var playButton: UIButton = {
        let playButton = UIButton()
        if let image = UIImage(named: "play") {
            playButton.setImage(image, for: .normal)
        }
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(self.clickPlayButton(_:)), for: .touchUpInside)
        return playButton
    }()
    
    lazy private var bottomControlsStackView: UIStackView  = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc func clickPlayButton(_ sender: UIButton) {
        
    }
    
    @objc func changeSeekSlider(_ sender: UISlider) {
        
    }
    
    
    func videoDidChange(_ time: CMTime) {
        playerTimeLabel.text = time.description
    }
    
    func videoDidStart() {
        playerTimeLabel.text = CMTime.zero.description
        playerSlider.value = 0.0
        //fullTimeLabel.text = delegate?.totalDuration?.description ?? CMTime.zero.description
        
    }
    
    lazy var bottomView: UIView = {
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.clear
        bottomView.alpha = 0.9
        
        bottomView.addSubview(playButton)
        bottomView.addSubview(bottomControlsStackView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(topView)
        addSubview(bottomView)
        setupTopLayout()
        setupBottomLayout()
    }
    
    private func setupTopLayout() {
        NSLayoutConstraint.activate([
            
            headerTitle.topAnchor.constraint(equalTo: topView.topAnchor),
            headerTitle.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            
            addButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    private func setupBottomLayout() {
        
        bottomControlsStackView.addArrangedSubview(playerTimeLabel)
        
        playerTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        playerTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        bottomControlsStackView.addArrangedSubview(playerSlider)
        playerSlider.centerYAnchor.constraint(equalTo: bottomControlsStackView.centerYAnchor, constant: 0).isActive = true
        
        bottomControlsStackView.addArrangedSubview(fullTimeLabel)
        
        fullTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        fullTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        NSLayoutConstraint.activate([
            
            playButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            playButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            
            
            bottomControlsStackView.leadingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: 40),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            bottomControlsStackView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override var intrinsicContentSize: CGSize {
        //preferred content size, calculate it if some internal state changes
        return CGSize(width: 300, height: 300)
    }
    
}

