//
//  ACPProfileInfoViewController.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 13. 10. 2022..
//

import UIKit

class ACPProfileInfoViewController: UIViewController {

    // MARK: - Properties
    var viewModel: EligibilityDetailsViewModel?

    // MARK: - Views

    let nameView = ACPProfileNameView()
    let dobView = ACPProfileDOBView()
    let addressView = ACPProfileAddressView()
    let ssnView = ACPProfileSSNView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "profile_personal_info")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var scrolLView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        sv.isPagingEnabled = true
        sv.bounces = true
        sv.contentSize = self.view.frame.size
        return sv
    }()

    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(.localizedString(key: "profile_personal_btn_save"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = .localizedString(key: "profile_page_title")
        navigationController?.navigationBar.isHidden = false
      //  addKeyboardObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     //   removeKeyboardObserver()
    }

    // MARK: - UI

    func setupUI() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        view.addSubview(scrolLView)
        scrolLView.addSubview(titleLabel)
        scrolLView.addSubview(nameView)
        scrolLView.addSubview(dobView)
        scrolLView.addSubview(addressView)
        scrolLView.addSubview(ssnView)

        scrolLView.addSubview(saveButton)
    }

    func setupConstraints() {
        scrolLView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(scrolLView).inset(Constants.Constraints.TitleTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        nameView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.NameSectionTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        dobView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.DOBSectionTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        addressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.AddressSectionTopOffset)
            make.left.equalTo(scrolLView).offset(Constants.Constraints.LROffset)
          }

        ssnView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SSNSectionTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.ButtonTopOffset)
            make.left.equalTo(scrolLView).inset(Constants.Constraints.LROffset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.width.equalTo(Constants.Constraints.mainWidth)
            make.bottom.equalToSuperview()
        }

    }

    // MARK: - Callback

    @objc func didTapButton() {
        print("save")
    }

    // MARK: - Constants

    struct Constants {
        struct Constraints {

            static let LROffset = 35
            static let mainWidth = 320
            static let TextFieldSpacing = 20

            static let TitleTopOffset = 60
            static let NameSectionTopOffset = 26
            static let DOBSectionTopOffset = 309
            static let AddressSectionTopOffset = 514
            static let SSNSectionTopOffset = 797

            static let ButtonTopOffset = 924
            static let ButtonHeight: CGFloat = 46
            static let ButtonCornerRadius: CGFloat = 10

            static let LRFieldWidth: CGFloat = 150
        }
    }
}
