//
//  ContentsMaker.swift
//  SummerPlayerViewDemo
//
//  Created by derrick on 2020/09/29.
//  Copyright © 2020 Derrick. All rights reserved.
//

import SummerPlayerView
import Foundation

struct ContentsMaker {
    public static func getContents() -> [Content] {
        
        let contents = [
            Content(title: "Newyork", url: "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8", thumbnail: "newyork",totalTime: "4:32"),
            Content(title: "Paris", url: "https://content.jwplatform.com/manifests/yp34SRmf.m3u8", thumbnail: "paris" , totalTime: "11:32"),
            Content(title: "Busan", url: "https://multiplatform-f.akamaihd.net/i/multi/will/bunny/big_buck_bunny_,640x360_400,640x360_700,640x360_1000,950x540_1500,.f4v.csmil/master.m3u8", thumbnail: "busan",totalTime: "4:32"),
            Content(title: "Copenhagen", url: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8", thumbnail: "cofenhagen",totalTime: "5:40"),
            Content(title: "SF", url: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8", thumbnail: "sf",totalTime: "3:32")
        ]
        
        return contents
    }
}
