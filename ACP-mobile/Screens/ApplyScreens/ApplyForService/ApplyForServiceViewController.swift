//
//  ApplyForServiceViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 14. 10. 2022..
//

import UIKit
import SnapKit

class ApplyForServiceViewController: UIViewController {

    // MARK: - Views

    private let applyForACPView: ApplyForServiceView = {
        let view = ApplyForServiceView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        setupLeftNavigationBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        infoLabel.delegate = self
        applyForACPView.delegate = self
    }
    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setUpConstraints()
    }

    private func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(applyForACPView)
    }

    private func setUpConstraints() {
        applyForACPView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(infoLabel.snp.top)
        }

        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.HeaderInsetHorizontal)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.HeaderInsetVertical)
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let HeaderInsetHorizontal: CGFloat = 35
            static let HeaderInsetVertical: CGFloat = 5
            static let HeaderCornerRadius: CGFloat = 10
            static let HeaderHeight: CGFloat = 40
        }

        struct Text {
            static let Title = "Eligibility Check"
        }
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension ApplyForServiceViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
        print("Clicked on terms")
    }

    func didTapPrivacy() {
        // TODO: Add link
        print("Clicked on privacy")
    }

    func didTapTextLink() {
        print("Clicked on assistance ")
    }
}

// MARK: - ACPEligibilityDetailsDelegate

extension ApplyForServiceViewController: ApplyForServiceViewDelegate {
    func toogleSwitchToYes() {
        print("toogle on")
    }
    func toogleSwitchToNo() {
        print("toogle onoff")
    }
    func didApplyNowButton() {
        print("apply now")
        let targetVC = ApplyACPViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    func didTapVisitWebsiteButton() {
        print("visit website")
    }
}
