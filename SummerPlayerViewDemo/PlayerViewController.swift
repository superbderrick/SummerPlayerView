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
    
    //@IBOutlet weak var summerPlayerView: SummerPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultConfig = DefaultConfig()
        
        let playerView = SummerPlayerView(configuration: defaultConfig, theme: nil,viewRect: view.bounds)
        
        playerView.sDelegate = self
        
        let playerItems = [
            Content(title: "Newyork", url: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8", thumbnail: "newyork",totalTime: "4:32"),
            Content(title: "Paris", url: "https://content.jwplatform.com/manifests/yp34SRmf.m3u8", thumbnail: "paris" , totalTime: "11:32"),
            Content(title: "Busan", url: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", thumbnail: "busan",totalTime: "4:32"),
            Content(title: "Copenhagen", url: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8", thumbnail: "cofenhagen",totalTime: "5:40"),
            Content(title: "SF", url: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", thumbnail: "sf",totalTime: "3:32")
        ]
        
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
