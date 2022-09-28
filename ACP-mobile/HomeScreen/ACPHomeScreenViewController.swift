//
//  ACPHomeScreenViewController.swift
//  ACP-mobile
//
//  Created by Adi on 26/09/2022.
//

import UIKit
import SnapKit

class ACPHomeScreenViewController: UIViewController {

    // MARK: - Properties

    let viewModel = ""

    // MARK: - Views

    let tableView: ACPTableView = {
        let view = ACPTableView()
        view.backgroundColor = .blue
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.Text.Title

        setupUI()

        setupTableView()
    }

    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Constants

    private struct Constants {
        struct Text {
            static let Title = "Home"
        }
    }
}

// MARK: - UITableViewDataSource

extension ACPHomeScreenViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension ACPHomeScreenViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ACPHomeScreenTableHeaderView()
        headerView.setupUI()
        return headerView
    }
}

