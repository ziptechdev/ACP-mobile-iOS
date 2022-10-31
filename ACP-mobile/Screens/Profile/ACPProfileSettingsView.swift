//
//  ACPProfileSettingsView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit
import SnapKit

class ACPProfileSettingsView: UIView {

    // MARK: - Views

    private let containerView = UIView()

    private let languageGlobeImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let selectLanguage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .gray06Dark
        return label
    }()

    private let selectedLangauge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .gray01Light
        return label
    }()

    private let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFit
        view.transform = view.transform.rotated(by: .pi * 1.5)
        return view
    }()
    // MARK: - Initialization

    init() {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private func setupUI() {
        backgroundColor = .clear
        containerView.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {

        containerView.addSubview(languageGlobeImageView)
        containerView.addSubview(selectLanguage)
        containerView.addSubview(selectedLangauge)
        containerView.addSubview(arrowImageView)
        addSubview(containerView)
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }

        languageGlobeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Constraints.ImageSize)
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
            make.left.equalToSuperview().offset(Constants.Constraints.ImageLeftOffset)
        }

        selectLanguage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.Constraints.ContentInsetVertical)
            make.left.equalTo(languageGlobeImageView.snp.right).offset(Constants.Constraints.SelectLanaguageLeftOffest)

        }

        selectedLangauge.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(Constants.Constraints.ContentInsetVertical)
            make.left.equalTo(selectLanguage.snp.right).offset(Constants.Constraints.SelectedLangaugeLeftOffest)
        }

        arrowImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.Constraints.ContentInsetVertical)
            make.height.equalTo(Constants.Constraints.ArrowHeight)
            make.width.equalTo(Constants.Constraints.ArrowWidth)
            make.left.equalTo(selectedLangauge.snp.right).offset(Constants.Constraints.ArrowLeftOffest)
        }

    }

    // MARK: - Presenting

    func present() {
        languageGlobeImageView.image = UIImage(named: "globeLanguage")
        arrowImageView.image = UIImage(named: "down_arrow")
        selectLanguage.text = Constants.Text.SelectLanguage
        selectedLangauge.text = Constants.Text.English
    }

    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let ContainerInsetVertical: CGFloat = 20

            static let ImageInsetTop: CGFloat = 41
            static let ImageLeftOffset: CGFloat = 35
            static let ImageSize: CGFloat = 24

            static let ContentInsetVertical: CGFloat = 30
            static let ContentInsetHorizontal: CGFloat = 35

            static let SelectLanaguageLeftOffest: CGFloat = 10

            static let SelectedLangaugeLeftOffest: CGFloat = 114
            static let ArrowLeftOffest: CGFloat = 9
            static let ArrowRightOffest: CGFloat = 55
            static let ArrowHeight: CGFloat = 6
            static let ArrowWidth: CGFloat = 12
        }

        struct Text {
            static let SelectLanguage = "Language"
            static let English = "English"
        }
    }
}
