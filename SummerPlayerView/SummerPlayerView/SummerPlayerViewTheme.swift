
import UIKit


public protocol SummerPlayerViewTheme {
    var buttonTintColor: UIColor { get }
    var headerBackgroundColor: UIColor { get }
    var headerBackgroundOpacity: Float { get }
    var playListCurrentItemTextColor: UIColor { get }
    
    var playListCurrentItemFont: UIFont { get }
    
    var timeLabelTextColor: UIColor { get }
    var sliderTintColor: UIColor { get }
    var sliderThumbColor: UIColor { get }
    

    var contentsListviewBackground: UIColor { get }
    var activityViewColor: UIColor { get }
    var totalTimeLabelTextColor: UIColor { get }
    var totalTimeLableTextFont: UIFont { get }
    var totalTimeLableBackground: UIColor { get }
    
}

public struct defaultTheme: SummerPlayerViewTheme {

    
    
    public var headerBackgroundOpacity: Float = 0.3
    public var buttonTintColor: UIColor = .white
    public var headerBackgroundColor: UIColor = .black
    public var playListCurrentItemTextColor: UIColor = .white
    
    public var timeLabelTextColor: UIColor = .white
    public var sliderTintColor: UIColor = .white
    public var sliderThumbColor: UIColor = .white
    
    
    public var playListCurrentItemFont = UIFont.systemFont(ofSize: 17.0)
    

    
    public var totalTimeLableTextFont = UIFont.boldSystemFont(ofSize: 13)
    public var contentsListviewBackground: UIColor = .black
    public var activityViewColor: UIColor = .black
    public var totalTimeLabelTextColor: UIColor = .white
    public var totalTimeLableBackground: UIColor = .black

}
