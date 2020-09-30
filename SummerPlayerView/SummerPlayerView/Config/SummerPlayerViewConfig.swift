//
//  SummerPlayerViewConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/20.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation


public protocol SummerPlayerViewConfig {
    var showVideoList: Bool { get set}
    var hideControls: Bool { get set }
    var screenMode: ScreenMode { get set}
    var showIndicator : Bool {get set}
    var playbackMode: PlaybackMode{get set}
}

 
