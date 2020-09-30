//
//  BasicConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/06.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit
import SummerPlayerView

struct DefaultConfig: SummerPlayerViewConfig {
    var playbackMode: PlaybackMode = PlaybackMode.loopPlay
    public var showIndicator = true
    public var showVideoList = true
    public var screenMode: ScreenMode = .tiny
    public var hideControls: Bool = true
}
