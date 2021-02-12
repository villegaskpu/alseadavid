//
//  FormularioVC.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import UIKit

class FormularioVC: BaseVC, Storyboarded {
    @IBOutlet weak var txtSismo: UITextField!
    @IBOutlet weak var pikerFechaInicio: UIDatePicker!
    @IBOutlet weak var pikerFechaTermino: UIDatePicker!
    @IBOutlet weak var btnConsultar: UIButton!
    
    var coordinator: MainCoordinator?
    var viewModel = FormularioViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModelCallBack()
    }
    
    private func configureView() {
        let locale = Locale(identifier: "es")
        pikerFechaInicio.locale = locale
        pikerFechaTermino.locale = locale
        
        pikerFechaInicio.maximumDate = Date()
        pikerFechaTermino.minimumDate = Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    @IBAction func onClickConsultar(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingScreen()
            viewModel.validateMagnitud(magnitud: txtSismo?.text ?? "") { [weak self] valor in
                guard let self = self, let valor = valor else {return}
                self.hiddeLoadingScreen()
                
                if valor {
                    let mag = Double(self.txtSismo?.text ?? "0") ?? 0.0
                    self.viewModel.saveData(fechaI: self.pikerFechaInicio.date, fechaF: self.pikerFechaTermino.date, magnitud: mag)
                    self.viewModel.getSismos(fechaInicio: self.pikerFechaInicio.date, fechaTermino: self.pikerFechaTermino.date, sismo: mag)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        self.showAlert(msj: "Escribir magnitud del sismo")
                    }
                }
            }
        } else {
            showAlert(msj: "Se necesita conexión a internet")
        }
    }
    
    
    
    @IBAction func onClickUltimaBusqueda(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            self.showLoadingScreen()
            viewModel.getData { [weak self] (fi, ff, mg) in
                guard let sel = self else {
                    return
                }
                
                guard let fi = fi, let ff = ff, let mg = mg else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                        sel.showAlert(msj: "Aún no has realizado una búsqueda")
                    }
                    
                    return
                }
                sel.viewModel.getSismos(fechaInicio: fi, fechaTermino: ff, sismo: mg)
            }
        } else {
            showAlert(msj: "Se necesita conexión a internet")
        }
        
    }
    
    private func viewModelCallBack() {
        viewModel.sismosCompletionHandler { [weak self] sismos in
            guard let self = self, let sismos = sismos else {return}
            self.hiddeLoadingScreen()
            DispatchQueue.main.async {
                self.coordinator?.goDetalle(sismos: sismos)
            }
        }
    }
    
    
}
