//
//  ACPProfileSSNView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 2. 1. 2023..
//

import UIKit
import SnapKit

class ACPProfileSSNView: UIView {

    // MARK: - Properties

    // MARK: - Views

    let SSNSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_ssn_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var ssnTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_dob_ssn")
        view.textField.keyboardType = .numberPad
        return view
    }()

    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(SSNSectionTitle)
        addSubview(ssnTextField)
    }

    private func setupConstraints() {
        SSNSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
        }

        ssnTextField.snp.makeConstraints { make in
            make.top.equalTo(SSNSectionTitle.snp.bottom).offset(Constants.Constraints.SSNTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }
    }

    // MARK: - Constants

    struct Constants {
        struct Constraints {

            static let LROffset = 35
            static let mainWidth = 320

            static let SSNSectionTopOffset = 10
            static let SSNTopOffset = 10
        }
    }
}
