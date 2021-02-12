//
//  DetalleVC.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import UIKit

class DetalleVC: BaseVC , Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var coordinator: MainCoordinator?
    var viewModel : DetalleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureView() {
    }
}

extension DetalleVC :UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sismos?.features.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let obj = viewModel?.sismos?.features[indexPath.row]
        cell.textLabel?.text = obj?.properties.title ?? ""
        cell.detailTextLabel?.text = "Magnitud: \(obj?.properties.mag ?? 0.0)  Hora: \(getDate(date: Double(obj?.properties.time ?? 0)))"
        cell.backgroundColor = setColorBakgroundCell(magnitud: obj?.properties.mag ?? 0.0)
        return cell
    }
    
    private func setColorBakgroundCell(magnitud: Double) -> UIColor {
        
        switch magnitud {
        case 0..<4:
            return UIColor.green
        case 4..<6:
            return UIColor.yellow
        case 6..<7:
            return UIColor.orange
        default:
            return UIColor.red
        }
    }
    
    private func getDate(date:Double) -> String {
        let date = NSDate(timeIntervalSince1970: date)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    
}
