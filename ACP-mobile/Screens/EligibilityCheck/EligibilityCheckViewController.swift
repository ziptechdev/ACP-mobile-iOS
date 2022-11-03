//
//  EligibilityCheckViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 1. 10. 2022..
//

import UIKit
import SnapKit

class EligibilityCheckViewController: UIViewController {

    // MARK: - Views

    private let eligibilityView: EligibilityCheckView = {
        let view = EligibilityCheckView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "eligibility_page_title")
        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        infoLabel.delegate = self
        eligibilityView.delegate = self
    }
    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setUpConstraints()
    }

    private func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(eligibilityView)
    }

    private func setUpConstraints() {
        eligibilityView.snp.makeConstraints { make in
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
    }
}

// MARK: - ACPTermsAndPrivacyLabelDelegate

extension EligibilityCheckViewController: ACPTermsAndPrivacyLabelDelegate {
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

extension EligibilityCheckViewController: EligibilityCheckDelegate {
    func didTapCheckEligibilityButton() {
        let targetVC = EligibilityZipViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    func didTapCreateNewAccountButton() {
        let targetVC = ACPNotVerifiedRegistrationViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }
}
