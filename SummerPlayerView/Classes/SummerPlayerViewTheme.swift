
import UIKit


public protocol SummerPlayerViewTheme {
    
    var backgroundViewColor:UIColor{get}
    var sliderTintColor: UIColor { get }
    var sliderThumbColor: UIColor { get }
    var contentsListviewBackground: UIColor { get }
    var activityViewColor: UIColor { get }
    var totalTimeLabelTextColor: UIColor { get }
    var totalTimeLableTextFont: UIFont { get }
    var totalTimeLableBackground: UIColor { get }
    var playerScreenTimelabelsBackground: UIColor { get }
    var playerScreenTimelabelsTextFont: UIFont { get }
    var playerScreenTimelabelsTextColor: UIColor { get }
    var playerScreenTitleLabelBackground: UIColor { get }
    var playerScreenTitleLabelTextFont: UIFont { get }
    var playerScreenTitleLabelTextColor: UIColor { get }
    
}

public struct defaultTheme: SummerPlayerViewTheme {
    public var backgroundViewColor: UIColor =  .black
    public var totalTimeLableTextFont = UIFont.boldSystemFont(ofSize: 13)
    public var contentsListviewBackground: UIColor = .black
    public var activityViewColor: UIColor = .black
    public var totalTimeLabelTextColor: UIColor = .white
    public var totalTimeLableBackground: UIColor = .black
    public var sliderTintColor: UIColor = .red
    public var sliderThumbColor: UIColor = .red
    public var playerScreenTimelabelsBackground: UIColor = .clear
    public var playerScreenTimelabelsTextFont: UIFont = UIFont.boldSystemFont(ofSize: 13)
    public var playerScreenTimelabelsTextColor: UIColor = .white
    public var playerScreenTitleLabelBackground: UIColor = .clear
    public var playerScreenTitleLabelTextFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
    public var playerScreenTitleLabelTextColor: UIColor = .white
}
