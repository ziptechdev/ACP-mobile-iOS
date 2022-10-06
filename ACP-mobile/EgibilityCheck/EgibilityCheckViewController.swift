//
//  EgibilityCheckViewController.swift
//  ACP-mobile
//
//  Created by Abi  on 1. 10. 2022..
//

import UIKit

class EgibilityCheckViewController: UIViewController {
    
    private let egibilityView: EgibilityCheckView = {
        let view = EgibilityCheckView()
        view.translatesAutoresizingMaskIntoConstraints = false
     //   view.backgroundColor = .white
        return view
    }()
    
    private let infoLabel = ACPTermsAndPrivacyLabel()
    
    // MARK: - Properties
    
    
    // MARK: - Views
    
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        infoLabel.delegate = self
        egibilityView.delegate = self
    }
    // MARK: - UI
    
    func setupUI() {
        view.backgroundColor = .white
        
        addSubviews()
        setUpConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(egibilityView)
    }
    private func setUpConstraints() {
        
        egibilityView.snp.makeConstraints { make in
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

extension EgibilityCheckViewController: ACPTermsAndPrivacyLabelDelegate {
    func didTapTerms() {
        // TODO: Add link
        print("Clicked on terms")
    }
    
    func didTapPrivacy() {
        // TODO: Add link
        print("Clicked on privacy")
    }
}
// MARK: - ACPEligibilityDetailsDelegate

extension EgibilityCheckViewController: EgibilityCheckDelegate {
    func didTapCheckEgibilityButton() {
        let targetVC = EgibilityZipViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func didTapCreateNewAccountButton() {
        print("Create new account")
    }
}
