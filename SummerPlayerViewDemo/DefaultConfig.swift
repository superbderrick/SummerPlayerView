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
    public var playbackMode: PlaybackMode = PlaybackMode.loopPlay
    public var showIndicator = true
}
