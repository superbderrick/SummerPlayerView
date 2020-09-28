//
//  Utills.swift
//  SummerPlayerView
//
//  Created by Derrick on 2020/09/15.
//  Copyright © 2020 Derrick. All rights reserved.
//

import UIKit

import Foundation
class Utills {
    
    public static func getWholeViewRect(_ viewRect:CGRect) -> CGRect? {
        var wholeStandardRect : CGRect
        let xAXIS = viewRect.size.width * 0.25
        let yAXIS :CGFloat = 0.0
        let WIDTH = viewRect.size.width/2
        let HEIGHT = viewRect.size.height * 0.7
        
        wholeStandardRect = CGRect(x: xAXIS, y: yAXIS, width: WIDTH, height: HEIGHT)
        
        return wholeStandardRect
    }
    
    public static func getQuarterViewRect(_ viewRect:CGRect) -> CGRect? {
        var wholeStandardRect : CGRect
        let xAXIS : CGFloat = 0.0
        let yAXIS : CGFloat = 0.0
        let WIDTH = viewRect.size.width
        let HEIGHT = viewRect.size.height * 0.6
        
        wholeStandardRect = CGRect(x: xAXIS, y: yAXIS, width: WIDTH, height: HEIGHT)
        
        return wholeStandardRect
    }
    
}
