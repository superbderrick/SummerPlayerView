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
            image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            backwardButton.setImage(image, for: .normal)
        }
        
        backwardButton.tintColor = UIColor(white:1, alpha:1)
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.addTarget(self, action: #selector(self.clickBackButton(_:)), for: .touchUpInside)
        return backwardButton
    }()
    
    lazy private var previousButton: UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "previous") {
            image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            nextButton.setImage(image, for: .normal)
        }
        nextButton.tintColor = UIColor(white:1, alpha:1)
        nextButton.addTarget(self, action: #selector(self.clickPreviousButton(_:)), for: .touchUpInside)
        return nextButton
    }()
    
    lazy private var airplayButton: UIButton = {
        let airplayButton = UIButton()
        airplayButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "airplay") {
            image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            airplayButton.setImage(image, for: .normal)
        }
        airplayButton.tintColor = UIColor(white:1, alpha:1)
        airplayButton.addTarget(self, action: #selector(self.clickAirPlayButton(_:)), for: .touchUpInside)
        return airplayButton
    }()
    
    lazy private var nextButton: UIButton = {
        let previousButton = UIButton()
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UIImage(named: "next") {
            image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            previousButton.setImage(image, for: .normal)
        }
        previousButton.tintColor = UIColor(white:1, alpha:1)
        previousButton.addTarget(self, action: #selector(self.clickNextButton(_:)), for: .touchUpInside)
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
        addSubview(previousButton)
        addSubview(airplayButton)
        addSubview(nextButton)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor , constant: 15),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
            
            airplayButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            airplayButton.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -50),
            
            nextButton.topAnchor.constraint(equalTo: self.topAnchor ,constant: self.bounds.size.height - 30),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -50),
            
            previousButton.topAnchor.constraint(equalTo: self.topAnchor ,constant: self.bounds.size.height - 30),
            previousButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30)
        ])
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        delegate?.didPressedBackButton()
    }
    
    @objc func clickPreviousButton(_ sender: UIButton) {
        delegate?.didPressedPreviousButton()
    }
    
    @objc func clickAirPlayButton(_ sender: UIButton) {
        delegate?.didPressedAirPlayButton()
    }
    
    @objc func clickNextButton(_ sender: UIButton) {
        delegate?.didPressedNextButton()
    }
    
}
