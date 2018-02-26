//
//  UpcomingTableViewHeader.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/25/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class UpcomingTableViewHeader: UITableViewCell {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        roundedView.layer.masksToBounds = true

        titleLabel.text = "UPCOMING_HOME_UPCOMING_PAYS".localized
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        roundedView.layer.cornerRadius = roundedView.bounds.size.height / 2.0
    }
}
