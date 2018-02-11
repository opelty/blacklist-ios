//
//  Debtor.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol Debtor {
    var firstName: String { get }
    var lastName: String? { get }
    var company: String? { get }
    var image: String? { get }
    var phone: String? { get }
    var email: String? { get }
    var nickname: String? { get }
}

struct DebtorEntity: Debtor {
    internal var firstName: String
    internal var lastName: String?
    internal var company: String?
    internal var image: String?
    internal var phone: String?
    internal var email: String?
    internal var nickname: String?
}
