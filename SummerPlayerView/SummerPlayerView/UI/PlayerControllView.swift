//
//  PlayerControllView.swift
//  SummerPlayerView
//
//  Created by derrick on 2020/09/13.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

class PlayerControllView: UIView {
    
    private var isPlaying: Bool = true
    
    var delegate: PlayerControlViewDelegate?
    
    lazy private var backButton: UIButton = {
        let backwardButton = UIButton()
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "back") {
            backwardButton.setImage(image, for: .normal)
        }
        
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.addTarget(self, action: #selector(self.clickBackButton(_:)), for: .touchUpInside)
        return backwardButton
    }()
    
    lazy private var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "next") {
            nextButton.setImage(image, for: .normal)
        }
        nextButton.addTarget(self, action: #selector(self.clickForwardButton(_:)), for: .touchUpInside)
        return nextButton
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
        addSubview(backButton)
        addSubview(nextButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
            nextButton.topAnchor.constraint(equalTo: self.topAnchor ,constant: self.bounds.size.height - 30),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -50),
        ])
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        delegate?.didPressedBackButton()
    }
    
    @objc func clickForwardButton(_ sender: UIButton) {
        delegate?.didPressedNextButton()
    }
    
}
