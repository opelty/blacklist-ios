//
//  Animation.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/7/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

public struct Animation {
    
    /// Default animation value used by all the animations: 0.3 seconds
    static public let defaultDuration: TimeInterval = 1/3 // seconds
    
    public let duration: TimeInterval
    public let handler: ((UIView) -> Void)
    
    /**
     * Sets the `alpha` value of the view to `1.0`
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func fadeIn(duration: TimeInterval = Animation.defaultDuration) -> Animation {
        return Animation(duration: duration, handler: { $0.alpha = 1.0 })
    }
    
    /**
     * Sets the `alpha` value of the view to `0.0`
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func fadeOff(duration: TimeInterval = Animation.defaultDuration) -> Animation {
        return Animation(duration: duration, handler: { $0.alpha = 0.0 })
    }
    
    /**
     * Sets the `alpha` value of the view to the value given
     * - parameter to: The value to be used on the alpha.
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func fade(duration: TimeInterval = Animation.defaultDuration, to value: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.alpha = value })
    }
    
    /**
     * Moves the view to the coordinate given using `frame.origin`
     * - parameter to: The (x,y) coordinate
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func traslation(duration: TimeInterval = Animation.defaultDuration, to point: CGPoint) -> Animation {
        return Animation(duration: duration, handler: { $0.frame.origin = point })
    }
    
    /**
     * Changes the view size to the size given using `bounds.size`
     * - parameter to: The new size (width, height)
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func resize(duration: TimeInterval = Animation.defaultDuration, to size: CGSize) -> Animation {
        return Animation(duration: duration, handler: { $0.bounds.size = size })
    }
    
    /**
     * Scales the view size by the values given using `transform` and `CGAffineTransform`
     * - parameters:
     *    - toX: Value used to multiply with the current `width` of the view
     *    - toY: Value used to multiply with the current `height` of the view
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func scale(duration: TimeInterval = Animation.defaultDuration, toX x: CGFloat, toY y: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = CGAffineTransform(scaleX: x, y: y) })
    }
    
    /**
     * Rotate the view by the angle given using `transform.rotated`.
     * - note: This functions can be used infity times and everytime you will see how the view animation.
     * - parameter angle: Angle to rotate the view
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func rotated(duration: TimeInterval = Animation.defaultDuration, angle: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = $0.transform.rotated(by: angle) })
    }
    
    /**
     * Rotate the view by the angle given using `CGAffineTransform`.
     * - warning: This function can be only called when the rotating angle is different of the actual angle of the view, otherwise you will not see the animation.
     * - parameter angle: Angle to rotate the view
     * - returns: A struct describing the duration and closure of the animations associated.
     */
    static func rotating(duration: TimeInterval = Animation.defaultDuration, angle: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = CGAffineTransform(rotationAngle: angle) })
    }
    // Add generic animations...
}
