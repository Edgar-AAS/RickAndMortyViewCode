//
//  DetailScreen.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 02/08/22.
//

import UIKit

final class DetailScreen: UIView {
    lazy var characterImage: UIImageView = {
        let imageChar = UIImageView()
        imageChar.translatesAutoresizingMaskIntoConstraints = false
        imageChar.contentMode = .scaleAspectFill
        imageChar.clipsToBounds = true
        imageChar.layer.cornerRadius = 10
        imageChar.layer.borderWidth = 2
        imageChar.layer.borderColor = UIColor.darkGray.cgColor  
        return imageChar
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Character Name"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status:"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var specieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Species:"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gender:"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Origin:"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var stackView = makeVerticalStackView(views: [
        statusLabel,
        specieLabel,
        genderLabel,
        originLabel
    ])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: DetailScreenViewModel?
    
    // MARK: - Fill Status
    
    public func setupCharacterData(character: Character) {
        viewModel = DetailScreenViewModel(data: character)
        
        guard let viewModel = viewModel else  { return }
    
        characterImage.dowloadImage(at: viewModel.getImageURL)
        characterNameLabel.text = viewModel.getName
        statusLabel.text = viewModel.getStatus
        specieLabel.text = viewModel.getSpecies
        genderLabel.text = viewModel.getGender
        originLabel.text = viewModel.getOrigin
    }
}

//MARK: - Congfigurate DetailScreen layout
extension DetailScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(characterImage)
        addSubview(characterNameLabel)
        addSubview(containerView)
        containerView.addSubview(stackView)
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            characterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            characterImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            characterImage.heightAnchor.constraint(equalToConstant: 280),
            
            characterNameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 8),
            characterNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            containerView.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 24),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24)
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        containerView.backgroundColor = UIColor(hexString: "1A1A1B")
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.darkGray.cgColor
    }
}

extension DetailScreen {
    private func makeVerticalStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }
}
