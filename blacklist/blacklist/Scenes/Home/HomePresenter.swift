//
//  HomePresenter.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

typealias UpcomingsPaysClosure = (([Lending]) -> Void)

protocol HomeView: View {
    func doSomethingUI()
}

class HomePresenter: Presenter {
    typealias V = HomeView

    weak var view: V?

    func loadUpcomingsPays(completion: @escaping UpcomingsPaysClosure) {
        // TODO: Call to relam

        let amortization = AmortizationEntity(
            amount: 300_000,
            createdAt: Date(),
            updatedAt: nil,
            payments: 2,
            payment: 150_000,
            interest: 0.0,
            periods: [
                PeriodEntity(
                    period: 0,
                    date: Date(timeIntervalSinceNow: 604_800 / 2),
                    payment: 150_000,
                    principal: 150_000,
                    interest: 0.0,
                    balance: 150_000,
                    isPaid: false,
                    isInvalidatedPeriod: false
                ),
                PeriodEntity(
                    period: 1,
                    date: Date(timeIntervalSinceNow: 604_800 * 2),
                    payment: 150_000,
                    principal: 150_000,
                    interest: 0.0,
                    balance: 0.0,
                    isPaid: false,
                    isInvalidatedPeriod: false
                )
            ]
        )

        let debtor = DebtorEntity(
            firstName: "mateo",
            lastName: "olaya",
            company: "globant",
            image: nil,
            phone: "+57 302 2877216",
            email: nil,
            nickname: nil
        )

        let test = Array(repeating: LendingEntity(amortization: amortization, debtor: debtor), count: 1000)

        completion(test)
    }

    func call(to phone: String?) {
        guard let phone = phone else {
            // We can not call to this debtor, render an error.
            let error = AlertModel.Error(
                title: "PARTIAL_UIVIEWCONTROLLER_UPPPS".localized,
                message: "UPCOMING_HOME_ERROR_PHONE_NO_REGISTERED".localized
            )

            view?.show(alert: error)
            return
        }

        // TODO: Move this logic to Utils.swift when the brach is merged.
        let prefix = "telprompt://" + phone

        if let url = URL(string: prefix) {
            Application.open(url: url)
        } else {
            // We can not make calls from iPods, iPads and the simulator.
            let error = AlertModel.Error(
                title: "PARTIAL_UIVIEWCONTROLLER_UPPPS".localized,
                message: "UPCOMING_HOME_ERROR_DEVICE_CANNOT_MAKE_CALLS".localized
            )

            view?.show(alert: error)
        }
    }

    func mark(period: Period, asPaid: Bool) {
        // Let's complete the behavior
        print("Period \(period.period) is marked asPaid: \(asPaid)")
    }
}
