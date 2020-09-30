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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultConfig = DefaultConfig()
        let contents = ContentsMaker.getContents()
        
        let summerPlayerView = SummerPlayerView(configuration: defaultConfig, theme: nil,targetView: view)
        
        summerPlayerView.delegate = self
        
        if let currentItem = contents.first {
            summerPlayerView.setPlayList(currentItem: currentItem, items: contents)
        }
        
        view.addSubview(summerPlayerView)
        
        summerPlayerView.pinEdges(targetView: view)
        
        
    }
    
}

extension PlayerViewController : SummerPlayerViewDelegate {
    func didFinishVideo() {
        
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
