import Foundation
import UIKit

class PlaceDetailView: UIView {
    var goBackToHome: (() -> Void?)?
    
    @objc
    private func didTapBackButton() { goBackToHome?() }
    
    // Components
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
        view.contentInsetAdjustmentBehavior = .never
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let placeImageView: PlaceImageView = {
        let view = PlaceImageView(target: self, selector: #selector(didTapBackButton))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func createPlaceContentView(place: Place, category: Category) -> PlaceContentView {
        // Components
        let view = PlaceContentView()
        view.setupComponent(place: place, category: category)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup UI
        bodyView.addSubview(view)
        
        // Constraints
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: placeImageView.bottomAnchor, constant: -20),
            view.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor),
        ])
        
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(bodyView)
        bodyView.addSubview(placeImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            bodyView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            bodyView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bodyView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bodyView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.25),
            bodyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            placeImageView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            placeImageView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            placeImageView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            placeImageView.heightAnchor.constraint(equalTo: bodyView.heightAnchor, multiplier: 0.25),
        ])
    }
}
