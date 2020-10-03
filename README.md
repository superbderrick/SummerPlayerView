# SummerPlayerView
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

[![CI Status](https://img.shields.io/travis/Derrick/SummerPlayerView.svg?style=flat)](https://travis-ci.org/Derrick/SummerPlayerView)
[![Version](https://img.shields.io/cocoapods/v/SummerPlayerView.svg?style=flat)](https://cocoapods.org/pods/SummerPlayerView)
[![License](https://img.shields.io/cocoapods/l/SummerPlayerView.svg?style=flat)](https://cocoapods.org/pods/SummerPlayerView)
[![Platform](https://img.shields.io/cocoapods/p/SummerPlayerView.svg?style=flat)](https://cocoapods.org/pods/SummerPlayerView)

[![HitCount](http://hits.dwyl.com/superbderrick/https://githubcom/superbderrick/SummerPlayerView.svg)](http://hits.dwyl.com/superbderrick/https://githubcom/superbderrick/SummerPlayerView)




![](https://github.com/superbderrick/SummerSlider/blob/master/Image/logo.jpeg)

## SummerPlayerView
SummerPlayerView is an iOS Custom VideoPlayerView, It tried to make it as similar as possible a Youtube kids App's Player UI

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Demo

### Light theme
![With Light theme](https://github.com/superbderrick/SummerPlayerView/blob/master/demo/1.gif)

### Dark theme
![With Dark theme](https://github.com/superbderrick/SummerPlayerView/blob/master/demo/2.gif)

## Requirements
-	Swift 5.0+
-	iOS 13.0+
-	Xcode 11+

## Installation

SummerPlayerView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SummerPlayerView'
```

## Usage

Currently `SummerPlayerView` can be instantiated programatically only

#### Programatically

```swift 

import UIKit
import AVKit

import SummerPlayerView

class PlayerViewController: UIViewController  {
    
    let defaultConfig = DefaultConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testContents = ContentsMaker.getContents()
        let sampleTheme = ThemeMaker.getTheme()
        
        let summerPlayerView = SummerPlayerView(configuration: defaultConfig, theme: sampleTheme,targetView: view)
        
        summerPlayerView.delegate = self
        
        if let currentItem = testContents.first {
            summerPlayerView.setupPlayList(currentItem: currentItem, items: testContents)
        }
        
        view.addSubview(summerPlayerView)
        
        summerPlayerView.pinEdges(targetView: view)
        
    }
    
}

```

#### Configuration and theme

- Configure SummerPlayerView's theme and 
configurations, and target view where the video will appear like sample code

- Currently, only landscape mode is supported

#### Concepts

It tried to make it as similar as possible a Youtube kids App Player UI
Through SummerPlayerView, you can understand the following basic player actions

- Basic playback
- Loop playback
- Next or Previous playback with playlist
- Seek 
- HLS playback with AVQueueplayer

## Author

Derrick, kang.derrick@gmail.com

## License

SummerPlayerView is available under the MIT license. See the LICENSE file for more info.
