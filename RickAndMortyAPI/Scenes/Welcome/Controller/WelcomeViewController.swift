//
//  WelcomeViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 02/04/22.
//

import UIKit

final class WelcomeViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    override func loadView() {
        view = WelcomeScreen(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension WelcomeViewController: WelcomeScreenDelegate {
    func didTapAction() {
        coordinator?.eventOcurred(with: .charactersButtonTapped)
    }
}
