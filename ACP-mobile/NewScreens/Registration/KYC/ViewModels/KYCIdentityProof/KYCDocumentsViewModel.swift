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

    var jumioURL = "https://acp-mobile-backend.herokuapp.com/api/v1/jumio/resident-identity-verification"
    var idAccount: String?
    var workflowId: String?
    
    var showErrorMessage: ((String) -> Void)?
    
    private var termsUrl: String { "terms" }
    private var privacyPolicyUrl: String { "privacy" }

    // MARK: - Initialization

    init(coordinator: KYCCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Callbacks

    func kycVerifyUpload() {
        let scanFront = model.documentIdFront
        let scanBack = model.documentIdBack
        let selfie = model.selfie
        let userIP = model.userIp
        let username = model.username
        let userState = model.userState
        let dateAt = model.consentOptainedAt

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
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
                
            },
            to: jumioURL,
            method: .post ,
            headers: headers)
        .response {  [weak self] response in

            guard let self = self else { return }
            guard let data = response.data else {
                self.showErrorMessage?("Something went wrong. Try again.")
                return
            }
            
            guard let model = try? JSONDecoder().decode(KYCScanDocumentResponse.self, from: data)
                  
            else {
                self.showErrorMessage?("Something went wrong. Try again.")
                return
            }
            self.idAccount = model.data?.account.id
            self.workflowId = model.data?.workflowExecution.id
            // self.coordinator?.goToRegistrationComplete()
        }
                                    
       }
    
    // MARK: - Coordination

    func openTerms() {
        coordinator?.openLink(url: termsUrl)
    }

    func openPrivacyPolicy() {
        coordinator?.openLink(url: privacyPolicyUrl)
    }
}
