//
//  PlayerViewController.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/18.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit
import SummerPlayerView
class PlayerViewController: UIViewController  {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultConfig = DefaultConfig()
        let contents = ContentsMaker.getContents()
        
        let playerView = SummerPlayerView(configuration: defaultConfig, theme: nil,viewRect: view.bounds)
        
        playerView.delegate = self
        
        if let currentItem = contents.first {
            playerView.setPlayList(currentItem: currentItem, items: contents)
        }
        
        view.addSubview(playerView)
        
        playerView.pinEdges(to: view)
        
    }
    
}



extension PlayerViewController : SummerPlayerViewDelegate {
    
    func didPressedBackButton() {
        moveViewController()
    }
    func changedPlayerState() {
        
    }
    
}

extension PlayerViewController {
    
    fileprivate func moveViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainVC")
        self.present(controller, animated: true, completion: nil)
    }
    
}
