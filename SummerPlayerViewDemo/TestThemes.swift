//
//  TestTheme.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/30.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation
import SummerPlayerView
import UIKit


public struct LightTheme: SummerPlayerViewTheme {
    public var resizeButtonImage: UIImage!
    
    public var playButtonImage: UIImage!
    
    public var pauseButtonImage: UIImage!
    
    public var forwardButtonImage: UIImage!
    
    public var backButtonImage: UIImage!
    
    public var optionsButtonImage: UIImage!
    
    public var headerBackgroundOpacity: Float = 0.3
    public var buttonTintColor: UIColor = .white
    public var headerBackgroundColor: UIColor = .black
    public var playListCurrentItemTextColor: UIColor = .white
    public var playListItemsTextColor: UIColor = .white
    public var timeLabelTextColor: UIColor = .white
    public var sliderTintColor: UIColor = .white
    public var sliderThumbColor: UIColor = .white
    public var activityViewColor: UIColor = .white
    public var playListItemsBackgroundColor: UIColor = .clear
    public var playListCurrentItemFont = UIFont.systemFont(ofSize: 17.0)
    public var playListItemsFont = UIFont.systemFont(ofSize: 12.0)
//    public var resizeButtonImage: UIImage! = Controls.resize(.fullScreen).image
//    public var playButtonImage: UIImage! = Controls.playpause(false).image
//    public var pauseButtonImage: UIImage! = Controls.playpause(true).image
//    public var forwardButtonImage: UIImage! = Controls.forward.image
//    public var backButtonImage: UIImage! = Controls.back.image
//    public var optionsButtonImage: UIImage! = Controls.options.image

}


public struct DarkTheme: SummerPlayerViewTheme {
    public var resizeButtonImage: UIImage!
    
    public var playButtonImage: UIImage!
    
    public var pauseButtonImage: UIImage!
    
    public var forwardButtonImage: UIImage!
    
    public var backButtonImage: UIImage!
    
    public var optionsButtonImage: UIImage!
    
    public var headerBackgroundOpacity: Float = 0.3
    public var buttonTintColor: UIColor = .white
    public var headerBackgroundColor: UIColor = .black
    public var playListCurrentItemTextColor: UIColor = .white
    public var playListItemsTextColor: UIColor = .white
    public var timeLabelTextColor: UIColor = .white
    public var sliderTintColor: UIColor = .white
    public var sliderThumbColor: UIColor = .white
    public var activityViewColor: UIColor = .white
    public var playListItemsBackgroundColor: UIColor = .clear
    public var playListCurrentItemFont = UIFont.systemFont(ofSize: 17.0)
    public var playListItemsFont = UIFont.systemFont(ofSize: 12.0)
//    public var resizeButtonImage: UIImage! = Controls.resize(.fullScreen).image
//    public var playButtonImage: UIImage! = Controls.playpause(false).image
//    public var pauseButtonImage: UIImage! = Controls.playpause(true).image
//    public var forwardButtonImage: UIImage! = Controls.forward.image
//    public var backButtonImage: UIImage! = Controls.back.image
//    public var optionsButtonImage: UIImage! = Controls.options.image

}
