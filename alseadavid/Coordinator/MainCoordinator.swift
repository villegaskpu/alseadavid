//
//  MainCoordinator.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 1, green: 0.07843137255, blue: 0.6078431373, alpha: 1)
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        
    }

    func start() {
        let vc = PantallaInicioVC.instantiate()
        vc.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goFormulario() {
        let vc = FormularioVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goDetalle(sismos: SismosModel) {
        let vc = DetalleVC.instantiate()
        vc.viewModel = DetalleViewModel(sismos: sismos)
        vc.coordinator = self
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
