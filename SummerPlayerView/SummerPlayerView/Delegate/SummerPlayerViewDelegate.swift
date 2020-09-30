//
//  SummerPlayerviewDelegate.swift
//  SummerPlayerView
//
//  Created by derrick on 2020/09/13.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

public protocol SummerPlayerViewDelegate {
    func didPressedBackButton()
    func didPressedNextButton()
    func didPressedPreviousButton()
    func didPressedAirPlayButton()
    func didPressedMoreButton()
    func didPressedCollectionView(index:Int)
}
