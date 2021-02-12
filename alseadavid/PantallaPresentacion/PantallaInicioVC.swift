//
//  ViewController.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import UIKit

class PantallaInicioVC: UIViewController, Storyboarded {
    
    
    
    
    
    var coordinator: MainCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goFormulario()
    }

    private func goFormulario() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("ya pasaron 5 seg")
            self.coordinator?.goFormulario()
        }
    }
}

