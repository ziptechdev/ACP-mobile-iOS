//
//  KYCDocumentsViewModel.swift
//  ACP-mobile
//
//  Created by Abi  on 6. 1. 2023..
//

import Alamofire
import SwiftyJSON

class KYCDocumentsViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?
    private let service = KYCService()
    var model = KYCDocumentsModel()

    var showErrorMessage: ((String) -> Void)?
    var dismissVerifyEmail: (() -> Void)?
    var verifyEmailError: ((String) -> Void)?

    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }

    private var tabNames: [String] {
        return [
            .localizedString(key: "personal_info_page_title"),
            .localizedString(key: "identity_proof_page_title"),
            .localizedString(key: "bank_info_page_title")
        ]
    }

    // MARK: - Initialization

    init(coordinator: KYCCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Callbacks

    func numberOfTabItems() -> Int {
        return tabNames.count
    }

    func titleForTab(at index: Int) -> String {
        return tabNames[index]
    }

    // MARK: - Network
//    func sendEmailCode() {
//        let parameters: Parameters = ["email": model.email]
//
//        service.verifyEmail(parameters: parameters) { [weak self] data, error in
//            guard let self = self else { return }
//
//            guard let data = data, error == nil else {
//                self.showErrorMessage?("Something went wrong. Try again.")
//                return
//            }
//
//            guard let model = try? JSONDecoder().decode(KYCVerifyEmailResponse.self, from: data),
//                  let verificationCode = model.data?.verificationCode
//            else {
//                self.showErrorMessage?("Something went wrong. Try again.")
//                return
//            }
//            print("code \(verificationCode)")
//            self.model.verificationCode = "\(verificationCode)"
//            self.openVerifyEmail()
//        }
//    }
//
//    func resendEmailCode() {
//        sendEmailCode()
//    }
//
//    func confirmCode(_ code: String) {
//        if code == model.verificationCode {
//            dismissVerifyEmail?()
//        } else {
//            verifyEmailError?("Verification code is incorrect.")
//        }
//    }
//
//    func register() {
//        let parameters: Parameters = [
//            "firstName": model.firstName,
//            "lastName": model.lastName,
//            "username": model.email,
//            "password": model.password,
//            "phoneNumber": model.phoneNumber,
//            "socialSecurityNumber": model.ssn,
//            "bankName": model.bankName,
//            "bankNumber": model.bankNumber,
//            "accountHolderName": model.accountHolderName,
//            "accountNumber": model.accountNumber,
//            "expirationDate": model.expirationDate
//        ]
//
//        service.kycRegister(parameters: parameters) { [weak self] data, error in
//            guard let self = self else { return }
//
//            guard let data = data, error == nil else {
//                self.showErrorMessage?("Something went wrong. Try again.")
//                return
//            }
//
//            guard let model = try? JSONDecoder().decode(KYCRegisterResponse.self, from: data),
//                  let _ = model.data
//            else {
//                self.showErrorMessage?("Something went wrong. Try again.")
//                return
//            }
//
//            self.coordinator?.goToRegistrationComplete()
//        }
//    }

    func kycVerifyUploadTEST() {
        var scanFront = model.documentIdFront
        var  scanBack = model.documentIdBack
        var selfie = model.selfie
        var userIP = model.userIp
//        var userState
        
        var username = model.username
        var userState = model.userState
        var dateAt = model.consentOptainedAt
        
        var idAccount: String?
      //  print("dataet \(dateAt)")
        username = "ab23@gmail.com"
        userState = "IL"
        userIP = "192.168.0.1"
     //   dateAt = "2023-01-04T17:20:35.000Z"
        dateAt = "2023-01-04 17:20:35"
//        dateAt = "2018-09-12T14:11:54.348Z"
//        let today = Date()
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .short
//        var strDate = formatter1.string(from: today)
//        print("date \(strDate)")
       // print(formatter1.string(from: today))
        
        
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

         print("tu smo krenuli")
           let headers: HTTPHeaders = [
               "Content-type": "multipart/form-data"
           ]
        print("username \(username) + \(userIP) +== \(userState) +== \(dateAt) === \(scanBack) === \(scanFront) == \(selfie)")
        AF.upload(

                           multipartFormData: { multipartFormData in
                               multipartFormData.append(scanFront ?? Data(), withName: "documentIdFront" , fileName: "image.jpeg", mimeType: "image/jpeg")
                               multipartFormData.append(scanBack ?? Data(), withName: "documentIdBack" , fileName: "image2.jpeg", mimeType: "image/jpeg")
                               multipartFormData.append(selfie ?? Data(), withName: "selfie" , fileName: "image3.jpeg", mimeType: "image/jpeg")
                               multipartFormData.append(username.data(using: .utf8)!, withName: "username")
                               multipartFormData.append(userIP.data(using: .utf8)!, withName: "userIp")
                               multipartFormData.append(userState.data(using: .utf8)!, withName: "userState")
                               multipartFormData.append("yes".data(using: .utf8)!, withName: "consentOptained")
                               multipartFormData.append(dateAt.data(using: .utf8)!, withName: "consentOptainedAt")
                               
                               //                   for (key, value) in parameters
                               //                             {
                               //                                 multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                               //                             }
   
           },
               to: "https://acp-mobile-backend.herokuapp.com/api/v1/jumio/resident-identity-verification",
               method: .post ,
               headers: headers)
               .response { response in
                   if let data = response.data, let s = String(data: data, encoding: .utf8) {
                                        print("tu smo \(data)")
                                        let arr = JSON(data)
                                        print("arr \(arr.count)")
                                        print("arrsss \(s)")
                 
                                    }
               }
                                    
//                   [weak self] data in
//                       guard let self = self else { return }
//
//                   guard let data = data.data else {
//                           self.showErrorMessage?("Something went wrong. Try again.")
//                           return
//                       }
//
//                   guard let model = try? JSONDecoder().decode(KYCScanDocumentResponse.self, from: data),
//                         let mod = model.data
//                      else {
//
//                           self.showErrorMessage?("Something went wrong. Try again.")
//                           return
//                       }
//                   let idAccount = model.data?.account.id
//                   let workflowId = model.data?.workflowExecution.id
//                   print("helou \(idAccount) ++ \(workflowId)")
//                      // self.coordinator?.goToRegistrationComplete()
//                   }
  
       }
    
    // MARK: - Coordination

//    private func openVerifyEmail() {
//        coordinator?.openVerifyEmail(viewModel: self)
//    }

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }
}
