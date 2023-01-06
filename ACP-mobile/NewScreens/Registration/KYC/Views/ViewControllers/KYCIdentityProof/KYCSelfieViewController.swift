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
    //locationManager.delegate = self

    // Request a user’s location once
  //  locationManager.requestLocation()

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
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        isAuthorizedtoGetUserLocation()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        }
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
    //    view.addSubview(subtitleLabel)
        view.addSubview(openCameraButton)
        view.addSubview(uploadPhotoButton)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalToSuperview().inset(Constants.Constraints.CardInsetY)
            make.height.equalTo(Constants.Constraints.CardHeight)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.top.equalTo(cardView.snp.bottom).offset(Constants.Constraints.TitleInsetY)
        }

//        subtitleLabel.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
//            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.SubtitleOffset)
//        }

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
        let format = date.getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSS") // Set output format
        let finalFormat = format + "Z"
        let format2 = date.getFormattedDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        print("test next [resss \(format2) + \(finalFormat)")
        let address = try? String(contentsOf: URL(string: "https://api.ipify.org")!, encoding: .utf8)
        print("ipadress: \(address) ++ \(userState)")
        
        viewModel.model.consentOptainedAt = finalFormat
        viewModel.model.selfie = selfie
        viewModel.model.userState = userState
        viewModel.model.userIp = address ?? ""
        viewModel.kycVerifyUploadTEST()
        delegate?.didTapNextButton()
    }
//    func printAddresses() {
//        var addrList : UnsafeMutablePointer<ifaddrs>?
//        guard
//            getifaddrs(&addrList) == 0,
//            let firstAddr = addrList
//        else { return }
//        defer { freeifaddrs(addrList) }
//        for cursor in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
//            let interfaceName = String(cString: cursor.pointee.ifa_name)
//            let addrStr: String
//            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//            if
//                let addr = cursor.pointee.ifa_addr,
//                getnameinfo(addr, socklen_t(addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST) == 0,
//                hostname[0] != 0
//            {
//                addrStr = String(cString: hostname)
//            } else {
//                addrStr = "?"
//            }
//            print(interfaceName, addrStr)
//        }
//        return
//    }
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
           //  self.imgV.image = img
          //  img.width = 300.0
           cardView.imageView.image = img
//            if (imageTaken == 1) {
               // cardView.isHidden = true
//                imageViewFront.isHidden = false
//                imageViewFront.image = img
                let jpegImg = img.jpegData(compressionQuality: 0.7)
                selfie = jpegImg
//                frontImage = jpegImg
//
//            } else if (imageTaken == 2) {
//                cardView.isHidden = true
//                imageViewBack.isHidden = false
//                imageViewBack.image = img
//                let jpegImg = img.jpegData(compressionQuality: 0.7)
//                backImage = jpegImg
//            } else {
//                cardView.isHidden = false
//            }
//            if (!imageViewBack.isHidden && !imageViewFront.isHidden) {
//                subtitleLabel.isHidden = true
//                nextButton.isHidden = false
//            }
          
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

//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")

//        self.labelLat.text = "\(userLocation.coordinate.latitude)"
//        self.labelLongi.text = "\(userLocation.coordinate.longitude)"
            
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
//                print(placemark.locality!)
//                print(placemark.administrativeArea!)
//                print(placemark.country!)
//
//                print("user clocation = \(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!) \(placemark.isoCountryCode)")
                self.userState = placemark.administrativeArea!
               // self.labelAdd.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
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
