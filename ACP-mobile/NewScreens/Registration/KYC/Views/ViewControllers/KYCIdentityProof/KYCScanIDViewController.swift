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

    weak var delegate: TabMenuDelegate?
    
    var imageTaken = 0
    // MARK: - Views

    private let cardView = BorderedView(imageName: "scan_id")

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

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        subtitleLabel.isHidden = true
        titleLabel.isHidden = true
        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(cardView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(scanFrontButton)
        view.addSubview(scanBackButton)
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
//
        scanFrontButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.ButtonOffsetVertical)
        }

        scanBackButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constants.Constraints.ContentInset)
            make.height.equalTo(Constants.Constraints.ButtonHeight)
            make.top.equalTo(scanFrontButton.snp.bottom).offset(Constants.Constraints.ButtonSpacingVertical)
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

    @objc func didTapScanFrontButton() {
        print("helooo")
        imageTaken = 1
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self
        imgPicker.sourceType = .camera
        imgPicker.allowsEditing = false
        imgPicker.showsCameraControls = true
        self.present(imgPicker, animated: true, completion: nil)
        kycVerifyUploadTEST()
//        delegate?.didTapNextButton()
    }

    @objc func didTapScanBackButton() {
        imageTaken = 2
//        let imgPicker = UIImagePickerController()
//        imgPicker.delegate = self
//        imgPicker.sourceType = .camera
//        imgPicker.allowsEditing = false
//        imgPicker.showsCameraControls = true
//        self.present(imgPicker, animated: true, completion: nil)
        //delegate?.didTapNextButton()
    }
    func kycVerifyUploadTEST() {
        var scanFront: Data
        var  scanBack: Data
        var selfie: Data
        var username : String?
        var userState : String?
        

        username = "ab@gmail.com"
        userState = "IL"
        
        let parameters = [
              "documentIdFront": "",
              "documentIdBack" : "",
              "selfie": "",
              "username" : "",
              "userIp": "",
              "userState" : "",
              "consentOptained": "",
              "consentOptainedAt" : "",
              
          ]
        
//        let image = UIImage.init(named: "welcome")
//        let imgData = image!.jpegData(compressionQuality: 0.7)!
//
         print("tu smo krenuli")
        
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data"
           ]
        
        let image = UIImage.init(named: "welcome")
        let imgData = image!.jpegData(compressionQuality: 0.2)!
        AF.upload(

                           multipartFormData: { multipartFormData in
                               multipartFormData.append(imgData, withName: "documentIdFront" , fileName: "image.jpeg", mimeType: "image/jpeg")
                               multipartFormData.append(imgData, withName: "documentIdBack" , fileName: "image2.jpeg", mimeType: "image/jpeg")
                               multipartFormData.append(imgData, withName: "selfie" , fileName: "image3.jpeg", mimeType: "image/jpeg")
                               multipartFormData.append(username!.data(using: .utf8)!, withName: "username")
                               multipartFormData.append(username!.data(using: .utf8)!, withName: "userIp")
                               multipartFormData.append(userState!.data(using: .utf8)!, withName: "userState")
                               multipartFormData.append("yes".data(using: .utf8)!, withName: "consentOptained")
                               multipartFormData.append(username!.data(using: .utf8)!, withName: "consentOptainedAt")
   
          //  imgData,
//                           },
//            to: "https://acp-mobile-backend.herokuapp.com/api/v1/jumio/resident-identity-verification").response { response in
//           print("helou tuu \(response)")
//       }
//
//           AF.upload(
//               multipartFormData: { multipartFormData in
//                   multipartFormData.append(imgData, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
//                   multipartFormData.append(imgData, withName: "image2" , fileName: "image2.jpeg", mimeType: "image/jpeg")
//                   multipartFormData.append(imgData, withName: "image3" , fileName: "image3.jpeg", mimeType: "image/jpeg")
//
////
////                   for (key, value) in parameters
////                             {
////                                 multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
////                             }
//
           },
               to: "https://acp-mobile-backend.herokuapp.com/api/v1/jumio/resident-identity-verification",
               method: .post ,
               headers: headers)
               .response { response in
                   if let data = response.data, let s = String(data: data, encoding: .utf8) {
                       print("tu smo \(data)")
                       let arr = JSON(data)
                       print(arr)
                       print(arr[0][0])
                       print(s)
                   }
                   
//                   if let data = response.data{
//                       print("tu smo \(data)")
                       
                       
//                       let s = String(data: data, encoding: .utf8) {
//                               let arr = JSON(data)
//                           print(arr)
//                           print(arr[0][0])
//                           print(s)
//                           }
                       
//                       guard let model = try? JSONDecoder().decode(Welcome.self, from: data)
//                           //  let ad = model.data.account.id
//
//                       else {
//                           print("error 3")
//                          // self.showErrorMessage?("Something went wrong. Try again.")
//                           return
//                       }
//                       print("noooo ")
//                       print(model.self)
                       //handle the response however you like
//                   } else {
//                       print("error ")
//                   }

           }
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
           cardView.imageView.image = img
            if(imageTaken == 1){
                cardView.isHidden = true;
            }
           var jpegImg = img.jpegData(compressionQuality: 0.7)
           // var str = Data(jpegImg?.description.utf8 ?? "")
      
            print("jpeg \(jpegImg)")
//            cardView.imageView.image. = 200.0
           //cardView.imageView.contentMode = .scaleToFill
         //  test.imageView.image = img
          
           print("test \(img)")
             self.dismiss(animated: true, completion: nil)
          }
          else {
           //   let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            //  imagePicked.image = image
          //    dismiss(animated:true, completion: nil)
             print("error ")
          }
       }
}
