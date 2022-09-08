//
//  WelcomeViewController.swift
//  RickAndMortyAPI
//
//  Created by Edgar Arlindo on 02/04/22.
//

import UIKit

final class WelcomeViewController: UIViewController {
    override func loadView() {
        self.view = WelcomeScreen(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barTintColor = .black
    }
}

extension WelcomeViewController: WelcomeScreenDelegate {
    func didTapAction() {
        let listViewController = CategoriesViewController(style: .grouped)
        listViewController.navigationItem.hidesBackButton = true
        navigationController?.pushViewController(listViewController, animated: true)
    }
}
