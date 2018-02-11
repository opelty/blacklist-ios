//
//  RealmAmortization.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation
import RealmSwift

class RealmAmortization: Object {
    @objc dynamic var r_amount: Double = 0.0
    @objc dynamic var r_createdAt: Date = Date()
    @objc dynamic var r_updatedAt: Date?
    @objc dynamic var r_payments: Int = 0
    @objc dynamic var r_payment: Double = 0.0

    // Relationships
    let r_periods = List<RealmPeriod>()

    // Non-Objc Optionals
    let r_interest = RealmOptional<Float>()
}

extension RealmAmortization: Amortization {
    var amount: Double {
        return r_amount
    }

    var createdAt: Date {
        return r_createdAt
    }

    var updatedAt: Date? {
        return r_updatedAt
    }

    var payments: Int {
        return r_payments
    }

    var payment: Double {
        return r_payment
    }

    var interest: Float? {
        return r_interest.value
    }

    var periods: [Period] {
        return r_periods.map({ (realmPeriod) -> Period in
            return PeriodEntity(
                period: realmPeriod.period,
                date: realmPeriod.date,
                payment: realmPeriod.payment,
                principal: realmPeriod.principal,
                interest: realmPeriod.interest,
                balance: realmPeriod.balance,
                isPaid: realmPeriod.isPaid,
                isInvalidatedPeriod: realmPeriod.isInvalidatedPeriod
            )
        })
    }
}
