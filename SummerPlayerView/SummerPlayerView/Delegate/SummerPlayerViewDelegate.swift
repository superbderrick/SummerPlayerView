//
//  SummerPlayerviewDelegate.swift
//  SummerPlayerView
//
//  Created by derrick on 2020/09/13.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

public protocol SummerPlayerViewDelegate {
    func didPressBackButton()
    func didPressNextButton()
    func didPressPreviousButton()
    func didPressAirPlayButton()
    func didPressMoreButton()
    func didPressContentsListView(index:Int)
    func didPressPlayButton(isActive:Bool)
}
