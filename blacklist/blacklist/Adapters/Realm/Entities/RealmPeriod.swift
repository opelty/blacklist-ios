//
//  RealmPeriod.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation
import RealmSwift

class RealmPeriod: Object {
    @objc dynamic var r_period: Int = 0
    @objc dynamic var r_date: Date = Date()
    @objc dynamic var r_payment: Double = 0.0
    @objc dynamic var r_principal: Double = 0.0
    @objc dynamic var r_balance: Double = 0.0
    @objc dynamic var r_paid: Bool = false
    @objc dynamic var r_invalidated: Bool = false

    let r_interest = RealmOptional<Float>()
}

extension RealmPeriod: Period {
    var period: Int {
        return r_period
    }

    var date: Date {
        return r_date
    }

    var payment: Double {
        return r_payment
    }

    var principal: Double {
        return r_principal
    }

    var interest: Float? {
        return r_interest.value
    }

    var balance: Double {
        return r_balance
    }

    var isPaid: Bool {
        return r_paid
    }

    var isInvalidatedPeriod: Bool {
        return r_invalidated
    }
}
