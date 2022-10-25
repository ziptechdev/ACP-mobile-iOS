//
//  ACPProfileViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit
import SnapKit

class ACPProfileViewController: UIViewController {

    //MARK: Views

    let headerView = ACPProfileHeaderView()

    let tableView: ACPTableView = {
        let view = ACPTableView(style: .grouped)
        view.backgroundColor = .gray06Light
        return view
    }()

    //MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = Constants.Text.Title
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }

    //MARK: - UI

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
        tableView.registerHeaderFooter(ACPProfileSettingsView.self)
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

//MARK: - UITableViewDataSource
extension ACPProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.backgroundColor = .gray06Light
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ACPProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: ACPProfileSettingsView = tableView.dequeueHeaderFooter()
        header.present()
        return header
    }
}
