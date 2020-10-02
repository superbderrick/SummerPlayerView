//
//  ViewController.swift
//  SummerPlayerView
//
//  Created by Derrick on 10/01/2020.
//  Copyright (c) 2020 Derrick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func startDemo(_ sender: Any) {
        movePlayerController()
    }
    
}

extension ViewController {
    
    fileprivate func movePlayerController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PlayerVC")
        
        self.present(controller, animated: true, completion: nil)
    }
    
}

