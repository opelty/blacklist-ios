//
//  LockCollectionViewCell.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 3/6/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class LockCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var blurVieew: UIVisualEffectView!

    // MARK: - Vars & Constants

    public static var identifier: String {
        return String(describing: self)
    }

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        containerView.layer.cornerRadius = containerView.frame.width / 2
        blurVieew.layer.cornerRadius = blurVieew.frame.width / 2
    }

    private func setup() {
        textLabel.textColor = .white
        textLabel.font = UIFont.get(withType: .robotoRegular, size: 30)
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)

    }

}
