//
//  DateViewController.swift
//  P3 - Fiesta Media Naranja
//
//  Created by Mario Penavades on 11/10/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var bornDate: UIDatePicker!
    @IBOutlet weak var loveDate: UIDatePicker!
    let preferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dateLove2 = preferences.object(forKey: "dateLove2") as? Date {
            loveDate.date = dateLove2
        }
        if let dateBorn2 = preferences.object(forKey: "dateBorn2") as? Date {
            bornDate.date = dateBorn2
        }
    }
 
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "okBack"{
            if (bornDate.date > Date()){
                let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes elegir una fecha de nacimiento mayor que hoy!¡No puedes nacer en el futuro!", preferredStyle: .alert)
                alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                    print("Se pulso OK")}))
                present(alertErrorFechas, animated: true)
                return false
            }
            if (loveDate.date > Date()){
                let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes elegir una fecha de enamoramiento mayor que hoy!¡No sabes si te enamorarás en el futuro!", preferredStyle: .alert)
                alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                    print("Se pulso OK")}))
                present(alertErrorFechas, animated: true)
                return false
            }
            if (loveDate.date <= bornDate.date){
                let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes elegir una fecha de enamoramiento menor que de nacimiento!", preferredStyle: .alert)
                alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                    print("Se pulso OK")
                }))
                present(alertErrorFechas, animated: true)
                return false
            }
        }
        return true
    }
}
