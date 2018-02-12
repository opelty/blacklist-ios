//
//  RealmLending.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLending: Object {
    @objc dynamic var r_amortization: RealmAmortization?
    @objc dynamic var r_debtor: RealmDebtor?
}

extension RealmLending: Lending {
    var amortization: Amortization {
        return AmortizationEntity(
            amount: r_amortization?.amount ?? 0.0,
            createdAt: r_amortization?.createdAt ?? Date(),
            updatedAt: r_amortization?.updatedAt,
            payments: r_amortization?.payments ?? 0,
            payment: r_amortization?.payment ?? 0.0,
            interest: r_amortization?.interest,
            periods: r_amortization?.periods ?? []
        )
    }

    var debtor: Debtor {
        return DebtorEntity(
            firstName: r_debtor?.firstName ?? "",
            lastName: r_debtor?.lastName,
            company: r_debtor?.company,
            image: r_debtor?.image,
            phone: r_debtor?.phone,
            email: r_debtor?.email,
            nickname: r_debtor?.nickname
        )
    }
}
