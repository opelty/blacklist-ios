//
//  LockViewController.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 3/5/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class LockViewController: UIViewController {

    // MARK: - IBoutlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var passCodeLabel: UILabel!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Methods

    private func setupView() {

    }

    private func setupCollectionView() {
        let flowLayout = LockLayout()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.setCollectionViewLayout(flowLayout, animated: true)

        collectionView.register(
            UINib(nibName: LockCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: LockCollectionViewCell.identifier
        )
    }

}

// MARK: - UICollectionView DataSource

extension LockViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LockCollectionViewCell.identifier, for: indexPath)

        guard let lockCell = cell as? LockCollectionViewCell else {
            assertionFailure("Unexpected cell type: \(type(of: cell))")
            return cell
        }

        lockCell.backgroundColor = .clear
        var number = indexPath.row + 1
        if number == 10 {
            number = 0
        }
        lockCell.textLabel.text = "\(number)"
        return cell
    }
}

// MARK: - UICollectionView Delegate

extension LockViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    }
}
