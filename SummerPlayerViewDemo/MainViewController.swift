//
//  MainViewController.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/13.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    fileprivate func movePlayerController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PlayerVC")
        
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func startPlayerController(_ sender: Any) {
        
            
        movePlayerController()

    }
    

}
