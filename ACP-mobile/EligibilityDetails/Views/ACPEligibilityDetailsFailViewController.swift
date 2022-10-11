//
//  ACPEligibilityDetailsFailViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class ACPEligibilityDetailsFailViewController: UIViewController {

    // MARK: - Views

    private let failCircle: ACPCircleLoadingBarView = {
        let view = ACPCircleLoadingBarView()
        view.barColor = .warningRed
        return view
    }()

    private let failImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .warningRed
        view.contentMode = .scaleAspectFill
        view.image = image
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.attributedText = subtitleAttributedText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        label.addGestureRecognizer(tap)
        return label
    }()

    private lazy var newAccountButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.NewAccount, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapAccountButton), for: .touchUpInside)
        return button
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.TryAgain, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = false

        setupRightNavigationBarButton()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(failCircle)
        view.addSubview(failImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(newAccountButton)
        view.addSubview(tryAgainButton)
    }

    private func setupConstraints() {
        failImage.snp.makeConstraints { make in
            make.center.equalTo(failCircle.snp.center)
            make.width.height.equalTo(Constants.Constraints.ImageSize)
        }

        failCircle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.LoadingBarInsetY)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LoadingBarInsetX)
            make.height.equalTo(failCircle.snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(failCircle.snp.bottom).offset(Constants.Constraints.TitleOffsetVertical)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LoadingBarInsetX)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetY)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        tryAgainButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        newAccountButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(tryAgainButton.snp.bottom).offset(Constants.Constraints.ButtonSpacingVertical)
        }
    }

    private func subtitleAttributedText() -> NSAttributedString {
        let subtitle = Constants.Text.Subtitle as NSString
        let fullRange = NSRange(location: 0, length: subtitle.length)
        let attributeRange = subtitle.range(of: Constants.Text.NationalVerifier)

        let string = NSMutableAttributedString(string: Constants.Text.Subtitle)
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: fullRange)
        string.addAttribute(.paragraphStyle, value: NSMutableParagraphStyle.center, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: attributeRange)

        return string
    }

    // MARK: - Callbacks

    @objc func didTapAccountButton() {
        // TODO: Add Stuff
    }

    @objc func didTapTryAgainButton() {
        // TODO: Add Stuff
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let subtitle = Constants.Text.Subtitle as NSString
        let attributeRange = subtitle.range(of: Constants.Text.NationalVerifier)

        if sender.didTapAttributedTextInLabel(label: subtitleLabel, inRange: attributeRange) {
            // TODO: Add Link
            print("NationalVerifier")
        }
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let LoadingBarInsetY: CGFloat = 30
            static let LoadingBarInsetX: CGFloat = 64

            static let ImageSize: CGFloat = 36

            static let TitleOffsetVertical: CGFloat = 63

            static let ContentInsetHorizontal: CGFloat = 35
            static let SubtitleOffsetY: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 60
            static let ButtonSpacingVertical: CGFloat = 30
            static let ButtonCornerRadius: CGFloat = 10
        }

        struct Text {
            static let Title = "We could not verify your identity."
            static let NationalVerifier = "National Verifier"
            static let Subtitle = "You either entered wrong information or there is no such data in National Verifier system."
            static let TryAgain = "Try Again"
            static let NewAccount = "New Account"
        }
    }
}
