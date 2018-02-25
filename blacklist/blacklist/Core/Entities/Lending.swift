//
//  Lending.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol Lending {
    var amortization: Amortization { get }
    var debtor: Debtor { get }
}

struct LendingEntity: Lending {
    internal var amortization: Amortization
    internal var debtor: Debtor
}
