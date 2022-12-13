import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOcurred(with type: Event) {
        switch type {
        case .charactersButtonTapped:
            var viewController: UIViewController & Coordinating = CategoriesViewController(style: .grouped)
            viewController.navigationItem.hidesBackButton = true
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
        case .statusList(let statusType):
            switch statusType {
            case .alive, .dead, .statusUnknown:
                let viewModel = GenericListViewModel(endPoint: StatusEndPoint(endPoint: statusType.rawValue))
                var viewController: UIViewController & Coordinating = GenericListViewController(viewModel: viewModel)
                viewController.coordinator = self
                navigationController?.pushViewController(viewController, animated: true)
            case .species:
                let viewModel = SpecieViewModel()
                var viewController: UIViewController & Coordinating = SpeciesTableViewController(viewModel: viewModel)
                viewController.coordinator = self
                navigationController?.pushViewController(viewController, animated: true)
            case .gender:
                let viewModel = GenderViewModel()
                var viewController: UIViewController & Coordinating = GenderTableViewController(viewModel: viewModel)
                viewController.coordinator = self
                navigationController?.pushViewController(viewController, animated: true)
            case .favorites:
                let viewModel = FavoritesViewModel()
                var viewController: UIViewController & Coordinating = FavoritesViewController(viewModel: viewModel)
                viewController.coordinator = self
                navigationController?.pushViewController(viewController, animated: true)
            }
        case .specieType(let specieType):
            let viewModel = GenericListViewModel(endPoint: SpecieEndPoint(endPoint: specieType.rawValue))
            var viewController: UIViewController & Coordinating = GenericListViewController(viewModel: viewModel)
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
        case .genderType(let genderType):
            let viewModel = GenericListViewModel(endPoint: GenderEndPoint(endPoint: genderType.rawValue))
            var viewController: UIViewController & Coordinating = GenericListViewController(viewModel: viewModel)
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
        case .pushCharacterDetail(let character):
            let characterManager = CharacterDataManager(characterData: character)
            var viewController: UIViewController & Coordinating = DetailViewController(character: character, manager: characterManager)
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
        case .pushFavoriteDetail(let favoriteMapped):
            var viewController: UIViewController & Coordinating = DetailViewController(character: favoriteMapped, manager: CharacterDataManager(characterData: favoriteMapped))
            viewController.coordinator = self
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func start() {
        var vc: UIViewController & Coordinating = WelcomeViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
}
