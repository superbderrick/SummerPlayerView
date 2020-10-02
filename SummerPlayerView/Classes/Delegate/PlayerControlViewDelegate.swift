//
//  PlayerControlViewDelegate.swift
//  SummerPlayerView
//
//  Created by derrick on 2020/09/13.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

protocol PlayerControlViewDelegate  {
    func didPressedBackButton()
    func didPressedPreviousButton()
    func didPressedNextButton()
    func didPressedAirPlayButton()
}
