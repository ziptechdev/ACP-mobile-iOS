//
//  ApplyACPView.swift
//  ACP-mobile
//
//  Created by Abi  on 16. 10. 2022..
//

import UIKit
import SnapKit

// MARK: - ApplyACPViewDelegate

protocol ApplyACPViewDelegate: AnyObject {
    func didApplyNowButton()
    func didTapPlanButton()
    func didTapPhoneButton()
}

// swiftlint:disable:next type_body_length
class ApplyACPView: UIView {

    // MARK: - Properties

    weak var delegate: ApplyACPViewDelegate?

    private var shouldCollapse = false
    private var isMobileTapped = false

    // MARK: - Views

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray01Light
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
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
        label.numberOfLines = 0
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
        stackView.layer.cornerRadius = Constants.ButtonCornerRadius
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let planNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let planPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let planDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray06Dark
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
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
        button.layer.cornerRadius = Constants.ButtonCornerRadius
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let phoneSetupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let phoneSetupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .coreBlue
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
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
        stackView.spacing = 23
        stackView.backgroundColor = .coreLightBlue
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = Constants.ButtonCornerRadius
        stackView.layer.borderColor = UIColor.coreLightBlue.cgColor
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let buttonApplyStackView: UIStackView = {
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
        view.layer.cornerRadius = Constants.ButtonCornerRadius
        view.layer.borderColor = UIColor.coreLightBlue.cgColor
        return view
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()

        applyNowButton.addTarget(self, action: #selector(applyNowTapped), for: .touchUpInside)
        let planGesture = UITapGestureRecognizer(target: self, action: #selector(planTapped))
        planView.addGestureRecognizer(planGesture)
        let phoneViewGesture = UITapGestureRecognizer(target: self, action: #selector(mobileSetupTapped))
        phoneSetupStackView.addGestureRecognizer(phoneViewGesture)
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
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        planView.addSubview(planNameLabel)
        planView.addSubview(planPriceLabel)
        planView.addSubview(planDescriptionLabel)
        acpProgramStackView.addArrangedSubview(eligibleOrNotLabel)
        acpProgramStackView.addArrangedSubview(assistanceImageView)
        acpProgramStackView.addArrangedSubview(correctImageView)
        phoneSetupStackView.addArrangedSubview(phoneSetupLabel)
        phoneSetupStackView.addArrangedSubview(phoneImageView)
        buttonApplyStackView.addArrangedSubview(applyNowButton)

        addSubview(textStackView)
        addSubview(acpProgramStackView)
        addSubview(choosePlanLabel)
        addSubview(planView)
        addSubview(choosePlanSelectedImageView)
        addSubview(switchTextLabel)
        addSubview(phoneSetupStackView)
        addSubview(phoneSelectedImageView)
        addSubview(buttonApplyStackView)
    }

    // swiftlint:disable:next function_body_length
    private func setUpConstraints() {
        applyNowButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.ButtonHeight)
        }

        acpProgramStackView.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(Constants.ConstantTop)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
            make.height.equalTo(Constants.AcpStackViewHeight)
        }

        choosePlanLabel.snp.makeConstraints { make in
            make.top.equalTo(acpProgramStackView.snp.bottom).offset(Constants.AcpBottomOffest)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
        }

        planView.snp.makeConstraints { make in
            make.top.equalTo(choosePlanLabel.snp.bottom).offset(Constants.ConstantTop)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
            make.height.equalTo(Constants.NotExpandedHeight)
        }

        planNameLabel.snp.makeConstraints { make in
            make.left.equalTo(planView.snp.left).offset(Constants.ConstantTop)
            make.top.equalTo(planView.snp.top).offset(Constants.LeftPlanTopOffest)
        }

        planPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(planView.snp.right).inset(Constants.ConstantTop)
            make.centerY.equalTo(planNameLabel.snp.centerY)
        }

        planDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(planView.snp.left).inset(Constants.ConstantTop)
            make.top.equalTo(planNameLabel.snp.bottom).offset(Constants.LeadingConstant)
        }

        choosePlanSelectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(planView.snp.centerX)
            make.top.equalTo(planView.snp.top).offset(-Constants.LeftPlanTopOffest)
        }

        phoneImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.PhoneImageConstant)
        }

        phoneSelectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(phoneSetupStackView.snp.centerX)
            make.top.equalTo(phoneSetupStackView.snp.top).inset(-Constants.LeftPlanTopOffest)
        }

        switchTextLabel.snp.makeConstraints { make in
            make.top.equalTo(planView.snp.bottom).offset(Constants.LeadingConstant)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
        }

        phoneSetupStackView.snp.makeConstraints { make in
            make.top.equalTo(switchTextLabel.snp.bottom).offset(Constants.ConstantTop)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
            make.height.equalTo(Constants.HeightView)
        }

        textStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(Constants.TopConstant)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
        }

        buttonApplyStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneSetupStackView.snp.bottom).offset(Constants.BottomButtonConstant)
            make.left.right.equalToSuperview().inset(Constants.LeadingConstant)
        }
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

    private func planExpandedView(isCollapsed: Bool) {
        /*  total expanded height in design is 142, not expanded height is 65, label height is 67
            so adding additional 10 will ensure to follow height as on design for even larger text
            you can test this by adding additional text to planDescriptionLabel
         */
        let expandedHeightCalc = planDescriptionLabel.bounds.size.height + 75
        let height = isCollapsed ? Constants.NotExpandedHeight :  expandedHeightCalc
        UIView.animate(withDuration: 0.5) { [self] in
            self.shouldCollapse = !isCollapsed
            planView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            planDescriptionLabel.isHidden = isCollapsed
            choosePlanSelectedImageView.isHidden = isCollapsed
            if !isCollapsed {
                planView.layer.borderColor = UIColor.coreBlue.cgColor
                buttonApplyStackView.snp.updateConstraints { make in
                    make.top.equalTo(phoneSetupStackView.snp.bottom).offset(Constants.LeadingConstant)
                }
            } else {
                planView.layer.borderColor = UIColor.coreLightBlue.cgColor
                            buttonApplyStackView.snp.updateConstraints { make in
                                make.top.equalTo(phoneSetupStackView.snp.bottom).offset(Constants.BottomButtonConstant)
                            }
            }
            self.planView.layoutIfNeeded()
        }
    }

    private func setText() {
        titleLabel.text = .localizedString(key: "apply_acp_title")
        descriptionLabel.text = .formatLocalizedString(
            key: "apply_acp_description",
            values: "John"
        )
        eligibleOrNotLabel.text = .localizedString(key: "apply_acp_eligibility")
        applyNowButton.setTitle(titleKey: "apply_now_btn")
        planNameLabel.text = .localizedString(key: "apply_acp_plan_name")
        phoneSetupLabel.text = .localizedString(key: "apply_acp_phone_setup")
        choosePlanLabel.text = .localizedString(key: "apply_acp_choose_plan")
        switchTextLabel.text = .localizedString(key: "apply_acp_choose_device")
        // TODO: Check how we will get this data from BE
        planPriceLabel.attributedText = createAttributedString(
            string: "Free \n$30/mo",
            stringToStrike: "$30/mo"
        )

        let arrayOfLines = [
            "Unlimited Talk & Text and Data",
            " 7GB 4G LTE data",
            " Turn your phone into a Wi-Fi hotspot!"
        ]

        for value in arrayOfLines {
            planDescriptionLabel.text = (planDescriptionLabel.text ?? "")  + " • " + value + "\n"
        }
    }

    func createAttributedString(string: String, stringToStrike: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        let range = attributedString.mutableString.range(of: stringToStrike)
        attributedString.addAttributes([
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
            NSAttributedString.Key.foregroundColor: UIColor.gray01Light], range: range)
        return attributedString
    }

    // MARK: - Callbacks

    @objc func applyNowTapped(sender: UIButton!) {
        delegate?.didApplyNowButton()
    }

    @objc func planTapped() {
        if shouldCollapse {
            planExpandedView(isCollapsed: true)
        } else {
            // TODO: Add dynamic height for view
            planExpandedView(isCollapsed: false)
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

    // MARK: - Constants

    private struct Constants {
        static let TopConstant: CGFloat = 45
        static let LeadingConstant: CGFloat = 30
        static let BottomButtonConstant: CGFloat = 60
        static let ButtonHeight: CGFloat = 46
        static let ButtonContentSpacing: CGFloat = 10
        static let ButtonCornerRadius: CGFloat = 10
        static let ConstantTop: CGFloat = 20
        static let AcpStackViewHeight: CGFloat = 54
        static let AcpBottomOffest: CGFloat = 39
        static let HeightView: CGFloat = 65
        static let LeftPlanTopOffest: CGFloat = 23
        static let TopConstantOffest: CGFloat = 15
        static let PhoneImageConstant: CGFloat = 24
        static let NotExpandedHeight: CGFloat = 65
    }
}
