//
//  DebtorCollectionViewCell.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/22/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class DebtorCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var monsterImageView: UIImageView!
    @IBOutlet weak var debtorNameLabel: UILabel!
    @IBOutlet weak var monsterContainerView: UIView!
    @IBOutlet weak var checkMarkImageView: UIImageView!

    // MARK: - Vars & Constants

    static var identifier: String {
        return String(describing: self)
    }

    // MARK: - Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Methods

    func setCellData(debtor: Debtor) {
        var completeName = debtor.firstName

        if let lastName = debtor.lastName {
            completeName += " \(lastName)"
        }

        debtorNameLabel.text = completeName
    }

    func selectCell() {
        monsterContainerView.alpha = 0.3
        checkMarkImageView.isHidden = false
    }

    func deselectCell() {
        monsterContainerView.alpha = 1.0
        checkMarkImageView.isHidden = true
    }
}
