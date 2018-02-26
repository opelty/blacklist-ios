//
//  HomeViewController.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ViewControllerProtocol {
    struct Constants {
        static let emptyViewHeaderSize: CGFloat = 24.0
        static let emptyViewSubHeaderSize: CGFloat = 14.0

        struct PrototypeCells {
            static let headerCell = "HeaderCell"
        }
    }

    typealias P = HomePresenter
    typealias R = HomeRouter

    var presenter: HomePresenter!
    var router: HomeRouter?

    // TODO: Change this array type
    var upcomings: [Any] = Array(repeating: 1, count: 5)

    fileprivate var tableViewTopConstraintConstant: CGFloat = 0.0

    // IBOutlets
    @IBOutlet weak var lendingAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientContainerView: UIView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var maximumUpcomingHuggingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Let's configure the presenter

        configure { (context) -> (presenter: P, router: R?) in
            let presenter = P()
            let router = R(viewController: context)

            return (presenter: presenter, router: router)
        }

        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Add a bounce effect to the first cell
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let tableView = self?.tableView, tableView.visibleCells.count > 0 {
                if let cell = self?.tableView.visibleCells.first as? UpcomingTableViewCell {
                    cell.bounce()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepare(for: segue, sender: sender)
    }

    override func viewDidLayoutSubviews() {
        // Let's create the gradient layer
        let gradient = CAGradientLayer()
        gradient.frame = gradientContainerView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.95, 1.0]

        gradientContainerView.layer.mask = gradient

        super.viewDidLayoutSubviews()
    }

    func configure() {
        configureTableView()

        self.automaticallyAdjustsScrollViewInsets = false
    }
}

// MARK: - TableView DataSource

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func configureTableView() {
        // Let's configure the tableView
        let upcomingTableViewCellNib = UINib(nibName: UpcomingTableViewCell.identifier, bundle: nil)

        tableView.register(upcomingTableViewCellNib, forCellReuseIdentifier: UpcomingTableViewCell.identifier)

        tableView.estimatedRowHeight = 115.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.layoutIfNeeded()

        tableViewTopConstraintConstant = tableViewTopConstraint.constant

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }

    func addTableViewPlaceholderView() {
        let header = "Noting so far" // TODO: Localize this string
        let subheader = "You are on day :)" // TODO: Localize this string

        let view = UIView(frame: .zero)

        let headerLabel = UILabel(frame: .zero)
        let subheaderLabel = UILabel(frame: .zero)

        headerLabel.text = header
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: StyleSheet.Font.robotoRegular, size: Constants.emptyViewHeaderSize)
        headerLabel.textColor = StyleSheet.Color.Home.emptyHeaderText

        subheaderLabel.text = subheader
        subheaderLabel.textAlignment = .center
        subheaderLabel.font = UIFont(name: StyleSheet.Font.robotoLight, size: Constants.emptyViewSubHeaderSize)
        subheaderLabel.textColor = StyleSheet.Color.Home.emptySubHeaderText

        view.addSubview(headerLabel)
        view.addSubview(subheaderLabel)
        tableView.backgroundView = view

        view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false

        headerLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        headerLabel.centerYAnchor.constraint(
            equalTo: tableView.centerYAnchor,
            constant: -tableViewTopConstraintConstant
        ).isActive = true

        subheaderLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        subheaderLabel.centerYAnchor.constraint(
            equalTo: tableView.centerYAnchor,
            constant: -tableViewTopConstraintConstant + Constants.emptyViewHeaderSize
            ).isActive = true

        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        subheaderLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if upcomings.count > 0 {
            return 1
        } else {
            // Let's add the empty view placeholder
            addTableViewPlaceholderView()

            return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: UpcomingTableViewCell.identifier,
            for: indexPath
        ) as! UpcomingTableViewCell

        cell.registerHandler { [weak self] (cell, action) in
            self?.didPerform(action: action, in: cell)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UpcomingTableViewCell {
            cell.colapse()

            // TODO: Go to the detail view, sending the cell context
            router?.loanDetails(with: 2)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: Constants.PrototypeCells.headerCell)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? UpcomingTableViewCell {
            cell.colapse()
        }
    }

}

// MARK: - Actions Handler

extension HomeViewController {
    func didPerform(action: UpcomingTableViewCell.UpcomingAction, in cell: UpcomingTableViewCell) {
        switch action {
        case .phone:
            // TODO: get the phone number from the model

            presenter.call(to: "+573206532663")
            break
        case .check:
            router?.loanDetails(with: 2)
            break
        }
    }
}

// MARK: - ScrollView Delegate

extension HomeViewController {
    fileprivate func performMovement(for scrollView: UIScrollView, restartLayout: Bool) {
        guard !restartLayout else {
            tableViewTopConstraint.constant = tableViewTopConstraintConstant

            return
        }

        let y = tableViewTopConstraintConstant - scrollView.contentOffset.y

        tableViewTopConstraint.constant = y > 0 ? y : 0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !scrollView.isBouncing {
            performMovement(for: scrollView, restartLayout: false)
        } else {
            performMovement(for: scrollView, restartLayout: true)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !scrollView.isBouncing {
            performMovement(for: scrollView, restartLayout: false)
        } else {
            performMovement(for: scrollView, restartLayout: true)
        }
    }
}

// MARK: - IBActions

// MARK: - View interface

extension HomeViewController: HomeView {
    func go(to: String, sender: Any?) {

    }

    func doSomethingUI() {
        print("Hello World says presenter to the UI")
    }
}
