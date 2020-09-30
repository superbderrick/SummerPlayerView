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
  
    public var headerBackgroundOpacity: Float = 0.3
    public var buttonTintColor: UIColor = .white
    public var headerBackgroundColor: UIColor = .black
    public var playListCurrentItemTextColor: UIColor = .white
    
    public var timeLabelTextColor: UIColor = .white
    
    
    
    public var playListCurrentItemFont = UIFont.systemFont(ofSize: 17.0)
    
    
    public var totalTimeLableTextFont = UIFont.boldSystemFont(ofSize: 13)
    public var contentsListviewBackground: UIColor = .black
    public var activityViewColor: UIColor = .black
    public var totalTimeLabelTextColor: UIColor = .white
    public var totalTimeLableBackground: UIColor = .black
    public var sliderTintColor: UIColor = .red
    public var sliderThumbColor: UIColor = .red
    
}


public struct DarkTheme: SummerPlayerViewTheme {

    public var headerBackgroundOpacity: Float = 0.3
    public var buttonTintColor: UIColor = .white
    public var headerBackgroundColor: UIColor = .black
    public var playListCurrentItemTextColor: UIColor = .white
    
    public var timeLabelTextColor: UIColor = .white

    public var playListCurrentItemFont = UIFont.systemFont(ofSize: 17.0)
    
    
    public var totalTimeLableTextFont = UIFont.boldSystemFont(ofSize: 13)
    public var contentsListviewBackground: UIColor = .white
    public var activityViewColor: UIColor = .white
    public var totalTimeLabelTextColor: UIColor = .white
    public var totalTimeLableBackground: UIColor = .black
    public var sliderTintColor: UIColor = .red
    public var sliderThumbColor: UIColor = .red

}
