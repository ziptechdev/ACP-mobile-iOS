//
//  UICollectionView+ACP.swift
//  ACP-mobile
//
//  Created by Adi on 06/10/2022.
//

import UIKit

extension UICollectionView {

    // MARK: - UICollectionViewCell

    func register<T>(_: T.Type) where T: UICollectionViewCell {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }

    func dequeue<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? T else {
            return T()
        }
        return cell
    }
}
