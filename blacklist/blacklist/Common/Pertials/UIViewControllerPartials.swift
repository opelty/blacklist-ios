//
//  UIViewControllerPartials.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/26/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

struct AlertModel {
    struct Error {
        var title: String?
        var message: String?
    }
}

extension UIViewController {
    func show(error: AlertModel.Error) {
        let alert = UIAlertController(
            title: error.title,
            message: error.message,
            preferredStyle: .alert
        )

        let dismiss = UIAlertAction(
            title: "PARTIAL_UIVIEWCONTROLLER_OK".localized,
            style: .cancel,
            handler: nil
        )

        alert.addAction(dismiss)

        self.present(alert, animated: true, completion: nil)
    }
}
