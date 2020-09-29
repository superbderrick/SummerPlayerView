//
//  PlayerViewController.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/18.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit
import SummerPlayerView
class PlayerViewController: UIViewController, SummerPlayerViewDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultConfig = DefaultConfig()
        
        let playerView = SummerPlayerView(configuration: defaultConfig, theme: nil,viewRect: view.bounds)
        
        playerView.sDelegate = self
        
        let playerItems = ContentsMaker.getContents()
        
        if let currentItem = playerItems.first {
            playerView.setPlayList(currentItem: currentItem, items: playerItems, fullScreenView: view)
        }
        
        view.addSubview(playerView)
        
        playerView.pinEdges(to: view)
        
        playerView.playerStateDidChange = { (state) in
            print("playerStateDidChange")
        }
        playerView.playerDidChangeSize = { (dimension) in
            print("playerDidChangeSize")
        }
        playerView.playerTimeDidChange = { (newTime, duration) in
            print("playerTimeDidChange \(newTime)")
        }
        
        playerView.playerDidSelectItem = { (index) in
            print("Current Index \(index)")
        }
    }
    
    func didPressedBackButton() {
        moveViewController()
    }
    
}


extension PlayerViewController {
    
    fileprivate func moveViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(controller, animated: true, completion: nil)
    }
    
}
