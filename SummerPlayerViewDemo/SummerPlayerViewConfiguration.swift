//
//  SummerPlayerViewConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/20.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation


public protocol SummerPlayerViewConfiguration {
    var canShowVideoList: Bool { get }
    var canShowTime: Bool { get }
    var canShowPlayPause: Bool { get }
    var canShowTimeBar: Bool { get }
    var canShowForwardBack: Bool { get }
    var hideControls: Bool { get set }
    var dimension: PlayerDimension { get }
    var seekDuration: Float64 { get }
}


