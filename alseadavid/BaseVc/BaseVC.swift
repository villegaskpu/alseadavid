//
//  BaseVC.swift
//  alseadavid
//
//  Created by david villegas santana on 11/02/21.
//

import UIKit

struct Screen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(Screen.width, Screen.height)
    static let minLength = min(Screen.width, Screen.height)
    static let midX = UIScreen.main.bounds.midX
    static let midY = UIScreen.main.bounds.midY
    static let bounds = UIScreen.main.bounds
}

class BaseVC: UIViewController {
    private var loadingContainer: UIView?
    var leftAction  = {}
    var rightAction  = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    func setNavigationBar() {

        self.navigationItem.setHidesBackButton(true, animated:false)

        //your custom view for back image with custom size
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = #imageLiteral(resourceName: "IconoBack")
        view.addSubview(imageView)

        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showLoadingScreen(overCurrentContext: Bool = false) {
        DispatchQueue.main.async {
            self.loadingContainer = UIView()
            guard let loadingContainer = self.loadingContainer else {return}
                for subview in loadingContainer.subviews {
                    subview.removeFromSuperview()
                }
                
                loadingContainer.frame = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
                loadingContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                loadingContainer.alpha = 0.0
                
                let frameAct = CGRect(x: Screen.width/2 - 20.0, y: Screen.height/2, width: 40.0, height: 40.0)
                
                let actv = UIActivityIndicatorView(frame: frameAct)
                actv.startAnimating()
                
                loadingContainer.addSubview(actv)
                
                if overCurrentContext {
                    if let w = UIApplication.shared.keyWindow {
                        w.addSubview(loadingContainer)
                    }
                }
                else {
                    self.view.addSubview(loadingContainer)
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    loadingContainer.alpha = 1.0
                })
        }
    }
    
    
    func hiddeLoadingScreen() {
        DispatchQueue.main.async {
            guard let loadingContainer = self.loadingContainer else {return}
            UIView.animate(withDuration: 0.8, animations: {
                loadingContainer.alpha = 0.0
            },completion: { void in
                loadingContainer.removeFromSuperview()
            })
        }
    }
    
    func showAlert(msj: String) {
        let alert = UIAlertController(title: "¡Aviso!", message: msj, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

