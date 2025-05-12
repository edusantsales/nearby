import Foundation
import UIKit

class PlaceContentView: UIView {
    // Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var titleView = UIStackView()
    
    private func createTitle(placeName: String, categoryName: String) -> UIStackView {
        // Components
        let label = UILabel()
        label.font = Typography.titleLG
        label.numberOfLines = 0
        label.textColor = Colors.gray600
        label.text = placeName
        label.translatesAutoresizingMaskIntoConstraints = false
        
        var icon = UIImageView(image: UIImage(named: "map-pin"))
        
        switch categoryName {
        case "Alimentação":
            icon = UIImageView(image: UIImage(named: "food"))
        case "Cinema":
            icon = UIImageView(image: UIImage(named: "movie"))
        case "Compras":
            icon = UIImageView(image: UIImage(named: "shopping-bag"))
        case "Hospedagem":
            icon = UIImageView(image: UIImage(named: "bed"))
        case "Padaria":
            icon = UIImageView(image: UIImage(named: "food"))
        default:
            icon = UIImageView(image: UIImage(named: "map-pin"))
        }
        
        icon.tintColor = Colors.greenBase
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [label, icon])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var couponView = UIView()
    
    private func createCoupon(text: String) -> UIView {
        // Components
        let view = UIView()
        view.backgroundColor = Colors.redLight
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let icon = UIImageView(image: UIImage(named: "ticket"))
        icon.tintColor = Colors.redBase
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let couponText = UILabel()
        couponText.font = Typography.titleSM
        couponText.textColor = Colors.gray600
        couponText.text = text
        couponText.translatesAutoresizingMaskIntoConstraints = false
        
        let couponLabel = UILabel()
        couponLabel.font = Typography.textSM
        couponLabel.textColor = Colors.gray600
        couponLabel.text = "cupons disponíveis"
        couponLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let couponStack = UIStackView(arrangedSubviews: [couponText, couponLabel])
        couponStack.axis = .horizontal
        couponStack.spacing = 4
        couponStack.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [icon, couponStack])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup UI
        view.addSubview(stack)
        
        // Constraints
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
        
        return view
    }
    
    private let regulationTitlelabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.text = "Regulamento"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let regulationDescriptionlabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.text = """
          •  Válido apenas para consumo no local
        
          •  Disponível até 31/12/2025
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let regulationDivider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let informationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.text = "Informações"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var informationView = UIStackView()
    
    private func createInformation(
        iconAddress: String,
        textAddress: String,
        iconContact: String,
        textContact: String,
    ) -> UIStackView {
        let iconAddress = UIImageView(image: UIImage(named: iconAddress))
        iconAddress.tintColor = Colors.gray500
        iconAddress.translatesAutoresizingMaskIntoConstraints = false
        iconAddress.heightAnchor.constraint(equalToConstant: 16).isActive = true
        iconAddress.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        let labelAddress = UILabel()
        labelAddress.font = Typography.textSM
        labelAddress.numberOfLines = 0
        labelAddress.textColor = Colors.gray500
        labelAddress.text = textAddress
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        
        let stackAddress = UIStackView(arrangedSubviews: [iconAddress, labelAddress])
        stackAddress.axis = .horizontal
        stackAddress.spacing = 8
        stackAddress.translatesAutoresizingMaskIntoConstraints = false
        
        let iconContact = UIImageView(image: UIImage(named: iconContact))
        iconContact.tintColor = Colors.gray500
        iconContact.translatesAutoresizingMaskIntoConstraints = false
        iconContact.heightAnchor.constraint(equalToConstant: 16).isActive = true
        iconContact.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        let labelContact = UILabel()
        labelContact.font = Typography.textSM
        labelContact.numberOfLines = 0
        labelContact.textColor = Colors.gray500
        labelContact.text = textContact
        labelContact.translatesAutoresizingMaskIntoConstraints = false
        
        let stackContact = UIStackView(arrangedSubviews: [iconContact, labelContact])
        stackContact.axis = .horizontal
        stackContact.spacing = 8
        stackContact.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [stackAddress, stackContact])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
    
    private let informationDivider: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let couponTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.text = "Cupons disponíveis"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var couponCodeView = UIView()
    
    private func createCouponCode(text: String) -> UIView {
        // Components
        let view = UIView()
        view.backgroundColor = Colors.greenLight.withAlphaComponent(0.12)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let icon = UIImageView(image: UIImage(named: "ticket"))
        icon.tintColor = Colors.greenDark
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let label = UILabel()
        label.font = Typography.textXS
        label.numberOfLines = 0
        label.textColor = Colors.greenDark
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stack = UIStackView(arrangedSubviews: [icon, label])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup UI
        view.addSubview(stack)
        
        // Constraints
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
        
        return view
    }
    
    private let buttonsView: UIStackView = {
        let titleFont = AttributeContainer([.font: Typography.action])
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.background.cornerRadius = 12
        buttonConfig.baseBackgroundColor = Colors.greenBase
        buttonConfig.baseForegroundColor = Colors.gray100
        
        let locationButton = UIButton()
        buttonConfig.image = UIImage(named: "map-pin")
        locationButton.configuration = buttonConfig
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        let qrCodeButton = UIButton()
        let qrCodeText = "Ler QR Code"
        buttonConfig.attributedTitle = AttributedString(qrCodeText, attributes: titleFont)
        buttonConfig.image = UIImage(named: "scan")
        buttonConfig.imagePadding = 16
        qrCodeButton.configuration = buttonConfig
        qrCodeButton.translatesAutoresizingMaskIntoConstraints = false
        qrCodeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [locationButton, qrCodeButton])
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponent(place: Place, category: Category) {
        self.titleView = createTitle(placeName: place.name, categoryName: category.name)
        descriptionLabel.text = place.description
        self.couponView = createCoupon(text: place.coupons.description)
        self.informationView = createInformation(
            iconAddress: "map-pin",
            textAddress: place.address,
            iconContact: "phone",
            textContact: place.phone,
        )
        self.couponCodeView = createCouponCode(text: place.id)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(titleView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(couponView)
        containerView.addSubview(regulationTitlelabel)
        containerView.addSubview(regulationDescriptionlabel)
        containerView.addSubview(regulationDivider)
        containerView.addSubview(informationTitleLabel)
        containerView.addSubview(informationView)
        containerView.addSubview(informationDivider)
        containerView.addSubview(couponTitleLabel)
        containerView.addSubview(couponCodeView)
        containerView.addSubview(buttonsView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            couponView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            couponView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            couponView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            couponView.heightAnchor.constraint(equalToConstant: 44),
            
            regulationTitlelabel.topAnchor.constraint(equalTo: couponView.bottomAnchor, constant: 32),
            regulationTitlelabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            regulationTitlelabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            regulationDescriptionlabel.topAnchor.constraint(equalTo: regulationTitlelabel.bottomAnchor, constant: 12),
            regulationDescriptionlabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            regulationDescriptionlabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            regulationDivider.topAnchor.constraint(equalTo: regulationDescriptionlabel.bottomAnchor, constant: 16),
            regulationDivider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            regulationDivider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            regulationDivider.heightAnchor.constraint(equalToConstant: 1),
            
            informationTitleLabel.topAnchor.constraint(equalTo: regulationDivider.bottomAnchor, constant: 32),
            informationTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            informationTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            informationView.topAnchor.constraint(equalTo: informationTitleLabel.bottomAnchor, constant: 12),
            informationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            informationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            informationDivider.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 16),
            informationDivider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            informationDivider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            informationDivider.heightAnchor.constraint(equalToConstant: 1),
            
            couponTitleLabel.topAnchor.constraint(equalTo: informationDivider.bottomAnchor, constant: 32),
            couponTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            couponTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            couponCodeView.topAnchor.constraint(equalTo: couponTitleLabel.bottomAnchor, constant: 12),
            couponCodeView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            couponCodeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            buttonsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),
            buttonsView.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
