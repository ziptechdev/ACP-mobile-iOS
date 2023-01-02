//
//  ACPProfileAddressView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 2. 1. 2023..
//

import UIKit
import SnapKit

class ACPProfileAddressView: UIView {

    // MARK: - Properties
    var viewModel: ACPEligibilityDetailsViewModel?

    // MARK: - Views

    let addressSectionTitle: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_address_section")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gray06Dark
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var streetTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_street")
        return view
    }()

    lazy var cityTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_city")
        return view
    }()

    lazy var stateTextField: ACPPickerView = {
        let view = ACPPickerView()
        view.titleLabel.text = .localizedString(key: "eligibility_address_state")
        view.textField.addRightImage(named: "down_arrow")
        return view
    }()

    lazy var zipTextField: ACPTextField = {
        let view = ACPTextField()
        view.titleLabel.text = .localizedString(key: "eligibility_address_zip")

        view.textField.attributedPlaceholder = NSAttributedString(
            string: .localizedString(key: "profile_personal_address_placeholder"),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray01Dark]
        )
        view.textField.keyboardType = .numberPad
        view.textField.textAlignment = .center
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
        addSubview(addressSectionTitle)
        addSubview(streetTextField)
        addSubview(cityTextField)
        addSubview(stateTextField)
        addSubview(zipTextField)
    }

    private func setupConstraints() {
        addressSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
        }

        streetTextField.snp.makeConstraints { make in
            make.top.equalTo(addressSectionTitle.snp.bottom).offset(Constants.Constraints.AddressTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottom).offset(Constants.Constraints.CityTopOffset)
            make.left.equalTo(snp.left)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        stateTextField.snp.makeConstraints { make in
            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.StateTopOffset)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }

        zipTextField.snp.makeConstraints { make in
            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.ZIPTopOffset)
            make.left.equalTo(snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.right.equalTo(snp.right)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }
    }

    
    // MARK: - Constants

    struct Constants {
        struct Constraints {

            static let LROffset = 35
            static let mainWidth = 320
            static let TextFieldSpacing = 20

            static let AddressSectionTopOffset = 30
            static let AddressTopOffset = 10
            static let CityTopOffset = 10
            static let StateTopOffset = 10
            static let ZIPTopOffset = 10

            static let LRFieldWidth: CGFloat = 150
        }
    }
}
