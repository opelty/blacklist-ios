//
//  CGFloat.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/26/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Quick
import Nimble

@testable import blacklist

class GCFloatSpecs: QuickSpec {
    override func spec() {
        describe("CGFloat's Extension") {
            context("should be able to convert any float number to his percentage representation") {
                it("must return any number between 0.0 and 1.0 without any modification") {
                    for i in 0...100 {
                        let percenatual = CGFloat(i / 100)

                        expect(percenatual.percentage).to(beCloseTo(1) || beCloseTo(0))
                        expect(percenatual.percentage).toNot(beGreaterThan(1))
                        expect(percenatual.percentage).toNot(beLessThan(0))
                    }
                }

                it("must return any number greater than 1 as 1.0 (100%)") {
                    let numbers = [1.5, 2.5, 10.0, 100.19999999, 1.000001]

                    for number in numbers {
                        expect(CGFloat(number).percentage).to(equal(1))
                    }
                }

                it("must return any number less than 0 as 0.0 (0%)") {
                    let numbers = [-1.5, -2.5, -10.0, -100.19999999, -0.000001]

                    for number in numbers {
                        expect(CGFloat(number).percentage).to(equal(0))
                    }
                }
            }
        }
    }
}
