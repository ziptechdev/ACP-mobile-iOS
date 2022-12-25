//
//  KYCViewModel.swift
//  ACP-mobile
//
//  Created by Adi on 19/12/2022.
//

class KYCViewModel {

    // MARK: - Properties

    private weak var coordinator: KYCCoordinatorProtocol?
    private let service = KYCService()

    // MARK: - Initialization

    init(coordinator: KYCCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Callbacks
    
}
