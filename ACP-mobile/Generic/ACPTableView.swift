//
//  ACPTableView.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit

class ACPTableView: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0.0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
