//
//  ApplyACPViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 16. 10. 2022..
//

import UIKit
import SnapKit

class ApplyACPViewController: UIViewController {

    // MARK: - Views

    private let applyACPView: ApplyACPView = {
        let view = ApplyACPView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Properties

    private let infoLabel = ACPTermsAndPrivacyLabel()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        title = .localizedString(key: "acp_title")
        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        infoLabel.delegate = self
        applyACPView.delegate = self
    }
    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setUpConstraints()
    }

    private func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(applyACPView)
    }

    private func setUpConstraints() {
        applyACPView.snp.makeConstraints { make in
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

extension ApplyACPViewController: ACPTermsAndPrivacyLabelDelegate {
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

extension ApplyACPViewController: ApplyACPViewDelegate {
    func didTapPlanButton() {
        print("plan tapped")
    }
    func didTapPhoneButton() {
        print("phone tapped")
    }
    func didApplyNowButton() {
        print("apply now")
        let targetVC = ACPSuccesViewController()
        navigationController?.pushViewController(targetVC, animated: true)

    }

}
