//
//  ViewController.swift
//  RickAndMortyAPI
//
//  Created by Leonardo Almeida on 28/03/22.
//

import UIKit

class CharactersViewControllers: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var charactersSpecs: [Result] = []
    var characterResult: Result?
    var filterType = String()
    var rickAndMortyManager = RickAndMortyManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        tableView.dataSource = self
        rickAndMortyManager.delegate = self
        tableView.delegate = self
        rickAndMortyManager.performRequest(endPoint: filterType)
        tableView.register(UINib(nibName: K.Identifiers.nibName, bundle: nil), forCellReuseIdentifier: K.Identifiers.reusableCellIdentifier)
    }
    
    //passando o objeto para spectController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let specsViewController = segue.destination as! SpecsViewController
        specsViewController.characterDatas = characterResult
    }
}

extension CharactersViewControllers: RickAndMortyManagerDelegate {
    func didUpdateData(_ rickAndMortyManager: RickAndMortyManager, data: RickAndMortyData) {
        charactersSpecs = data.results.sorted { $0.name < $1.name }
        tableView.reloadData()
    }
    
    func didFailError(error: Error) {
        print(error.localizedDescription)
    }
}

extension CharactersViewControllers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersSpecs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.reusableCellIdentifier) as! CharacterNamesCell
        cell.labelName.text = charactersSpecs[indexPath.row].name
        cell.selectionStyle = .gray
        return cell
    }
}

extension CharactersViewControllers: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        characterResult = charactersSpecs[indexPath.row]
        self.performSegue(withIdentifier: K.Identifiers.specsSegueIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
