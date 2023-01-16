//
//  KYCSelfieViewController.swift
//  ACP-mobile
//
//  Created by Adi on 18/10/2022.
//

import UIKit
import SnapKit
import CoreLocation


class KYCSelfieViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: KYCDocumentsViewModel

    weak var delegate: TabMenuDelegate?

    // MARK: - Views
    var selfie: Data? = nil
    var userState = ""
    
     let cardView = BorderedView(imageName: "selfie")
    
    var locationManager = CLLocationManager()

    let imageViewSelfie: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
       view.translatesAutoresizingMaskIntoConstraints = false
       view.isHidden = true
       return view
   }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = .localizedString(key: "kyc_selfie_title")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .coreBlue
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString.subtitleString(key: "kyc_selfie_subtitle")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var openCameraButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .coreBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "kyc_selfie_btn")
        button.addTarget(self, action: #selector(didTapOpenCameraButton), for: .touchUpInside)
        return button
    }()

    private lazy var uploadPhotoButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.Constraints.ButtonCornerRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.coreBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(titleKey: "personal_info_btn", textColor: .coreBlue)
        button.addTarget(self, action: #selector(didTapUploadPhotoButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestAlwaysAuthorization()

           if CLLocationManager.locationServicesEnabled(){
               locationManager.startUpdatingLocation()
           }
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }
    
    init(viewModel: KYCDocumentsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(cardView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(openCameraButton)
        view.addSubview(uploadPhotoButton)
        view.addSubview(imageViewSelfie)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
        }
        imageViewSelfie.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(cardView.snp.bottom).offset(Constants.Constraints.TitleInsetY)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffset)
        }

        openCameraButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        uploadPhotoButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(openCameraButton.snp.bottom).offset(Constants.Constraints.ButtonSpacingVertical)
        }
    }

    // MARK: - Callbacks

    @objc func didTapOpenCameraButton() {
        
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = false
        imgPicker.showsCameraControls = true
        self.present(imgPicker, animated: true, completion: nil)
     //   delegate?.didTapNextButton()
    }

    @objc func didTapUploadPhotoButton() {
        let date = Date()
        let format = date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
        let address = try? String(contentsOf: URL(string: "https://api.ipify.org")!, encoding: .utf8)

        viewModel.model.consentOptainedAt = format
        viewModel.model.selfie = selfie
        viewModel.model.userState = userState
        viewModel.model.userIp = address ?? ""
        viewModel.kycVerifyUpload()
        delegate?.didTapNextButton()
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
            static let ButtonOffsetVertical: CGFloat = 50
            static let ButtonSpacingVertical: CGFloat = 20
            static let ButtonCornerRadius: CGFloat = 10
        }
    }
}
extension KYCSelfieViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey :
    Any]) {

        if let img = info[UIImagePickerController.InfoKey.originalImage] as?
       UIImage {
            
            cardView.isHidden = true
            imageViewSelfie.isHidden = false
            imageViewSelfie.image = img
            let jpegImg = img.jpegData(compressionQuality: 0.7)
            selfie = jpegImg
            if (!imageViewSelfie.isHidden) {
                uploadPhotoButton.isHidden = false
            }
          
             self.dismiss(animated: true, completion: nil)
          }
          else {
             print("error ")
          }
       }
}
extension KYCSelfieViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
            
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks   //! as [CLPlacemark]
            if (placemark?.count ?? 0) > 0 {
                let placemark = placemarks![0]
                self.userState = placemark.administrativeArea!
            }
        }

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}


extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
