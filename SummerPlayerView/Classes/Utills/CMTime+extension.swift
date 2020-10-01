

import Foundation
import AVKit

/// CMTIme: it converts CMTime to double, float and format the CMTime object to representable on the UI.

extension CMTime {
    var asDouble: Double {
        get {
            return Double(self.value) / Double(self.timescale)
        }
    }
    var asFloat: Float {
        get {
            return Float(self.value) / Float(self.timescale)
        }
    }
}

extension CMTime: CustomStringConvertible {
    public var description: String {
        get {
            let seconds = Int(round(self.asDouble))
            return String(format: "%02d:%02d", seconds / 60, seconds % 60)
        }
    }
}

enum Controls {
    
    case playpause(Bool)
    case forward
    case back
    case slider
    case options
    

}
