//
//  HomeViewController.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, ViewControllerProtocol {
    typealias P = HomePresenter
    typealias R = HomeRouter

    var presenter: HomePresenter!

    struct Constants {
        static let upcomingTableViewCell = "UpcomingTableViewCell"
    }

    fileprivate var tableViewTopConstraintConstant: CGFloat = 0.0

    // IBOutlets
    @IBOutlet weak var lendingAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientContainerView: UIView!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var maximumUpcomingHuggingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        // Let's configure the presenter
        super.viewDidLoad()

        configure { (context) -> P! in
            let presenter = HomePresenter()
            presenter.router = HomeRouter(viewController: context)

            return presenter
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
        presenter.router?.prepare(for: segue, sender: sender)
    }

    override func viewDidLayoutSubviews() {
        // Let's create the gradient layer
        let gradient = CAGradientLayer()
        gradient.frame = gradientContainerView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.9, 1.0]

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
        let upcomingTableViewCellNib = UINib(nibName: Constants.upcomingTableViewCell, bundle: nil)
        tableView.register(upcomingTableViewCellNib, forCellReuseIdentifier: Constants.upcomingTableViewCell)

        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension

        tableViewTopConstraintConstant = tableViewTopConstraint.constant

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.upcomingTableViewCell,
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
            presenter.router?.loanDetails(with: 2)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
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
            break
        }
    }
}

// MARK: - ScrollView Delegate

extension HomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = tableViewTopConstraintConstant - scrollView.contentOffset.y

        if !scrollView.isBouncing && y > 0 {
            tableViewTopConstraint.constant = y
        }
    }
}

// MARK: - IBActions

// MARK: - View interface

extension HomeViewController: HomeView {
    func doSomethingUI() {
        print("Hello World says presenter to the UI")
    }
}
