//
//  Period.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol Period {
    var period: Int { get }
    var date: Date { get }
    var payment: Double { get }
    var principal: Double { get }
    var interest: Float? { get }
    var balance: Double { get }
    var isPaid: Bool { get }
    var isInvalidatedPeriod: Bool { get }
}

struct PeriodEntity: Period {
    internal var period: Int
    internal var date: Date
    internal var payment: Double
    internal var principal: Double
    internal var interest: Float?
    internal var balance: Double
    internal var isPaid: Bool
    internal var isInvalidatedPeriod: Bool
}
