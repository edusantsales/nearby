//
//  SplashViewController.swift
//  Nearby
//
//  Created by Eduardo Sant Ana Sales on 25/02/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let contentView: SplashView
    weak var delegate: SplashFlowDelegate?
    
    init(contentView: SplashView, delegate: SplashFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        decideFlow()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.greenLight
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupContentViewToViewController(contentView: contentView)
    }
    
    private func decideFlow() {
        // Wait 3 seconds and decide if the user go to home or welcome screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            [weak self] in self?.delegate?.decideNavigationFlow()
        }
    }
}
