//
//  ApplyForServiceView.swift
//  ACP-mobile
//
//  Created by Abi  on 14. 10. 2022..
//

import UIKit
import SnapKit

// MARK: - ApplyForServiceViewDelegate

protocol ApplyForServiceViewDelegate: AnyObject {
    func didApplyNowButton()
    func didTapVisitWebsiteButton()
    func toogleSwitchToYes()
    func toogleSwitchToNo()
}

class ApplyForServiceView: UIView {

    // MARK: - Properties

    weak var delegate: ApplyForServiceViewDelegate?

    // MARK: - Views

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let correctImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "correct2x")
        return view
    }()

    let eligibleOrNotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
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

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

        applyNowButton.addTarget(self, action: #selector(applyNowTapped), for: .touchUpInside)
        visitWebsiteButton.addTarget(self, action: #selector(visitWebsiteTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setUpConstraints()
        setText()
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
            make.left.equalTo(correctImageView.snp.right).offset(Constants.Constraints.TextLeftOffset)
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

    private func setText() {
        titleLabel.text = .localizedString(key: "service_title")
        descriptionLabel.text = .localizedString(key: "service_description")
        eligibleOrNotLabel.text = .localizedString(key: "eligible_check")
        infoLabel.text = .localizedString(key: "service_note")
        applyNowButton.setTitle(.localizedString(key: "apply_now_btn"), for: .normal)
        subTitleLabel.text = .localizedString(key: "service_subtitle")
        eligibleOrNotLabel.text = .localizedString(key: "eligble_check")
        switchTextLabel.text = .localizedString(key: "auto_renewal")
        visitWebsiteButton.setTitle(.localizedString(key: "visit_website_btn"), for: .normal)
    }

    // MARK: - Callbacks

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

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let TextLeftOffset: CGFloat = 3
            static let TopConstant: CGFloat = 45
            static let LeadingConstant: CGFloat = 30
            static let BottomTopConstant: CGFloat = 5
            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let HeightView: CGFloat = 34
            static let ImageView: CGFloat = 24
        }
    }
}
