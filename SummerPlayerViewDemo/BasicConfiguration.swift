//
//  BasicConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/20.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation


public struct BasicConfiguration: SummerPlayerViewConfiguration {
    public var canShowVideoList = false
    public var canShowTime = false
    public var canShowPlayPause = true
    public var canShowTimeBar = false
    public var canShowForwardBack = true
    public var hideControls: Bool = true
    public var dimension: PlayerDimension = .embed
    public var seekDuration: Float64 = 15.0
}
