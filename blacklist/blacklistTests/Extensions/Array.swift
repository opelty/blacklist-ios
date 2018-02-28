//
//  Array.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/26/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Quick
import Nimble

@testable import blacklist

class ArraySpecs: QuickSpec {
    override func spec() {
        describe("Array's Extension") {
            it("should be able to determine if it has the following index") {
                let dummyArray = Array(repeating: "", count: 10)

                for i in 0..<10 {
                    expect(dummyArray.has(index: i)).to(beTrue())
                }

                for i in 10..<20 {
                    expect(dummyArray.has(index: i)).to(beFalse())
                }
            }
        }
    }
}
