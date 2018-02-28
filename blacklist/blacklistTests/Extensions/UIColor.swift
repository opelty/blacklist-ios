//
//  UIColor.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/26/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Quick
import Nimble

@testable import blacklist

class UIColorSpecs: QuickSpec {
    override func spec() {
        describe("UIColor's Extension") {
            it("should be able to initialize a color with an hexadecimal context") {
                let black = UIColor.init(hex: 0x0)
                expect(black.hashValue).to(equal(UIColor.black.hashValue))

                let realWhite = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                let white = UIColor.init(hex: 0xFFFFFF)
                expect(white.hashValue).to(equal(realWhite.hashValue))

                let red = UIColor.init(hex: 0xFF0000)
                expect(red.hashValue).to(equal(UIColor.red.hashValue))

                let green = UIColor.init(hex: 0x00FF00)
                expect(green.hashValue).to(equal(UIColor.green.hashValue))

                let blue = UIColor.init(hex: 0x0000FF)
                expect(blue.hashValue).to(equal(UIColor.blue.hashValue))
            }
        }
    }
}
