//
//  Coordinator.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
