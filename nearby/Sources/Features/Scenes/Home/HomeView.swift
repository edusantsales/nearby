import Foundation
import MapKit
import UIKit

class HomeView: UIView {
    private var filterButtonAction: ((Category) -> Void)?
    private var categories: [Category] = []
    private var selectedButton: UIButton?
    
    // Components
    let mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .hybrid
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryFilterScrollView: UIScrollView = {
        let view = UIScrollView()
        view.isUserInteractionEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryFilterStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.isUserInteractionEnabled = true
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray300
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.textColor = Colors.gray600
        label.text = "Explore locais perto de você"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let placesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Variables
    private var containerTopConstraint: NSLayoutConstraint!
    
    // Setup Methods
    private func setupUI() {
        addSubview(mapView)
        
        addSubview(categoryFilterScrollView)
        categoryFilterScrollView.addSubview(categoryFilterStackView)
        
        addSubview(bottomContainerView)
        bottomContainerView.addSubview(dragIndicatorView)
        bottomContainerView.addSubview(descriptionLabel)
        bottomContainerView.addSubview(placesTableView)
        
        setupPanGesture()
        setupConstraints()
    }
    
    private func setupConstraints() {
        mapViewConstraints()
        categoryFilterViewConstraints()
        bottomContainerViewConstraints()
    }
    
    private func mapViewConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
        ])
    }
    
    private func categoryFilterViewConstraints() {
        NSLayoutConstraint.activate([
            categoryFilterScrollView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            categoryFilterScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryFilterScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryFilterScrollView.heightAnchor.constraint(equalToConstant: 36),
            
            categoryFilterStackView.topAnchor.constraint(equalTo: categoryFilterScrollView.topAnchor),
            categoryFilterStackView.leadingAnchor.constraint(equalTo: categoryFilterScrollView.leadingAnchor, constant: 24),
            categoryFilterStackView.trailingAnchor.constraint(equalTo: categoryFilterScrollView.trailingAnchor, constant: -24),
            categoryFilterStackView.bottomAnchor.constraint(equalTo: categoryFilterScrollView.bottomAnchor),
            categoryFilterStackView.heightAnchor.constraint(equalTo: categoryFilterScrollView.heightAnchor),
        ])
    }
    
    private func bottomContainerViewConstraints() {
        NSLayoutConstraint.activate([
            bottomContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        containerTopConstraint = bottomContainerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -24)
        containerTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            dragIndicatorView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 12),
            dragIndicatorView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 80),
            
            descriptionLabel.topAnchor.constraint(equalTo: dragIndicatorView.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),
            
            placesTableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            placesTableView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 24),
            placesTableView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -24),
            placesTableView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor, constant: -16),
        ])
    }
    
    func configureTableViewDelegate(_ delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        placesTableView.delegate = delegate
        placesTableView.dataSource = dataSource
    }
    
    func updateFilterButtons(with categories: [Category], action: @escaping (Category) -> Void) {
        let categoryIcons: [String: String] = [
            "Alimentação": "foodIcon",
            "Cinema": "movieIcon",
            "Compras": "shoppingBagIcon",
            "Hospedagem": "bedIcon",
            "Padaria": "foodIcon",
        ]
        
        self.categories = categories
        self.filterButtonAction = action
        
        for (index, category) in categories.enumerated() {
            let iconName = categoryIcons[category.name] ?? "defaultCategoryIcon"
            
            let button = createFilterButton(title: category.name, iconName: iconName)
            button.tag = index
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            
            if (button.tag == 0) {
                updateButtonSelection(button: button)
            }
            
            categoryFilterStackView.addArrangedSubview(button)
        }
    }
    
    private func createFilterButton(title: String, iconName: String) -> UIButton {
        let button = UIButton(type: .system)
        // Colors
        button.backgroundColor = Colors.gray100
        button.setTitleColor(Colors.gray600, for: .normal)
        button.tintColor = Colors.gray600
        
        // Decorations
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 12)
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.layer.cornerRadius = 8
        
        // Image
        button.setImage(UIImage(named: iconName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.heightAnchor.constraint(equalToConstant: 13).isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 13).isActive = true
        
        // Title
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Typography.textSM
        
        // Default
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    private func updateButtonSelection(button: UIButton) {
        if let previousButton = selectedButton {
            previousButton.backgroundColor = Colors.gray100
            previousButton.setTitleColor(Colors.gray600, for: .normal)
            previousButton.tintColor = Colors.gray600
        }
        
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.tintColor = Colors.gray100
        
        selectedButton = button
    }
    
    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        let selectedCategory = categories[sender.tag]
        updateButtonSelection(button: sender)
        filterButtonAction?(selectedCategory)
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        bottomContainerView.addGestureRecognizer(panGesture)
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            let newConstant = containerTopConstraint.constant + translation.y
            if newConstant <= 0 && newConstant >= frame.height * 0.5 {
                containerTopConstraint.constant = newConstant
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
                
            UIView.animate(withDuration: 0.3, animations: {
                self.containerTopConstraint.constant = finalPosition
                self.layoutIfNeeded()
            })
        default:
            break
        }
    }
}
