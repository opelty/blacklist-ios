//
//  DebtorsViewController.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/22/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class DebtorsViewController: UIViewController, ViewControllerProtocol {

    // MARK: - IBOutlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Vars & Constants

    typealias Presenter = DebtorsPresenter
    typealias Router = DebtorsRouter

    var presenter: DebtorsPresenter!
    var router: DebtorsRouter?
    var debtors: [Debtor] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Let's configure the presenter

        configure { (context) -> (presenter: Presenter, router: Router?) in
            let presenter = Presenter()
            let router = Router(viewController: context)

            return (presenter: presenter, router: router)
        }
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Methods

    func configure() {
        presenter.loadDebtors()
        configureCollectionView()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let sectionInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        let itemsPerRow: CGFloat = 3
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
        flowLayout.sectionInset = sectionInsets
        flowLayout.minimumLineSpacing = sectionInsets.left

        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: DebtorCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: DebtorCollectionViewCell.identifier
        )
    }

}

// MARK: - DebtorsView conformance

extension DebtorsViewController: DebtorsView {
    func go(to: String, sender: Any?) {

    }

    func showDebtors(debtors: [Debtor]) {
        self.debtors = debtors
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource

extension DebtorsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return debtors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let debtorCell = collectionView.dequeueReusableCell(withReuseIdentifier: DebtorCollectionViewCell.identifier, for: indexPath) as? DebtorCollectionViewCell

        guard let cell = debtorCell else {
            assertionFailure("Unexpected cell type: \(type(of: debtorCell))")
            return UICollectionViewCell()
        }

        let debtor = debtors[indexPath.row]
        cell.setCellData(debtor: debtor)

        return cell
    }
}

// MARK: - UICollectionView Delegate

extension DebtorsViewController: UICollectionViewDelegate {

}
