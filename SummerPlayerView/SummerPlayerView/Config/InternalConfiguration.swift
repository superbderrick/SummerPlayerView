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
    public var hideControls: Bool = true
    public var screenMode: ScreenMode = .tiny
}
