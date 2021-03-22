//
//  Coordinator.swift
//  FriendZone
//
//  Created by Ashish Viltoriya on 03/03/21.
//

import UIKit
 
protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
