//
//  ViewController.swift
//  P3 - Fiesta Media Naranja
//
//  Created by Mario Penavades on 11/10/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bornDateLabel: UILabel!
    @IBOutlet weak var loveDateLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!
    
    var dateLove = Date()
    var dateBorn = Date()
    var dateParty = Date()
    var preferences = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dateBorn2 = preferences.object(forKey: "dateBorn2") as? Date {
            dateBorn = dateBorn2
            bornDateLabel.text = cambioFormato(dateBorn)
            bornDateLabel.isHidden = false
        }else{
            dateBorn = Date()
            bornDateLabel.isHidden = true
        }
        
        if let dateLove2 = preferences.object(forKey: "dateLove2") as? Date {
            dateLove = dateLove2
            loveDateLabel.text = cambioFormato(dateLove)
            loveDateLabel.isHidden = false
        }else{
            dateLove = Date()
            loveDateLabel.isHidden = true
        }
        if let dateParty2 = preferences.object(forKey: "dateParty2") as? Date {
            dateParty = dateParty2
            partyDateLabel.text = cambioFormato(dateParty)
            partyDateLabel.isHidden = false
        }else{
            dateParty = Date()
            partyDateLabel.isHidden = true
        }
        
        //partyDateLabel.isHidden = true
    }
    
    private func cambioFormato(_ dateResult : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: dateResult)
    }
    
    @IBAction func okBack(_ segue: UIStoryboardSegue){
        guard let seg = segue.source as? DateViewController else {return}
        loveDateLabel.isHidden = false
        dateLove = seg.loveDate.date
        loveDateLabel.text = cambioFormato(dateLove)
        
        bornDateLabel.isHidden = false
        dateBorn = seg.bornDate.date
        bornDateLabel.text = cambioFormato(dateBorn)
        
        dateParty = dateBorn.addingTimeInterval(2*dateLove.timeIntervalSince(dateBorn))
        partyDateLabel.isHidden = false
        partyDateLabel.text = cambioFormato(dateParty)
        
        preferences.set(dateLove, forKey: "dateLove2")
        print("Cambiada preferencia: dateAmor->"+cambioFormato(dateLove))
        preferences.set(dateBorn, forKey: "dateBorn2")
        print("Cambiada preferencia: dateBorn->"+cambioFormato(dateBorn))
        preferences.set(dateParty, forKey: "dateParty2")
        print("Cambiada preferencia: dateParty->"+cambioFormato(dateParty))
    }
    
    @IBAction func cancelBack(_ segue: UIStoryboardSegue){}
}

