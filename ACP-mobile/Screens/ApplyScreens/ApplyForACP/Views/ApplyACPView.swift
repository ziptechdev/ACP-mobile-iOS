//
//  ApplyACPView.swift
//  ACP-mobile
//
//  Created by Abi  on 16. 10. 2022..
//

import UIKit
import SnapKit

protocol ApplyACPViewDelegate: AnyObject {
    func didApplyNowButton()
    func didTapPlanButton()
    func didTapPhoneButton()
}
// swiftlint:disable:next type_body_length
class ApplyACPView: UIView {

    // MARK: - Properties
    
    weak var delegate: ApplyACPViewDelegate?
    var mainHeightConstraint: NSLayoutConstraint?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
        view.image = UIImage(named: "correctACP")
        return view
    }()
    let assistanceImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "snap")
        return view
    }()
    let eligibleOrNotLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let acpProgramStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.backgroundColor = .coreLightBlue
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        stackView.layer.borderColor = UIColor.coreBlue.cgColor
        stackView.spacing = 23
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    let choosePlanLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let planNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let planPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let planDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    let choosePlanSelectedImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "correctACP")
        view.isHidden = true
        return view
    }()
    let applyNowButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .gray06Light
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = false
        return button
    }()
    let phoneSelectedImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "correctACP")
        view.isHidden = true
        return view
    }()
    let switchTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let phoneSetupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let choosePlanStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.isUserInteractionEnabled = true
        stackView.backgroundColor = .coreLightBlue
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        stackView.layer.borderColor = UIColor.coreBlue.cgColor
        stackView.spacing = 23
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    let phoneSetupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let phoneImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "phone")
        return view
    }()
    private let phoneSetupStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.isUserInteractionEnabled = true
        stackView.backgroundColor = .coreLightBlue
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        stackView.layer.borderColor = UIColor.coreLightBlue.cgColor
        stackView.spacing = 23
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
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
    let planView: UIView = {
        let view = UIView()
        view.backgroundColor = .coreLightBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .coreLightBlue
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        view.layer.borderColor = UIColor.coreLightBlue.cgColor
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUpConstraints()
        setText()
        applyNowButton.addTarget(self, action: #selector(applyNowTapped), for: .touchUpInside)
        let planGesture = UITapGestureRecognizer(target: self, action: #selector(planTapped))
        planView.addGestureRecognizer(planGesture)
        let phoneViewGesture = UITapGestureRecognizer(target: self, action: #selector(mobileSetupTapped))
        phoneSetupStackView.addGestureRecognizer(phoneViewGesture)
    }
    func checkButtonAvailability() {
        if isMobileTapped && shouldCollapse {
            applyNowButton.backgroundColor = .coreBlue
            applyNowButton.isUserInteractionEnabled = true
        } else {
            applyNowButton.backgroundColor = .gray06Light
            applyNowButton.isUserInteractionEnabled = false
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func addSubviews() {
        planView.addSubview(planNameLabel)
        planView.addSubview(planPriceLabel)
        planView.addSubview(planDescriptionLabel)
        acpProgramStackView.addArrangedSubview(eligibleOrNotLabel)
        acpProgramStackView.addArrangedSubview(assistanceImageView)
        acpProgramStackView.addArrangedSubview(correctImageView)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        phoneSetupStackView.addArrangedSubview(phoneSetupLabel)
        phoneSetupStackView.addArrangedSubview(phoneImageView)
        buttonAndInfoStackView.addArrangedSubview(applyNowButton)
        
        addSubview(textStackView)
        addSubview(acpProgramStackView)
        addSubview(choosePlanLabel)
        addSubview(planView)
        addSubview(choosePlanSelectedImageView)
        addSubview(switchTextLabel)
        addSubview(phoneSetupStackView)
        addSubview(phoneSelectedImageView)
        addSubview(buttonAndInfoStackView)
    }
    // swiftlint:disable:next function_body_length
    private func setUpConstraints() {
        applyNowButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.Constraints.ButtonHeight)
        }
        acpProgramStackView.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(Constants.Constraints.constantTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
            make.height.equalTo(54)
        }
        choosePlanLabel.snp.makeConstraints { make in
            make.top.equalTo(acpProgramStackView.snp.bottom).offset(39)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
        planView.snp.makeConstraints { make in
            make.top.equalTo(choosePlanLabel.snp.bottom).offset(Constants.Constraints.constantTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
        mainHeightConstraint = planView.heightAnchor.constraint(equalToConstant: 65)
        mainHeightConstraint?.isActive = true
        planNameLabel.snp.makeConstraints { make in
            make.left.equalTo(planView.snp.left).offset(Constants.Constraints.constantTop)
            make.top.equalTo(planView.snp.top).offset(23)
        }
        planPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(planView.snp.right).inset(Constants.Constraints.constantTop)
            make.top.equalTo(planView.snp.top).offset(15)
        }
        planDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(planView.snp.left).inset(Constants.Constraints.constantTop)
            make.top.equalTo(planNameLabel.snp.bottom).offset(30)
        }
        choosePlanSelectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(planView.snp.centerX)
            make.top.equalTo(planView.snp.top).offset(-15)
        }
        phoneImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        phoneSelectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(phoneSetupStackView.snp.centerX)
            make.top.equalTo(phoneSetupStackView.snp.top).inset(-15)
        }
        switchTextLabel.snp.makeConstraints { make in
            make.top.equalTo(planView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
        phoneSetupStackView.snp.makeConstraints { make in
            make.top.equalTo(switchTextLabel.snp.bottom).offset(Constants.Constraints.constantTop)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
            make.height.equalTo(65)
        }
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.Constraints.TopConstant)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
        buttonAndInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneSetupStackView.snp.bottom).offset(60)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LeadingConstant)
        }
    }
    private var shouldCollapse = false
    private var isMobileTapped = false
    @objc func planTapped() {
        if shouldCollapse {
            animateView(isCollapse: false,
                        heighConstraint: 65)
        } else {
            // TODO: Add dynamic height for view
            animateView(isCollapse: true,
                        heighConstraint: 142)
            delegate?.didTapPlanButton()
        }
        checkButtonAvailability()
    }
    @objc func mobileSetupTapped() {
        if isMobileTapped {
            phoneView(isCollapse: false,
                      heighConstraint: 65)
        } else {
            // TODO: Add dynamic height for view
            phoneView(isCollapse: true,
                      heighConstraint: 142)
            delegate?.didTapPhoneButton()
        }
        checkButtonAvailability()
    }
    private func phoneView(isCollapse: Bool, heighConstraint: Double) {
        UIView.animate(withDuration: 0.5) { [self] in
            self.isMobileTapped = isCollapse
            phoneSelectedImageView.isHidden = !isCollapse
            if isCollapse {
                phoneSetupStackView.layer.borderColor = UIColor.coreBlue.cgColor
            } else {
                phoneSetupStackView.layer.borderColor = UIColor.coreLightBlue.cgColor
            }
            self.layoutIfNeeded()
        }
    }
    private func animateView(isCollapse: Bool, heighConstraint: Double) {
        UIView.animate(withDuration: 0.5) { [self] in
            self.shouldCollapse = isCollapse
            mainHeightConstraint?.constant = CGFloat(heighConstraint)
            planDescriptionLabel.isHidden = !isCollapse
            choosePlanSelectedImageView.isHidden = !isCollapse
            if isCollapse {
                planView.layer.borderColor = UIColor.coreBlue.cgColor
            } else {
                planView.layer.borderColor = UIColor.coreLightBlue.cgColor
            }
            self.planView.layoutIfNeeded()
        }
    }
    @objc func applyNowTapped(sender: UIButton!) {
        delegate?.didApplyNowButton()
    }
    private func setText() {
        titleLabel.text = Constants.Text.titleLabelEgibilityText
        descriptionLabel.text = Constants.Text.egibilityCheckText
        eligibleOrNotLabel.text = Constants.Text.eligbleOrNotText
        infoLabel.text = Constants.Text.personalNoteInfoText
        applyNowButton.setTitle(Constants.Text.checkEgTextButton, for: .normal)
        planNameLabel.text = "7GB Choose Plan"
        planPriceLabel.attributedText = "Free \n$30/mo".createAttributedString(stringtToStrike: "$30/mo")
        phoneSetupLabel.text = "One-click-setup phone"
        choosePlanLabel.text = "Choose plan:"
        switchTextLabel.text = "Choose device:"
        let arrayOfLines = ["Unlimited Talk & Text and Data"," 7GB 4G LTE data"," Turn your phone into a Wi-Fi hotspot!"]
        for value in arrayOfLines {
            planDescriptionLabel.text = (planDescriptionLabel.text ?? "")  + " • " + value + "\n"
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        struct Constraints {
            static let textFieldHeight: CGFloat = 40
            static let TopConstant: CGFloat = 45
            static let LeadingConstant: CGFloat = 30
            static let BottomButtonConstant: CGFloat = 118
            static let ButtonHeight: CGFloat = 46
            static let ButtonContentSpacing: CGFloat = 10
            static let ButtonCornerRadius: CGFloat = 10
            static let constantTop: CGFloat = 20
        }
        struct Text {
            static let checkEgTextButton = "Apply now"
            static let newAccountTextButton = "Visit website"
            static let titleLabelEgibilityText = "Apply for ACP"
            static let subTitleLabelText = "U.S. Department of Veteran Affairs"
            static let eligbleOrNotText = "Supplemental Nutrition AssistanceProgram (SNAP)"
            static let switchTexr = "Auto-renewal after expiration"
            // TODO: Add this string to localizable.
            // swiftlint:disable:next line_length
            static let egibilityCheckText: String = "Hi John! You can now easily apply for ACP because you are currently taking part in following government assistance programs:"
            // swiftlint:disable:next line_length
            static let personalNoteInfoText = "Your information is already stored in your profile. Simply press ‘Apply Now’ button to begin application process. It may take 2-3 business days for us to reach back."
            static let Terms: String = "assistance programs"
        }
    }
}
extension String {
    func createAttributedString(stringtToStrike: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let range = attributedString.mutableString.range(of: stringtToStrike)
        // swiftlint:disable:next line_length
        attributedString.addAttributes([
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.gray01Light], range: range)
        return attributedString
    }
}
