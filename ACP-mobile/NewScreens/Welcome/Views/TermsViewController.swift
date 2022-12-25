//
//  TermsViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 7. 10. 2022..
//

import UIKit
import SnapKit

class TermsViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: WelcomeViewModel

    // MARK: - Views

    private lazy var leftTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")?.withRenderingMode(.alwaysTemplate)
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray06Light
        return img
    }()

    private lazy var rightTopLine: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "tab_line")?.withRenderingMode(.alwaysTemplate)
        img.contentMode = .scaleAspectFit
        img.tintColor = .coreBlue
        return img
    }()

    private lazy var termsText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "terms_title")
        lbl.numberOfLines = 0
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 32, weight: .bold)
        return lbl
    }()

    private lazy var firstTextDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_text")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var secondTextDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_text2")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var thirdTextDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_text3")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var consentText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "terms_consent")
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()

    private lazy var consentTextDescirption: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_consent_details")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var informationCollectText: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = .localizedString(key: "terms_info")
        lbl.textColor = .coreBlue
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        return lbl
    }()

    private lazy var firstInfoDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_info_details")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var secondInfoDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_info_details2")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var thirdInfoDesc: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.attributedText = NSMutableAttributedString.subtitleString(key: "terms_info_details3")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()

    private lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .coreBlue
        button.setTitle(titleKey: "terms_btn")
        button.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.ButtonCornerRadius
        return button
    }()

    let scrollView = UIScrollView()
    let contentView = UIStackView()

    // MARK: - Initialization

    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(leftTopLine)
        view.addSubview(rightTopLine)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupConstraints()
        setupScrollView()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = .localizedString(key: "welcome_page_title")
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .regular),
            .foregroundColor: UIColor.gray06Dark
        ]

        setupRightNavigationBarButton()
        setupLeftNavigationBarButton()
    }

    // MARK: - UI

    private func setupConstraints() {
        leftTopLine.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.VerticalContentInset)
            make.width.equalTo(rightTopLine)
        }

        rightTopLine.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Constants.VerticalContentInset)
            make.width.equalTo(leftTopLine)
        }
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(leftTopLine).inset(Constants.ScrollViewTopInset)
            make.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView).inset(Constants.ContentViewBottomInset)
        }

        contentView.addSubview(termsText)
        contentView.addSubview(firstTextDesc)
        contentView.addSubview(secondTextDesc)
        contentView.addSubview(thirdTextDesc)
        contentView.addSubview(consentText)
        contentView.addSubview(consentTextDescirption)
        contentView.addSubview(informationCollectText)
        contentView.addSubview(firstInfoDesc)
        contentView.addSubview(secondInfoDesc)
        contentView.addSubview(thirdInfoDesc)
        contentView.addSubview(acceptButton)

    }

    func setupViews() {
        termsText.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
        }

        firstTextDesc.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(termsText.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        secondTextDesc.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(firstTextDesc.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        thirdTextDesc.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(secondTextDesc.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        consentText.snp.makeConstraints { make in
            make.top.equalTo(thirdTextDesc.snp.bottom).offset(Constants.SubtitleOffest)
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
        }

        consentTextDescirption.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.HorizontalContentInset)
            make.top.equalTo(consentText.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        informationCollectText.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.HorizontalContentInset)
            make.top.equalTo(consentTextDescirption.snp.bottom).offset(Constants.SubtitleOffest)
        }

        firstInfoDesc.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.HorizontalContentInset)
            make.top.equalTo(informationCollectText.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        secondInfoDesc.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.HorizontalContentInset)
            make.top.equalTo(firstInfoDesc.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        thirdInfoDesc.snp.makeConstraints { make in
            make.right.left.equalTo(contentView).inset(Constants.HorizontalContentInset)
            make.top.equalTo(secondInfoDesc.snp.bottom).offset(Constants.SubtitleTextOffest)
        }

        acceptButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(Constants.HorizontalContentInset)
            make.top.equalTo(thirdInfoDesc.snp.bottom).offset(Constants.ButtonTopOffest)
            make.height.equalTo(Constants.ButtonHeight)
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Navigation

    @objc func didTapAccept() {
        viewModel.goToEligibilityCheck()
    }
}

// MARK: Constants

extension TermsViewController {
    private struct Constants {
        static let HorizontalContentInset: CGFloat = 35
        static let VerticalContentInset: CGFloat = 25

        static let ContentViewBottomView: CGFloat = 75

        static let SubtitleOffest: CGFloat = 20
        static let SubtitleTextOffest: CGFloat = 10

        static let ButtonTopOffest: CGFloat = 50
        static let ButtonCornerRadius: CGFloat = 10
        static let ButtonHeight: CGFloat = 46

        static let ContentViewBottomInset: CGFloat = 50
        static let ScrollViewTopInset: CGFloat = 30
    }
}
