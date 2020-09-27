//
//  BasicConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/06.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit
import SummerPlayerView

struct DefaultConfig: SummerPlayerViewConfiguration {
    public var canShowVideoList = true
    public var canShowTime = true
    public var canShowPlayPause = true
    public var canShowTimeBar = true
    public var canShowForwardBack = true
    public var hideControls: Bool = true
    public var dimension: PlayerDimension = .tiny
    public var seekDuration: Float64 = 15.0
}
