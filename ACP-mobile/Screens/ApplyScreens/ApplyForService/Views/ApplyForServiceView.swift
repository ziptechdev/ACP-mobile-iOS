//
//  ApplyForServiceView.swift
//  ACP-mobile
//
//  Created by Abi  on 14. 10. 2022..
//

import UIKit
import SnapKit

protocol ApplyForServiceViewDelegate: AnyObject {
    func didApplyNowButton()
    func didTapVisitWebsiteButton()
    func toogleSwitchToYes()
    func toogleSwitchToNo()
}

class ApplyForServiceView: UIView {

    // MARK: - Properties

    weak var delegate: ApplyForServiceViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let correctImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "correct2")
        return view
    }()
    let eligibleOrNotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let eligibleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    let applyNowButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = false
        return button
    }()
    lazy var toggleSwitch: UISwitch = {
        let button = UISwitch()
        button.layer.masksToBounds = true
        button.isOn = true
        button.addTarget(self, action: #selector(handleToggleBT), for: .touchUpInside)
        return button
    }()
    let switchTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let switchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()

    let visitWebsiteButton: ACPImageButton = {
        let button = ACPImageButton(
            spacing: Constants.Constraints.ButtonContentSpacing,
            cornerRadius: Constants.Constraints.ButtonCornerRadius,
            imageName: "website",
            textColor: .coreBlue,
            isLeft: true
        )
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button

    }()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let buttonAndInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        setUpConstraints()
        setText()

        applyNowButton.addTarget(self, action: #selector(applyNowTapped), for: .touchUpInside)
        visitWebsiteButton.addTarget(self, action: #selector(visitWebsiteTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func addSubviews() {
        eligibleView.addSubview(correctImageView)
        eligibleView.addSubview(eligibleOrNotLabel)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subTitleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        textStackView.addArrangedSubview(eligibleView)
        switchStackView.addArrangedSubview(toggleSwitch)
        switchStackView.addArrangedSubview(switchTextLabel)
        buttonAndInfoStackView.addArrangedSubview(applyNowButton)
        buttonAndInfoStackView.addArrangedSubview(switchStackView)
        buttonAndInfoStackView.addArrangedSubview(visitWebsiteButton)
        buttonAndInfoStackView.addArrangedSubview(infoLabel)

        addSubview(textStackView)
        addSubview(buttonAndInfoStackView)
    }

    private func setUpConstraints() {
        visitWebsiteButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }

        applyNowButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }
        eligibleView.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.HeightView)
        }
        correctImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Constraints.ImageView)
        }
        eligibleOrNotLabel.snp.makeConstraints { make in
            make.left.equalTo(correctImageView.snp.right).offset(3)
        }
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.Constraints.TopConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
        buttonAndInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(Constants.Constraints.BottomTopConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
    }
    @objc func handleToggleBT() {
        if toggleSwitch.isOn {
            delegate?.toogleSwitchToYes()
        } else {
            delegate?.toogleSwitchToNo()
        }
    }
    @objc func applyNowTapped(sender: UIButton!) {
        delegate?.didApplyNowButton()
    }

    @objc func visitWebsiteTapped(sender: UIButton!) {
        delegate?.didTapVisitWebsiteButton()
    }
    private func setText() {
        titleLabel.text = Constants.Text.titleLabelEgibilityText
        subTitleLabel.text = Constants.Text.subTitleLabelText
        descriptionLabel.text = Constants.Text.egibilityCheckText
        eligibleOrNotLabel.text = Constants.Text.eligbleOrNotText
        infoLabel.text = Constants.Text.personalNoteInfoText
        switchTextLabel.text = Constants.Text.switchTexr
        applyNowButton.setTitle(Constants.Text.checkEgTextButton, for: .normal)
        visitWebsiteButton.setTitle(Constants.Text.newAccountTextButton, for: .normal)
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let textFieldHeight: CGFloat = 40
            static let TopConstant: CGFloat = 45
            static let LeadingConstant: CGFloat = 30
            static let BottomTopConstant: CGFloat = 5
            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let HeightView: CGFloat = 34
            static let ImageView: CGFloat = 24
        }

        struct Text {
            static let checkEgTextButton = "Apply now"
            static let newAccountTextButton = "Visit website"
            static let titleLabelEgibilityText = "Veterans Pension or Survivor Benefits"
            static let subTitleLabelText = "U.S. Department of Veteran Affairs"
            static let eligbleOrNotText = "You are eligible"
            static let switchTexr = "Auto-renewal after expiration"
            // TODO: Add this string to localizable.
            // swiftlint:disable:next line_length
            static let egibilityCheckText: String = "A VA Survivors Pension offers monthly payments to qualified surviving spouses and unmarried dependent children of wartime Veterans who meet certain income and net worth limits set by Congress."
            // swiftlint:disable:next line_length
            static let personalNoteInfoText = "Your information is already stored in your profile. Simply press ‘Apply Now’ button to begin application process. It may take 2-3 business days for us to reach back."
            static let Terms: String = "assistance programs"

        }
    }
}
