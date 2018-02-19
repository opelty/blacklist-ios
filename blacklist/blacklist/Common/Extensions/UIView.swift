//
//  UIView.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/8/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

extension UIView {
    func addCircleLayer(lineWidth: CGFloat = 0.0, backgroundColor: UIColor, strokeColor: UIColor? = nil) {

        let halfSize = bounds.height / 2

        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: halfSize, y: halfSize),
            radius: halfSize - lineWidth,
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true
        )

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath

        circleLayer.fillColor = backgroundColor.cgColor
        circleLayer.strokeColor = strokeColor?.cgColor
        circleLayer.lineWidth = lineWidth

        layer.addSublayer(circleLayer)
    }
}

// MARK: - Animations

extension UIView {

    /**
     * Perform the animations given in the current view
     * - parameters:
     *   - animations: The animations to be executed
     *   - shouldParallelize: If the animations given should be executed at the same time. Default value is `false`
     */
    public func animate(_ animations: Animation..., shouldParallelize: Bool = false) {
        animate(animations: animations, shouldParallelize: shouldParallelize)
    }

    /**
     * Perform the animations given in the current view
     * - parameters:
     *   - animations: The animations to be executed
     *   - shouldParallelize: If the animations given should be executed at the same time. Default value is `false`
     */
    public func animate(animations: [Animation], shouldParallelize: Bool = false) {
        if shouldParallelize {
            animate(inParallel: animations)
        } else {
            animate(animations)
        }
    }

    /**
     * Perform parallelized animations finishing with sequentially animations
     * - parameters:
     *   - inParallel: The animations to be executed in parallel mode
     *   - endingWithAnimations: The animation to be executed once all the parallelized animations had finished.
     */
    public func animate(inParallel animations: [Animation], endingWithAnimations endingAnimations: [Animation]) {
        for (index, animation) in animations.enumerated() {
            UIView.animate(withDuration: animation.duration, animations: {
                animation.handler(self)
            }, completion: { _ in
                if index == animations.count - 1 {
                    self.animate(endingAnimations)
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
