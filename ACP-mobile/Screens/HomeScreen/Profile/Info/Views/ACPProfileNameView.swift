//
//  ACPProfileNameView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 2. 1. 2023..
//

import UIKit
import SnapKit

class ACPProfileNameView: UIView {

    // MARK: - Properties

    // MARK: - Views

    let nameSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_name_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var nameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "personal_info_first_name")
        return view
    }()

    lazy var middleNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.attributedText = attributedTitleText()
        return view
    }()

    lazy var lastNameTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "personal_info_last_name")
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
        addSubview(nameSectionTitle)
        addSubview(nameTextField)
        addSubview(middleNameTextField)
        addSubview(lastNameTextField)
    }

    private func setupConstraints() {
        nameSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameSectionTitle.snp.bottom).offset(Constants.Constraints.FullNameTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        middleNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Constants.Constraints.MiddleNameTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(middleNameTextField.snp.bottom).offset(Constants.Constraints.LastNameTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }
    }

    // MARK: - Functions

    private func attributedTitleText() -> NSMutableAttributedString {
        let middleName = Constants.Text.MiddleName as NSString
        let fullRange = NSRange(location: 0, length: middleName.length)
        let string = NSMutableAttributedString(string: .localizedString(key: "profile_personal_middle_name"))
        string.addAttribute(.foregroundColor, value: UIColor.gray06Dark, range: fullRange)
        return string
    }

    // MARK: - Constants

    struct Constants {
        struct Constraints {
            static let LROffset = 35
            static let mainWidth = 320
            static let TextFieldSpacing = 20

            static let NameSectionTopOffset = 26
            static let FullNameTopOffset = 10
            static let MiddleNameTopOffset = 10
            static let LastNameTopOffset = 10
        }

        struct Text {
            static let MiddleName = "Middle Name"
        }
    }
}
