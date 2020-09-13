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
        let forwardButton = UIButton()
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.addTarget(self, action: #selector(self.clickForwardButton(_:)), for: .touchUpInside)
        return forwardButton
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
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
        ])
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        delegate?.didPressedBackButton()
    }
    
    @objc func clickForwardButton(_ sender: UIButton) {
        //        guard let totalDuration  = delegate?.totalDuration, let current = delegate?.currentTime, isActive else { return }
        //        let playerCurrentTime = CMTimeGetSeconds(current)
        //        let newTime = playerCurrentTime + configuration.seekDuration
        //
        //        if newTime < CMTimeGetSeconds(totalDuration) {
        //            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        //            delegate?.seekToTime(time2)
        //           // playerTimeLabel.text = time2.description
        //            //seekSlider.value = time2.asFloat / totalDuration.asFloat
        //            if let player = delegate?.playerTimeDidChange {
        //                player(time2.asDouble, totalDuration.asDouble)
        //            }
        //        }
    }
    
}
