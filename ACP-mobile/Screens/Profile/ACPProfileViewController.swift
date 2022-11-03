//
//  ACPProfileViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 3. 11. 2022..
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
        title = Constants.Text.Title
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

    // MARK: - Constants
       private struct Constants {
           struct Text {
               static let Title = "Profile"
           }
       }
}

extension ACPProfileViewController: ACPProfileHeaderViewDelegate {
    func didTapPersonalInfo() {
        let vc = ACPPersonalInfoViewControllerEldar()
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapSecurityInfo() {
        let vc = ACPProfileSecurityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func didTapLegalInfo() {
        print("LEGAL BTN TAPPED")
    }
}
