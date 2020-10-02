//
//  PlayerViewController.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/18.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit
import AVKit

import SummerPlayerView

class PlayerViewController: UIViewController  {
    
    let defaultConfig = DefaultConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testContents = ContentsMaker.getContents()
        let sampleTheme = ThemeMaker.getTheme()
        
        let summerPlayerView = SummerPlayerView(configuration: defaultConfig, theme: sampleTheme,targetView: view)
        
        summerPlayerView.delegate = self
        
        if let currentItem = testContents.first {
            summerPlayerView.setupPlayList(currentItem: currentItem, items: testContents)
        }
        
        view.addSubview(summerPlayerView)
        
        summerPlayerView.pinEdges(targetView: view)
        
    }
    
}

extension PlayerViewController : SummerPlayerViewDelegate {
    func didFinishVideo() {
        
        if self.defaultConfig.playbackMode == .quit {
            moveViewController()   
        }
    }
    
    func didStartVideo() {
        
    }
    
    func didChangeSliderValue(_ seekTime: CMTime) {
        
    }
    func didPressBackButton() {
        moveViewController()
    }
    
    func didPressNextButton() {
        
    }
    
    func didPressPreviousButton() {
        
    }
    
    func didPressAirPlayButton() {
        
    }
    
    func didPressMoreButton() {
        
    }
    
    func didPressContentsListView(index: Int) {
        
    }
    
    func didPressPlayButton(isActive: Bool) {
        
    }
    
}

extension PlayerViewController {
    
    fileprivate func moveViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(controller, animated: true, completion: nil)
    }
}
