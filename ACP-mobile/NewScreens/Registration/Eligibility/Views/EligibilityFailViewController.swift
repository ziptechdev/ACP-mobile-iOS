//
//  EligibilityFailViewController.swift
//  ACP-mobile
//
//  Created by Adi on 04/10/2022.
//

import UIKit
import SnapKit

class EligibilityFailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: EligibilityFailViewModel

    // MARK: - Views

    private let failCircle: CircleLoadingBarView = {
        let view = CircleLoadingBarView()
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
        label.text = .localizedString(key: "verify_fail_title")
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
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verify_fail_new_account")
        button.addTarget(self, action: #selector(didTapAccountButton), for: .touchUpInside)
        return button
    }()

    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "verify_fail_try_again")
        button.addTarget(self, action: #selector(didTapTryAgainButton), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "x_mark")?.withRenderingMode(.alwaysTemplate)
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .gray01Dark
        button.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    init(viewModel: EligibilityFailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
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
        view.addSubview(failCircle)
        view.addSubview(failImage)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(newAccountButton)
        view.addSubview(tryAgainButton)
        view.addSubview(cancelButton)
    }

    private func setupConstraints() {
        failImage.snp.makeConstraints { make in
            make.center.equalTo(failCircle.snp.center)
            make.width.height.equalTo(Constants.ImageSize)
        }

        failCircle.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(Constants.LoadingBarInsetY)
            make.left.right.equalToSuperview().inset(Constants.LoadingBarInsetX)
            make.height.equalTo(failCircle.snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(failCircle.snp.bottom).offset(Constants.TitleOffsetVertical)
            make.left.right.equalToSuperview().inset(Constants.LoadingBarInsetX)
            make.centerX.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.SubtitleOffsetY)
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
        }

        tryAgainButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.ButtonOffsetVertical)
        }

        newAccountButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.ContentInsetHorizontal)
            make.height.equalTo(Constants.ButtonHeight)
            make.top.equalTo(tryAgainButton.snp.bottom).offset(Constants.ButtonSpacingVertical)
        }

        cancelButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.CancelInsetHorizontal)
            make.height.width.equalTo(Constants.CancelButtonSize)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.CancelInsetVertical)
        }
    }

    private func subtitleAttributedText() -> NSAttributedString {
        let string: NSMutableAttributedString = .subtitleString(
            key: "verify_fail_subtitle",
            isCenter: true
        )

        let highlightRange = string.range(of: .localizedString(key: "verify_fail_highlight"))
        string.addAttribute(.foregroundColor, value: UIColor.coreBlue, range: highlightRange)

        return string
    }

    // MARK: - Callbacks

    @objc func didTapLabel(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender else {
            return
        }

        let string: String = .localizedString(key: "verify_fail_subtitle")
        let highlightRange = string.range(of: .localizedString(key: "verify_fail_highlight"))

        if sender.didTapAttributedTextInLabel(label: subtitleLabel, inRange: highlightRange) {
            viewModel.openNationalVerifier()
        }
    }

    // MARK: - Navigation

    @objc func didTapAccountButton() {
        viewModel.goToKYC()
    }

    @objc func didTapTryAgainButton() {
        viewModel.tryAgain()
    }

    @objc func didTapCancel() {
        didTapRightButton()
    }

    // MARK: - Constants

    private struct Constants {
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

        static let CancelInsetVertical: CGFloat = 38
        static let CancelInsetHorizontal: CGFloat = 35
        static let CancelButtonSize: CGFloat = 14
    }
}
