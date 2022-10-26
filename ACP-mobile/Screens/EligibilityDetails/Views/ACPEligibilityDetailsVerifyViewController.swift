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
        label.text = "0%"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "verify_process_title")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = subtitleAttributedText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        label.addGestureRecognizer(tap)
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verify_process_btn", textColor: .coreBlue)
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    private lazy var failButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "Force Fail", textColor: .coreBlue)
        button.addTarget(self, action: #selector(testNav), for: .touchUpInside)
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

        setupTest()
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
        let string: NSMutableAttributedString = .subtitleString(
            key: "verify_process_subtitle",
            isCenter: true
        )

        let highlightRange = string.range(of: .localizedString(key: "verify_process_highlight"))
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

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
            goToSuccess()
        }
    }

    @objc func didTapCancel() {
        loadingTimer?.invalidate()

        navigationController?.popViewController(animated: true)
    }

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let string: String = .localizedString(key: "verify_process_subtitle")
        let highlightRange = string.range(of: .localizedString(key: "verify_process_highlight"))

        if sender.didTapAttributedTextInLabel(label: subtitleLabel, inRange: highlightRange) {
            // TODO: Add Link
            print("NationalVerifier")
        }
    }

    // MARK: - TEST

    private func setupTest() {
        view.addSubview(failButton)

        failButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInsetHorizontal)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(cancelButton.snp.bottom).offset(20)
        }
    }

    @objc func testNav() {
        loadingTimer?.invalidate()

        let targetVC = ACPEligibilityDetailsFailViewController()
        navigationController?.pushViewController(targetVC, animated: true)
    }

    // MARK: - Navigation

    private func goToSuccess() {
        let viewController = ACPEligibilityDetailsSuccessViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func goToFail() {
        let viewController = ACPEligibilityDetailsFailViewController()
        navigationController?.pushViewController(viewController, animated: true)
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

        struct Numbers {
            // TODO: Add real time
            static let LoadingTime: Double = 10
        }
    }
}
