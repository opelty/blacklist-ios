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
        static let secondsBeforeBounceEffect: TimeInterval = 1.0

        struct PrototypeCells {
            static let headerCell = "HeaderCell"
            static let estimatedRowHeight: CGFloat = 115.0
            static let upcomingsHeaderheight: CGFloat = 50.0
        }
    }

    typealias Presenter = HomePresenter
    typealias Router = HomeRouter

    var presenter: HomePresenter!
    var router: HomeRouter?

    var upcomings: [Lending] = []

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

        configure { (context) -> (presenter: Presenter, router: Router?) in
            let presenter = Presenter()
            let router = Router(viewController: context)

            return (presenter: presenter, router: router)
        }

        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Add a bounce effect to the first cell
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.secondsBeforeBounceEffect) { [weak self] in
            if let tableView = self?.tableView, tableView.visibleCells.count > 0 {
                if let cell = self?.tableView.visibleCells.first as? UpcomingTableViewCell {
                    cell.bounce()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Let's load the data
        loadData()
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

    func loadData() {
        presenter.loadUpcomingsPays { [unowned vc = self] (lendings) in
            // Let's modify the UI, so call to the Main thread.

            DispatchQueue.main.async {
                vc.upcomings.removeAll()
                vc.upcomings.append(contentsOf: lendings)

                vc.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView DataSource

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func configureTableView() {
        // Let's configure the tableView
        let upcomingTableViewCellNib = UINib(nibName: UpcomingTableViewCell.identifier, bundle: nil)

        tableView.register(upcomingTableViewCellNib, forCellReuseIdentifier: UpcomingTableViewCell.identifier)

        tableView.estimatedRowHeight = Constants.PrototypeCells.estimatedRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.layoutIfNeeded()

        tableViewTopConstraintConstant = tableViewTopConstraint.constant

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView = nil

        if upcomings.count > 0 {
            return 1
        } else {
            // Let's add the empty view placeholder
            tableView.addPlaceholderView(withHeader: "Nothing so far", subheader: "You are on day :)")
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

        guard upcomings.has(index: indexPath.row) else { fatalError() }
        let upcomming = upcomings[indexPath.row]

        if let upcomingPeriod = upcomming.amortization.upcomingPeriod {
            cell.setupCell(for: upcomming.debtor, period: upcomingPeriod)
            cell.registerHandler { [weak self] (cell, action) in
                self?.didPerform(action: action, in: cell)
            }
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
        return Constants.PrototypeCells.upcomingsHeaderheight
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
        case .call(let to):
            presenter.call(to: to)
        case .mark(let to):
            presenter.mark(period: cell.period, asPaid: to == .paid ? true : false)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            cell.colapse()
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
    func doSomethingUI() {
        print("Hello World says presenter to the UI")
    }
}
