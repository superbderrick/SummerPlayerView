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
    
    lazy private var forwardButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "previous") {
            nextButton.setImage(image, for: .normal)
        }
        nextButton.addTarget(self, action: #selector(self.clickForwardButton(_:)), for: .touchUpInside)
        return nextButton
    }()
    
    lazy private var airplayButton: UIButton = {
        let airplayButton = UIButton()
        airplayButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "airplay") {
            airplayButton.setImage(image, for: .normal)
        }
        airplayButton.addTarget(self, action: #selector(self.clickAirPlayButton(_:)), for: .touchUpInside)
        return airplayButton
    }()
    
    lazy private var previousButton: UIButton = {
        let previousButton = UIButton()
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "next") {
            previousButton.setImage(image, for: .normal)
        }
        previousButton.addTarget(self, action: #selector(self.clickPreviousButton(_:)), for: .touchUpInside)
        return previousButton
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
        addSubview(forwardButton)
        addSubview(airplayButton)
        addSubview(previousButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
            
            airplayButton.topAnchor.constraint(equalTo: self.topAnchor),
            airplayButton.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -50),
            
            previousButton.topAnchor.constraint(equalTo: self.topAnchor ,constant: self.bounds.size.height - 30),
            previousButton.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -50),
            
            forwardButton.topAnchor.constraint(equalTo: self.topAnchor ,constant: self.bounds.size.height - 30),
            forwardButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30)
        ])
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        print("clickBackButton")
        delegate?.didPressedBackButton()
    }
    
    @objc func clickForwardButton(_ sender: UIButton) {
        print("clickForwardButton")
        delegate?.didPressedNextButton()
    }
    
    @objc func clickAirPlayButton(_ sender: UIButton) {
        print("clickAirPlay")
        delegate?.didPressedAirPlayButton()
    }
    
    @objc func clickPreviousButton(_ sender: UIButton) {
        print("clickPreviousButton")
        delegate?.didPressedPreviousButton()
    }
    
}
