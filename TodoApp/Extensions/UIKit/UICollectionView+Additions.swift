//
//  UICollectionView+Additions.swift
//  TodoApp
//
//  Created by Ugur Kilic on 5/09/2019.
//  Copyright © 2019 urklc. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func uk_registerCell<T: UICollectionViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    func uk_dequeueReusableCell<T: Reusable>(forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as! T
    }
}
