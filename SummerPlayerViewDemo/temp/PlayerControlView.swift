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

     lazy private var playButton: UIButton = {
       let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(self.clickPlayButton(_:)), for: .touchUpInside)
        return playButton
    }()
    
    @objc func clickPlayButton(_ sender: UIButton) {
        isPlaying = !isPlaying
        //delegate?.playPause(isActive)
//        if let player = delegate?.playerStateDidChange {
//            player((isActive == true ? .playing : .pause))
//        }
       //changePlayOrPauseButtonImage(false, <#T##theme: SummerPlayerViewTheme##SummerPlayerViewTheme#>)
    }
    

    override init(frame: CGRect) {
      super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupPlayerControlView(configuration: SummerPlayerViewConfiguration, theme: SummerPlayerViewTheme, header: UIView? , rect:CGRect?) {
        
        if configuration.canShowPlayPause {
            addPlayPauseButton(rect: rect)
            applyTheme(theme)
        }

    }
    
    private func addPlayPauseButton(rect:CGRect?) {
        // play/pause button
        addSubview(playButton)
        
        print("ORIGIN X \(rect?.origin.x)")
        print("ORIGIN Y \(rect?.origin.y)")
        print("SIZE WIDTH \(rect?.size.width)")
        print("SIZE HEGIGHT \(rect?.size.height)")
        
        
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func applyTheme(_ theme: SummerPlayerViewTheme) {
        playButton.tintColor = theme.buttonTintColor
        changePlayOrPauseButtonImage(true,theme)
        
    }
    
    private func changePlayOrPauseButtonImage(_ isPlaying : Bool ,_ theme:SummerPlayerViewTheme) {
        playButton.setImage((isPlaying ? theme.pauseButtonImage : theme.playButtonImage), for: .normal)
    }
    
    public func changePlayerStatus(playerStstus:Bool) {
        isPlaying = playerStstus
        
       // changePlayOrPauseButtonImage(isPlaying: playerStstus)
    }
    

}
