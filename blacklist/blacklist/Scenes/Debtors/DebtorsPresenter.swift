//
//  DebtorsPresenter.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/22/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol DebtorsView: View {
    func showDebtors(debtors: [Debtor])
}

class DebtorsPresenter: Presenter {
    typealias V = DebtorsView

    weak var view: V?

    func loadDebtors() {
        // TODO: Call Realm or whatever to get the debtors list

        var debtors: [Debtor] = [
            DebtorEntity(firstName: "Mateo", lastName: "Olaya", company: nil, image: nil, phone: nil, email: nil, nickname: "Molayab"),
            DebtorEntity(firstName: "Jose", lastName: "Lopez", company: nil, image: nil, phone: nil, email: nil, nickname: "Josed"),
            DebtorEntity(firstName: "Santiago", lastName: "Carmona", company: nil, image: nil, phone: nil, email: nil, nickname: "Santicarmo")
        ]

        for _ in 0...30 {
            debtors.append(debtors.first!)
        }

        view?.showDebtors(debtors: debtors)
    }

}
