import Foundation
import UIKit

class PlaceImageView: UIView {
    // Components
    let coverImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = Colors.gray100
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backgroundImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.greenBase
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let arrowImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow-left"))
        view.tintColor = Colors.gray100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(target: Any, selector: Selector) {
        super.init(frame: .zero)
        backButton.addTarget(target, action: selector, for: .touchUpInside)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(coverImageView)
        addSubview(backButton)
        backButton.addSubview(arrowImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            
            arrowImageView.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
