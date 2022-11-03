//
//  ACPTransactionsViewController.swift
//  ACP-mobile
//
//  Created by Adi on 29/10/2022.
//

import UIKit
import SnapKit

class ACPTransactionsViewController: UIViewController {

    // MARK: - Properties

    private var observer: NSKeyValueObservation?

    // MARK: - Views

    private let tableView: ACPTableView = {
        let view = ACPTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        observer = tableView.observe(\.contentSize, options: [.new]) { (tableView, change) in
            guard let newValue = change.newValue else { return }

            tableView.snp.updateConstraints { make in
                make.height.equalTo(newValue.height)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        observer?.invalidate()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .clear

        addSubviews()
        setupConstraints()
        setupTableView()
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.HorizontalInset)
            make.top.equalToSuperview().inset(Constants.TopInset)
            make.bottom.equalToSuperview().inset(Constants.BottomInset)
            make.height.equalTo(0)
        }
    }

    private func setupTableView() {
        tableView.register(ACPTransactionsCell.self)

        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Callbacks

    // MARK: - Constants

    private struct Constants {
        static let TopInset: CGFloat = 30
        static let HorizontalInset: CGFloat = 35
        static let BottomInset: CGFloat = 10
    }
}

// MARK: - UITableViewDataSource

extension ACPTransactionsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int.random(in: 4...8)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ACPTransactionsCell = tableView.dequeue(at: indexPath)
        cell.configureCell()
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ACPTransactionsViewController: UITableViewDelegate {
}
