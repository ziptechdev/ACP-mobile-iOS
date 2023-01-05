//
//  ACPProfileViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit
import SnapKit

class ACPProfileViewController: UIViewController {

    // MARK: - Views
    let headerView = ACPProfileHeaderView()
    let footerView = ACPProfileSettingsView()

    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = "Change"

        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        headerView.delegate = self
        footerView.present()
    }

    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(footerView)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

        footerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

extension ACPProfileViewController: ACPProfileHeaderViewDelegate {
    func didTapPersonalInfo() {
        let vc = ACPProfileInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapSecurityInfo() {
        let vc = ACPProfileSecurityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapLegalInfo() {
        print("LEGAL BTN TAPPED")
    }

    func didTapLogout() {
        print("LOG OUT TAPPED")
    }
}
