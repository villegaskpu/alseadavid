//
//  FormularioViewModel.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import Foundation


class FormularioViewModel {
    
    typealias callBack = (_ sismos:SismosModel?) -> Void
    typealias magnitudCallBack = (_ sismos:Bool?) -> Void
    typealias datadCallBack = (_ fechaI: Date?, _ fechaF:Date?, _ magnitud:Double?) -> Void
    
    var simosCallBack : callBack?
    
    func getSismos(fechaInicio: Date, fechaTermino:Date, sismo:Double) {
        ManagerDataExternal.shared.getSismos(fechaInicio: fechaInicio, fechaTermino: fechaTermino, sismo: sismo) { (sismos, error) in
            guard let sismos = sismos else {
                print("sin datos")
                return
            }
            self.simosCallBack?(sismos)
        }
    }
    
    func sismosCompletionHandler(callBack: @escaping callBack) {
        self.simosCallBack = callBack
    }
    
    func validateMagnitud(magnitud: String, callBack: @escaping magnitudCallBack) {
        if !magnitud.isEmpty {
            callBack(true)
        } else {
            callBack(false)
        }
    }
    
    func saveData(fechaI: Date, fechaF:Date, magnitud:Double) {
        let user = UserDefaults.standard
        user.setValue(fechaI, forKey: "fechaInicio")
        user.setValue(fechaF, forKey: "fechaFin")
        user.setValue(magnitud, forKey: "magnitud")
        user.synchronize()
    }
    
    func getData(callBack: @escaping datadCallBack) {
        let user = UserDefaults.standard
        let fi = user.value(forKey: "fechaInicio") as? Date
        let ff = user.value(forKey: "fechaFin") as? Date
        let mg = user.value(forKey: "magnitud") as? Double
        if fi == nil || ff == nil || mg == nil {
            callBack(nil, nil, nil)
        } else {
            callBack(fi, ff, mg)
        }
        
    }
}
