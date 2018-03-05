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
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - Vars & Constants

    typealias Presenter = DebtorsPresenter
    typealias Router = DebtorsRouter

    private let continueButtonRadius: CGFloat = 25.0
    private let continueButtonShadowOffset: CGSize = CGSize(width: 0.0, height: 1.0)
    private let continueButtonShadowOppacity: Float = 1.0
    private let continueButtonTextSize: CGFloat = 30
    private let bottomSpaceInset: CGFloat = 30
    private let searchPlaceHolder: String = "Buscar"
    private let minimumCollectionCellWidth: CGFloat = 120
    private var itemsPerRow: CGFloat {
        return (Utils.screenWidth / minimumCollectionCellWidth).rounded(.down)
    }
    private var debtors: [Debtor] = []

    var presenter: DebtorsPresenter!
    var router: DebtorsRouter?

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
        setup()
        configureCollectionView()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    func setup() {
        setupButton()
        setupSearchBar()
        view.backgroundColor = StyleSheet.Color.Debtors.background
    }

    func setupSearchBar() {
        searchBar.tintColor = StyleSheet.Color.Debtors.green
        searchBar.placeholder = searchPlaceHolder
    }

    func setupButton() {
        continueButton.backgroundColor = StyleSheet.Color.Debtors.green
        continueButton.layer.cornerRadius = continueButtonRadius
        continueButton.layer.shadowOpacity = continueButtonShadowOppacity
        continueButton.layer.shadowOffset = continueButtonShadowOffset
        continueButton.titleLabel?.font = UIFont.get(withType: .robotoLight, size: continueButtonTextSize)
    }

    func configureCollectionView() {
        let flowLayout = getCollectionViewLayout()
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: DebtorCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: DebtorCollectionViewCell.identifier
        )
    }

    func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let sectionInsets = UIEdgeInsets(top: 10, left: 20, bottom: continueButton.frame.height + bottomSpaceInset, right: 20)
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
        flowLayout.sectionInset = sectionInsets
        flowLayout.minimumLineSpacing = sectionInsets.left

        return flowLayout
    }

    // MARK: - IBActions

    @IBAction func continueAction(_ sender: UIButton) {
        router?.goToContinueAction()
    }

}

// MARK: - DebtorsView conformance

extension DebtorsViewController: DebtorsView {
    func showDebtors(debtors: [Debtor]) {
        self.debtors = debtors
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource

extension DebtorsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if debtors.count > 0 {
            return 1
        }
        collectionView.backgroundView = PlaceholderView(frame: collectionView.frame, headerText: "No debtors found", subheaderText: ":)")
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return debtors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DebtorCollectionViewCell.identifier, for: indexPath)

        guard let debtorCell = cell as? DebtorCollectionViewCell else {
            assertionFailure("Unexpected cell type: \(type(of: cell))")
            return cell
        }

        let debtor = debtors[indexPath.row]
        debtorCell.setCellData(debtor: debtor)

        return cell
    }
}

// MARK: - UICollectionView Delegate

extension DebtorsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let debtorCell = collectionView.cellForItem(at: indexPath) as? DebtorCollectionViewCell
        debtorCell?.selectCell()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let debtorCell = collectionView.cellForItem(at: indexPath) as? DebtorCollectionViewCell
        debtorCell?.deselectCell()
    }
}
