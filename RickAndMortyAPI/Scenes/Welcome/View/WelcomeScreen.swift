//
//  WelcomeScreen.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 31/07/22.
//

import UIKit

protocol WelcomeScreenDelegate: AnyObject {
    func didTapAction()
}

final class WelcomeScreen: UIView {
    private lazy var imageView: UIImageView = {
         let imageView = UIImageView()
         imageView.image = UIImage(named: "rickart2")
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.contentMode = .scaleAspectFit
         return imageView
     }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GetSchwifty-Regular", size: 48)
        label.textColor = UIColor(hexString: "64CCDA")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
        button.setTitle("Characters", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.backgroundColor = UIColor(named: "ColorComponents")
        return button
    }()
    
    private weak var delegate: WelcomeScreenDelegate?
    
    convenience init(delegate: WelcomeScreenDelegate?) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    @objc private func didTapAction() {
        delegate?.didTapAction()
    }
    
    private func setupTitleAnimation() {
        titleLabel.text = ""
        
        let appName = K.appName
        var indexNumber = 0.0
        
        for caractere in appName {
            Timer.scheduledTimer(withTimeInterval: 0.1 * indexNumber, repeats: false) { (timer) in
                self.titleLabel.text?.append(caractere)
            }
            
            indexNumber += 1
        }
    }
}

extension WelcomeScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 16),
            
            button.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        setupTitleAnimation()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
}

