//
//  String.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/26/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Quick
import Nimble

@testable import blacklist

class StringSpecs: QuickSpec {
    override func spec() {
        describe("String's Extension") {
            it("must be able to remove a substring using remove function") {
                let dummyString = "$ THIS IS A TEST STRING %"

                expect(dummyString.remove(substring: "$")).to(equal(" THIS IS A TEST STRING %"))
                expect(dummyString.remove(substring: "%")).to(equal("$ THIS IS A TEST STRING "))
                expect(dummyString.remove(substring: "TEST ")).to(equal("$ THIS IS A STRING %"))
            }
        }
    }
}
