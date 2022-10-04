//
//  ACPEligibilityDetailsVerifyViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class ACPEligibilityDetailsVerifyViewController: UIViewController {

    // MARK: - Properties

    private var loadingPercentage = 0
    private var loadingTimer: Timer?

    // MARK: - Views

    private let loadingBar = ACPCircleLoadingBarView()

    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Countdown
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.Title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = subtitleAttributedText()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.Text.Cancel, for: .normal)
        button.setTitleColor(.coreBlue, for: .normal)
        button.setTitleColor(.coreBlue, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        setupLoadingTimer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = .white

        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(loadingBar)
        view.addSubview(loadingLabel)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cancelButton)
    }

    private func setupConstraints() {
        loadingLabel.snp.makeConstraints { make in
            make.center.equalTo(loadingBar.snp.center)
        }

        loadingBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.Constraints.LoadingBarInsetY)
            make.left.right.equalToSuperview().inset(Constants.Constraints.LoadingBarInsetX)
            make.height.equalTo(loadingBar.snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(loadingBar.snp.bottom).offset(Constants.Constraints.TitleOffsetVertical)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffsetY)
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
        }

        cancelButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }
    }

    private func subtitleAttributedText() -> NSAttributedString {
        let subtitle = Constants.Text.Subtitle as NSString
        let fullRange = NSRange(location: 0, length: subtitle.length)
        let attributeRange = subtitle.range(of: Constants.Text.NationalVerifier)

        let string = NSMutableAttributedString(string: Constants.Text.Subtitle)
        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .regular), range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.gray01Light, range: fullRange)
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: attributeRange)

        return string
    }

    // MARK: - Loading

    private func setupLoadingTimer() {
        let timeBetweenUpdates = Constants.Numbers.LoadingTime / 100

        loadingTimer = .scheduledTimer(
            timeInterval: timeBetweenUpdates,
            target: self,
            selector: #selector(updateLoadingPercentage),
            userInfo: nil,
            repeats: true
        )

        loadingBar.timeInterval = Constants.Numbers.LoadingTime
        loadingBar.progressAnimation()
    }

    // MARK: - Callbacks

    @objc func updateLoadingPercentage() {
        loadingPercentage += 1
        loadingLabel.text = "\(loadingPercentage)%"

        if loadingPercentage == 100 {
            loadingTimer?.invalidate()
        }
    }

    @objc func didTapCancel() {
        navigationController?.popViewController(animated: true)
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
            static let LoadingBarInsetY: CGFloat = 169
            static let LoadingBarInsetX: CGFloat = 64

            static let TitleOffsetVertical: CGFloat = 63

            static let ContentInsetHorizontal: CGFloat = 35
            static let SubtitleOffsetY: CGFloat = 10

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 45
        }

        struct Text {
            static let Title = "Verifying..."
            static let Countdown = "0%"
            static let NationalVerifier = "National Verifier"
            static let Subtitle = "We are back-checking your information through National Verifier. It may take a few minutes."
            static let Cancel = "Cancel"
        }

        struct Numbers {
            // TODO: Add real time
            static let LoadingTime: Double = 20
        }
    }
}
