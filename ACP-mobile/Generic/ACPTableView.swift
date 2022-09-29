//
//  ACPTableView.swift
//  ACP-mobile
//
//  Created by Adi on 28/09/2022.
//

import UIKit

class ACPTableView: UITableView {

    override init(frame: CGRect = .zero, style: UITableView.Style = .plain) {
        super.init(frame: frame, style: style)

        translatesAutoresizingMaskIntoConstraints = false
        separatorColor = .clear
        allowsSelection = false
        rowHeight = UITableView.automaticDimension

        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0.0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
