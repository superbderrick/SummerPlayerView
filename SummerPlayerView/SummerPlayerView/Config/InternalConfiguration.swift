//
//  BasicConfiguration.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/08/20.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation

public struct InternalConfiguration: SummerPlayerViewConfig {
    public var playbackMode: PlaybackMode = PlaybackMode.loopPlay
    public var showIndicator: Bool = true
}
