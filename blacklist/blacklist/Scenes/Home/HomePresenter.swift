//
//  HomePresenter.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol HomeView: View {
    func doSomethingUI()
}

class HomePresenter: Presenter {
    typealias V = HomeView

    weak var view: V?

    func call(to phone: String) {
        let prefix = "telprompt://" + phone

        if let url = URL(string: prefix) {
            Application.open(url: url)
        }

        view?.go(to: "R", sender: nil)
    }

}
