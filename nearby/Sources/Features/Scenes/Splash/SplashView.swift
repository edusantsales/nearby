//
//  SplashView.swift
//  Nearby
//
//  Created by Eduardo Sant Ana Sales on 25/02/25.
//

import Foundation
import UIKit

class SplashView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(backgroundImageView)
        setupConstraints()
    }

    private func setupConstraints() {
        setupLogoImageView()
        setupBackgroundImageView()
    }

    private func setupLogoImageView() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

    private func setupBackgroundImageView() {
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            )
        ])
    }
}
