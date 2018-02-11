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
