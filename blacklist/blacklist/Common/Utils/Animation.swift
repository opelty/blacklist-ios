//
//  Animation.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/7/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

public struct Animation {
    static public let defaultDuration: TimeInterval = 1/3 // seconds

    public let duration: TimeInterval
    public let handler: ((UIView) -> Void)

    static func fadeIn(duration: TimeInterval = Animation.defaultDuration) -> Animation {
        return Animation(duration: duration, handler: { $0.alpha = 1.0 })
    }

    static func bounce(duration: TimeInterval = Animation.defaultDuration, bounceOffset: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.frame.origin.x = bounceOffset })
    }

    static func resize(duration: TimeInterval = Animation.defaultDuration, to size: CGSize) -> Animation {
        return Animation(duration: duration, handler: { $0.bounds.size = size })
    }

    static func escalate(duration: TimeInterval = Animation.defaultDuration, toX x: CGFloat, toY y: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = CGAffineTransform(scaleX: x, y: y) })
    }

    static func rotated(duration: TimeInterval = Animation.defaultDuration, angle: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = $0.transform.rotated(by: angle) })
    }

    static func rotating(duration: TimeInterval = Animation.defaultDuration, angle: CGFloat) -> Animation {
        return Animation(duration: duration, handler: { $0.transform = CGAffineTransform(rotationAngle: angle) })
    }
    // Add generic animations...
}

extension UIView {
    public func animate(_ animations: Animation..., shouldParallelize: Bool = false) {
        if shouldParallelize {
            animate(inParallel: animations)
        } else {
            animate(animations)
        }
    }

    public func animate(inParallel animations: [Animation], endingWithAnimation endingAnimation: Animation) {
        for (index, animation) in animations.enumerated() {
            UIView.animate(withDuration: animation.duration, animations: {
                animation.handler(self)
            }, completion: { _ in
                if index == animations.count - 1 {
                    self.animate(endingAnimation)
                }
            })
        }
    }

    fileprivate func animate(_ animations: [Animation]) {
        guard !animations.isEmpty else {
            return
        }

        var animations = animations
        let animation = animations.removeFirst()

        UIView.animate(
            withDuration: animation.duration,
            animations: { animation.handler(self) },
            completion: { _ in self.animate(animations) }
        )
    }

    fileprivate func animate(inParallel animations: [Animation]) {
        for animation in animations {
            UIView.animate(withDuration: animation.duration) {
                animation.handler(self)
            }
        }
    }
}
