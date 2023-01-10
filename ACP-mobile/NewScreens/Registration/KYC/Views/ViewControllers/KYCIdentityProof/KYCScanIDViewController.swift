//
//  KYCScanIDViewController.swift
//  ACP-mobile
//
//  Created by Adi on 18/10/2022.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class KYCScanIDViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: KYCDocumentsViewModel
    private let viewModelInfo: KYCRegistrationViewModel

    weak var delegate: TabMenuDelegate?
    
    var imageTaken = 0
    var frontImage: Data? = nil
    var backImage: Data? = nil

//    var image
    // MARK: - Views

    private let cardView = BorderedView(imageName: "scan_id")
    
    let imageViewFront: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
       view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "secondImage")
       view.isHidden = false
       return view
   }()
    
    let imageViewBack: UIImageView = {
       let view = UIImageView()
       view.contentMode = .scaleAspectFit
       view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "firstImage")
        view.isHidden = false
       return view
   }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "kyc_scan_id_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributedSubitleText()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var scanFrontButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "kyc_scan_id_btn")
        button.addTarget(self, action: #selector(didTapScanFrontButton), for: .touchUpInside)
        return button
    }()

    private lazy var scanBackButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "kyc_scan_id_btn_2")
        button.addTarget(self, action: #selector(didTapScanBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "personal_info_btn")
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.isHidden = false
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        cardView.isHidden = true
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    init(viewModel: KYCDocumentsViewModel, viewModelInfo: KYCRegistrationViewModel) {
        self.viewModel = viewModel
        self.viewModelInfo = viewModelInfo

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(cardView)
        view.addSubview(imageViewBack)
        view.addSubview(imageViewFront)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(scanFrontButton)
        view.addSubview(scanBackButton)
        view.addSubview(nextButton)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
        }
        imageViewFront.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.right.equalTo(imageViewBack.snp.left).offset(Constants.Constraints.ContentInset)

            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
            make.width.equalTo(150)

        }
        imageViewBack.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.left.equalTo(imageViewFront.snp.right).offset(Constants.Constraints.ContentInset)

            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
            make.width.equalTo(150)

        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(cardView.snp.bottom).offset(Constants.Constraints.TitleInsetY)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffset)
        }

        scanFrontButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(nextButton.snp.bottom).offset(Constants.Constraints.ButtonCornerRadius)
        }

        scanBackButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(scanFrontButton.snp.bottom).offset(Constants.Constraints.ButtonSpacingVertical)
        }
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.ButtonCornerRadius)
            make.height.equalTo(Constants.Constraints.ButtonHeight)

        }
    }

    private func attributedSubitleText() -> NSMutableAttributedString {
        let string: NSMutableAttributedString = .subtitleString(
            key: "kyc_scan_id_subtitle",
            isCenter: true
        )
        let highlightRange = string.range(of: .localizedString(key: "kyc_scan_id_highlight"))

        string.addAttribute(.font, value: UIFont.systemFont(ofSize: 13, weight: .semibold), range: highlightRange)

        return string
    }

    // MARK: - Callbacks
    @objc func didTapNextButton() {
        viewModel.model.documentIdFront = frontImage
        viewModel.model.documentIdBack = backImage
        viewModel.model.username = viewModelInfo.model.email
        delegate?.didTapNextButton()
    }
    
    @objc func didTapScanFrontButton() {
        print("helooo")
        imageTaken = 1
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = false
        imgPicker.showsCameraControls = true
        self.present(imgPicker, animated: true, completion: nil)
//        delegate?.didTapNextButton()
    }

    @objc func didTapScanBackButton() {
        imageTaken = 2
        imageViewBack.isHidden = false
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = false
        imgPicker.showsCameraControls = true
        self.present(imgPicker, animated: true, completion: nil)
        //delegate?.didTapNextButton()
    }
    
    // MARK: - Constants

    private struct Constants {
        struct Constraints {
            static let CardInsetY: CGFloat = 30
            static let CardHeight: CGFloat = 180

            static let TitleInsetY: CGFloat = 30
            static let ContentInset: CGFloat = 35

            static let SubtitleOffset: CGFloat = 20

            static let ButtonHeight: CGFloat = 46
            static let ButtonOffsetVertical: CGFloat = 30
            static let ButtonSpacingVertical: CGFloat = 20
            static let ButtonCornerRadius: CGFloat = 10
        }
    }
}

extension KYCScanIDViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :
    Any]) {

        if let img = info[UIImagePickerController.InfoKey.originalImage] as?
       UIImage {
           //  self.imgV.image = img
          //  img.width = 300.0
         //  cardView.imageView.image = img
            if (imageTaken == 1) {
                cardView.isHidden = true
                imageViewFront.isHidden = false
                imageViewFront.image = img
                let jpegImg = img.jpegData(compressionQuality: 0.7)
                frontImage = jpegImg
             
            } else if (imageTaken == 2) {
                cardView.isHidden = true
                imageViewBack.isHidden = false
                imageViewBack.image = img
                let jpegImg = img.jpegData(compressionQuality: 0.7)
                backImage = jpegImg
            } else {
                cardView.isHidden = false
            }
            if (!imageViewBack.isHidden && !imageViewFront.isHidden) {
                subtitleLabel.isHidden = true
                nextButton.isHidden = false
            }
          
             self.dismiss(animated: true, completion: nil)
          }
          else {
             print("error ")
          }
       }
}
