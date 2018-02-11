//
//  Debtor.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDebtor: Object {
    @objc dynamic var r_firstName: String?
    @objc dynamic var r_lastName: String?
    @objc dynamic var r_company: String?
    @objc dynamic var r_image: String?
    @objc dynamic var r_phone: String?
    @objc dynamic var r_email: String?
    @objc dynamic var r_nickname: String?
}

extension RealmDebtor: Debtor {
    var firstName: String? {
        return r_firstName
    }

    var lastName: String? {
        return r_lastName
    }

    var company: String? {
        return r_company
    }

    var image: String? {
        return r_image
    }

    var phone: String? {
        return r_phone
    }

    var email: String? {
        return r_email
    }

    var nickname: String? {
        return r_nickname
    }
}
