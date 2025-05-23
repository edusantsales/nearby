//
//  UIViewController.swift
//  Nearby
//
//  Created by Eduardo Sant Ana Sales on 26/02/25.
//
//  Extension to reuse default constraints for all class of the type UIViewController
//

import Foundation
import UIKit

extension UIViewController {
    public func setupContentViewToViewController(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }
}
