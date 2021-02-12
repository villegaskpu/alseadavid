//
//  ManagerDataExternal.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import Foundation

class ManagerDataExternal {
    static var shared = ManagerDataExternal()
    private let urlSession = URLSession.shared
    private let baseURL = "https://earthquake.usgs.gov/fdsnws/event/1/"
    //https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02&minmagnitude=5.5
    
    func getSismos(fechaInicio:Date, fechaTermino:Date, sismo:Double, completion: @escaping(_ filmsDict: SismosModel?, _ error: Error?) -> ()) {
        let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

        let fechaI = formatter.string(from: fechaInicio)
        let fechaF = formatter.string(from: fechaTermino)
        let urlRequest = URLRequest(url: URL(string: baseURL + "query?format=geojson&starttime=\(fechaI)&endtime=\(fechaF)&minmagnitude=\(sismo)")!)
        print(urlRequest)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse else {
                return completion(nil,error)
            }
            
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let sismos = try decoder.decode(SismosModel.self, from: data)
                    
                    
                    completion(sismos,nil)
                } catch let error {
                    print("error: \(error.localizedDescription)")
                    completion(nil,error)
                }
            } else {
                print("ocurrio un error 😤")
                completion(nil,error)
            }
        }.resume()
    }
}
