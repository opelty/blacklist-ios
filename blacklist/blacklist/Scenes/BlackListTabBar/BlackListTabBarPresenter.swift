//
//  BlackListTabBarPresenter.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/22/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol BlackListTabBarView: View {

}

class BlackListTabBarPresenter: Presenter {
    typealias V = BlackListTabBarView

    weak var view: V?

}
