//
//  KYCDocumentsViewModel.swift
//  ACP-mobile
//
//  Created by Abi  on 6. 1. 2023..
//

import Alamofire
import SwiftyJSON
import UIKit

class KYCDocumentsViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?
    private let service = KYCService()
    var model = KYCDocumentsModel()

    
    var idAccount: String?
    var workflowId: String?
    
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
    func kycVerifyUploadTEST() {
        let scanFront = model.documentIdFront
        let scanBack = model.documentIdBack
        let selfie = model.selfie
        let userIP = model.userIp
        var username = model.username
        var userState = model.userState
        var dateAt = model.consentOptainedAt
        
        //  print("dataet \(dateAt)")
        // these are hardcoded values that we can use to get successfull response
//        username = "ab2320@gmail.com"
        userState = "IL"
        dateAt = "2023-01-04 23:38:13"
        
        
        //        let parameters = [
        //              "documentIdFront": "",
        //              "documentIdBack" : "",
        //              "selfie": "",
        //              "username" : "",
        //              "userIp": "",
        //              "userState" : "",
        //              "consentOptained": "",
        //              "consentOptainedAt" : "",
        //          ]
        
        print("tu smo krenuli")
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        let image = UIImage.init(named: "welcome")
        let imageData = image?.jpegData(compressionQuality: 0.9)
        // print("username \(username) + \(userIP) +== \(userState) +== \(dateAt) === \(scanBack) === \(scanFront) == \(selfie)")
        AF.upload(
            
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData ?? Data(), withName: "documentIdFront" , fileName: "image.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(imageData ?? Data(), withName: "documentIdBack" , fileName: "image2.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(imageData ?? Data(), withName: "selfie" , fileName: "image3.jpeg", mimeType: "image/jpeg")
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
        .response {  [weak self] response in
            if let data = response.data, let s = String(data: data, encoding: .utf8) {
                //   print("tu smo \(data)")
                let arr = JSON(data)
                //    print("arr \(arr.count)")
                print("arrsss \(s)")
                
            }
            
            guard let self = self else { return }
            
            guard let data = response.data else {
                self.showErrorMessage?("Something went wrong. Try again.")
                return
            }
            
            guard let model = try? JSONDecoder().decode(KYCScanDocumentResponse.self, from: data),
                  let mod = model.data
            else {
                
                self.showErrorMessage?("Something went wrong. Try again.")
                return
            }
            self.idAccount = model.data?.account.id
            self.workflowId = model.data?.workflowExecution.id
            print("helou \(self.idAccount) ++ \(self.workflowId)")
            // self.coordinator?.goToRegistrationComplete()
        }
                                    
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
