//
//  ACPProfileInfoViewControllerUI.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 15. 12. 2022..
//

import UIKit

extension ACPProfileInfoViewController {

    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(scrolLView)
        scrolLView.addSubview(titleLabel)
        scrolLView.addSubview(nameSectionTitle)
        scrolLView.addSubview(nameTextField)
        scrolLView.addSubview(middleNameTextField)
        scrolLView.addSubview(lastNameTextField)
        scrolLView.addSubview(DOBSectionTitle)
        scrolLView.addSubview(monthTextField)
        scrolLView.addSubview(dayTextField)
        scrolLView.addSubview(yearTextField)
        scrolLView.addSubview(addressSectionTitle)
        scrolLView.addSubview(streetTextField)
        scrolLView.addSubview(cityTextField)
        scrolLView.addSubview(stateTextField)
        scrolLView.addSubview(zipTextField)
        scrolLView.addSubview(SSNSectionTitle)
        scrolLView.addSubview(ssnTextField)
        scrolLView.addSubview(saveButton)
    }

    func setupConstraints() {
        scrolLView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrolLView).inset(Constants.Constraints.TitleTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        nameSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.NameSectionTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameSectionTitle.snp.bottom).offset(Constants.Constraints.FullNameTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        middleNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Constants.Constraints.MiddleNameTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(middleNameTextField.snp.bottom).offset(Constants.Constraints.LastNameTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        DOBSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(Constants.Constraints.DOBSectionTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(DOBSectionTitle.snp.bottom).offset(Constants.Constraints.MonthTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.DayTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }

        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(Constants.Constraints.YearTopOffset)
            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.right.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }

        addressSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(Constants.Constraints.AddressSectionTopOffset)
            make.left.equalTo(scrolLView).offset(Constants.Constraints.LROffset)
        }

        streetTextField.snp.makeConstraints { make in
            make.top.equalTo(addressSectionTitle.snp.bottom).offset(Constants.Constraints.AddressTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(streetTextField.snp.bottom).offset(Constants.Constraints.CityTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        stateTextField.snp.makeConstraints { make in
            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.StateTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.right.equalTo(view.snp.centerX).inset(Constants.Constraints.TextFieldSpacing / 2)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }

        zipTextField.snp.makeConstraints { make in
            make.top.equalTo(cityTextField.snp.bottom).offset(Constants.Constraints.ZIPTopOffset)
            make.left.equalTo(view.snp.centerX).offset(Constants.Constraints.TextFieldSpacing / 2)
            make.right.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.LRFieldWidth)
        }

        SSNSectionTitle.snp.makeConstraints { make in
            make.top.equalTo(zipTextField.snp.bottom).offset(Constants.Constraints.SSNSectionTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        ssnTextField.snp.makeConstraints { make in
            make.top.equalTo(SSNSectionTitle.snp.bottom).offset(Constants.Constraints.SSNTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.width.equalTo(Constants.Constraints.mainWidth)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(ssnTextField.snp.bottom).offset(Constants.Constraints.ButtonTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.width.equalTo(Constants.Constraints.mainWidth)
            make.bottom.equalToSuperview()
        }

    }

    // MARK: - Constants

    struct Constants {
        struct Constraints {

            static let LROffset = 35
            static let mainWidth = 320
            static let TextFieldSpacing = 20

            static let TitleTopOffset = 60

            static let NameSectionTopOffset = 26
            static let FullNameTopOffset = 10
            static let MiddleNameTopOffset = 10
            static let LastNameTopOffset = 10

            static let DOBSectionTopOffset = 30
            static let MonthTopOffset = 10
            static let DayTopOffset = 10
            static let YearTopOffset = 10

            static let AddressSectionTopOffset = 30
            static let AddressTopOffset = 10
            static let CityTopOffset = 10
            static let StateTopOffset = 10
            static let ZIPTopOffset = 10

            static let SSNSectionTopOffset = 10
            static let SSNTopOffset = 10

            static let ButtonTopOffset = 10
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10

            static let LRFieldWidth: CGFloat = 150
        }

        struct Text {
            static let Title = "Profile"
            static let MainTitle = "Personal information"
            static let FullNameSection = "Name"
            static let FirstName = "First Name"
            static let MiddleName = "Middle Name"
            static let LastName = "Last Name"
            static let DOBSection = "Date of Birth"
            static let Month = "Month"
            static let Day = "Day"
            static let Year = "Year"
            static let AddressSection = "Address"
            static let StreetNumberName = "Street Number and Name"
            static let City = "City"
            static let State = "State"
            static let ZIPCode = "ZIP Code"
            static let ZipPlaceholder = "92805 - 1483"
            static let SSN = "SSN (Social Security Number)"
            static let SaveButtonText = "Save"
        }
    }
}
