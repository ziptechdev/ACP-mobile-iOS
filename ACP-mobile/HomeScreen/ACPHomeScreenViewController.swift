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

    let viewModel = ["Programme 1", "Programme for disabled 2"]

    // MARK: - Views

    let headerView = ACPHomeScreenHeaderView()

    let tableView: ACPTableView = {
        let view = ACPTableView()
        view.backgroundColor = .gray06Light
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
        view.addSubview(headerView)
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }

    private func setupTableView() {
        tableView.register(ACPHomeScreenEligibilityCell.self)
        tableView.register(ACPHomeScreenProgramCell.self)

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
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: ACPHomeScreenEligibilityCell = tableView.dequeue(at: indexPath)
            cell.present()
            return cell
        } else {
            let cell: ACPHomeScreenProgramCell = tableView.dequeue(at: indexPath)
            cell.present(name: viewModel[indexPath.row - 1])
            return cell
        }

    }
}

// MARK: - UITableViewDelegate

extension ACPHomeScreenViewController: UITableViewDelegate {}