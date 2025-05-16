import Foundation
import MapKit
import UIKit

class HomeView: UIView {
    private var bodyTopConstraint: NSLayoutConstraint!

    // Components
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .hybrid
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let bodyView: HomeBodyView = {
        let view = HomeBodyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(mapView)
        addSubview(headerView)
        addSubview(bodyView)
        bodyView.setupPanGesture(
            target: self,
            action: #selector(handlePanGesture(_:))
        )
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(
                equalTo: heightAnchor,
                multiplier: 0.65
            ),
        ])
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        setupBodyTopConstraint()
        NSLayoutConstraint.activate([
            bodyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupBodyTopConstraint() {
        bodyTopConstraint = bodyView.topAnchor.constraint(
            equalTo: mapView.bottomAnchor,
            constant: -24
        )
        bodyTopConstraint.isActive = true
    }

    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)

        switch gesture.state {
        case .changed:
            let newConstant = bodyTopConstraint.constant + translation.y
            if newConstant <= 0 && newConstant >= frame.height * 0.5 {
                bodyTopConstraint.constant = newConstant
                gesture.setTranslation(.zero, in: self)
            }
        case .ended:
            let halfScreenHeight = -frame.height * 0.5
            let finalPosition: CGFloat

            if velocity.y > 0 {
                finalPosition = -24
            } else {
                finalPosition = halfScreenHeight
            }

            UIView.animate(
                withDuration: 0.3,
                animations: {
                    self.bodyTopConstraint.constant = finalPosition
                    self.layoutIfNeeded()
                }
            )
        default:
            break
        }
    }
}
