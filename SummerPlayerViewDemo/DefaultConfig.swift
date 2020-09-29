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
    public var screenMode: ScreenMode = .tiny
    public var hideControls: Bool = true
}
