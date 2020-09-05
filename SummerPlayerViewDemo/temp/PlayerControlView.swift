//
//  PlayerControlView.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/04.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

class PlayerControlView: UIView {
    
    private var isPlaying: Bool = false
    
    lazy var addButton: UIButton = {
        let addButton = UIButton()
        if let image = UIImage(named: "more") {
            addButton.setImage(image, for: .normal)
        }
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        headerTitle.text = "SummerPlayer view is working"
        headerTitle.textColor = UIColor.white
        headerTitle.textAlignment = .center
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        return headerTitle
    }()
    
    lazy var topView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        headerView.alpha = 0.9
        headerView.addSubview(headerTitle)
        headerView.addSubview(addButton)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy  var playButton: UIButton = {
        let playButton = UIButton()
        if let image = UIImage(named: "play") {
            playButton.setImage(image, for: .normal)
        }
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(self.clickPlayButton(_:)), for: .touchUpInside)
        return playButton
    }()
    
    @objc func clickPlayButton(_ sender: UIButton) {
        
    }
    
    lazy var bottomView: UIView = {
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.black
        bottomView.alpha = 0.9
        bottomView.addSubview(playButton)
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
            //pin headerTitle to headerView
            headerTitle.topAnchor.constraint(equalTo: topView.topAnchor),
            headerTitle.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            
            //layout addButton in headerView
            addButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10),
            
            //pin headerView to top
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    private func setupBottomLayout() {
        NSLayoutConstraint.activate([
            
            playButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            playButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            
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

