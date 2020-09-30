//
//  ThemeMaker.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/30.
//  Copyright © 2020 Derrick. All rights reserved.
//

import Foundation
import UIKit
import SummerPlayerView

struct ThemeMaker {
    public static func getTheme() -> SummerPlayerViewTheme {
        
        let darkTheme : SummerPlayerViewTheme = DarkTheme()
        
        return darkTheme
    }
}
