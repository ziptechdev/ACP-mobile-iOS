//
//  UITableView+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 29/09/2022.
//

import UIKit

extension UITableView {

    // MARK: - UITableViewCell

    func register<T>(_: T.Type) where T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }

    func dequeue<T: UITableViewCell>(at indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return T()
        }
        return cell
    }

    // MARK: - UITableViewHeaderFooterView

    func registerHeaderFooter<T>(_: T.Type) where T: UITableViewHeaderFooterView {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }

    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        let identifier = String(describing: T.self)
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            return T()
        }
        return headerFooter
    }
}
