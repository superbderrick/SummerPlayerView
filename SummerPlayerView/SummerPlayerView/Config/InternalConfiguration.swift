//
//  BasicConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/20.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation

public struct InternalConfiguration: SummerPlayerViewConfiguration {
    public var canShowVideoList = true
    public var canShowTime = true
    public var canShowPlayPause = true
    public var canShowTimeBar = true
    public var canShowForwardBack = false
    public var hideControls: Bool = true
    public var dimension: PlayerDimension = .tiny
    public var seekDuration: Float64 = 15.0
}
