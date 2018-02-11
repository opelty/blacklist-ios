//
//  Amortization.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol Amortization {
    var amount: Double { get }
    var createdAt: Date { get }
    var updatedAt: Date? { get }
    var payments: Int { get }
    var payment: Double { get }
    var interest: Float? { get }

    // Relationships
    var periods: [Period] { get }
}

struct AmortizationEntity: Amortization {
    internal var amount: Double
    internal var createdAt: Date
    internal var updatedAt: Date?
    internal var payments: Int
    internal var payment: Double
    internal var interest: Float?
    internal var periods: [Period]
}
