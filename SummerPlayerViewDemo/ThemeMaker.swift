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
        
        var theme:SummerPlayerViewTheme = LightTheme()
        if #available(iOS 13.0, *) {
            switch UIScreen.main.traitCollection.userInterfaceStyle {
            case .dark:
                theme  = DarkTheme()
                break
            case .light:
                theme  = LightTheme()
                break
                
            case .unspecified:
                theme  = LightTheme()
                break
                
            @unknown default:
                theme  = LightTheme()
            }
        }
        return theme
    }
}
