//
//  MessageView.swift
//  blacklist
//
//  Created by Santiago Carmona gonzalez on 3/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class MessageView: UIView {

    // MARK: - IBOutlets

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!

    // MARK: - Vars & Constants

    private let emptyViewHeaderSize: CGFloat = 24.0
    private let emptyViewSubHeaderSize: CGFloat = 14.0

    // MARK: - Life Cycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setup()
    }

    convenience init(frame: CGRect, headerText header: String, subheaderText subheader: String? = nil) {
        self.init(frame: frame)
        headerLabel.text = header
        subheaderLabel.text = subheader
    }

    // MARK: - Methods

    private func commonInit() {
        let view = Bundle.main.loadNibNamed("MessageView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }

    private func setup() {
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.get(withType: .robotoRegular, size: emptyViewHeaderSize)
        headerLabel.textColor = StyleSheet.Color.Home.emptyHeaderText

        subheaderLabel.textAlignment = .center
        subheaderLabel.font = UIFont.get(withType: .robotoLight, size: emptyViewSubHeaderSize)
        subheaderLabel.textColor = StyleSheet.Color.Home.emptySubHeaderText
    }
}
