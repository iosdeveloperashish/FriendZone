//
//  MainCoordinator.swift
//  FriendZone
//
//  Created by Ashish Viltoriya on 03/03/21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinator = [Coordinator]()
    
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func configure(friend: Friend ) {
        let vc = FriendViewController.instantiate()
        vc.coordinator = self
        vc.friend = friend
        navigationController.pushViewController(vc, animated: true)
    }
    
    func update(friend: Friend) {
        guard let vc = navigationController.viewControllers.first as? ViewController else { return }
        vc.updateFriend(friend: friend)
    }
    
}
