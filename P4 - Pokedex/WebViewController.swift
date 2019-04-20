//
//  WebViewController.swift
//  P4 - Pokedex
//
//  Created by Mario Penavades on 25/10/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var race: Race?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        // URL a mostrar
        var str = "http://es.pokemon.wikia.com"
        if race != nil {
            // Poner nombre de la raza como titulo de la Navigation Bar
            title = race!.name
            // Añadir la raza al URL escapando caracteres conflictivos
            if let path = "wiki/\(race!.name)" .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
                str = "\(str)/\(path)"
            }
        } else {
            // Poner Pokedex como titulo de la Navigation Bar
            title = "Pokedex"
        }
        if let url = URL(string: str) {
            let req = URLRequest(url: url)
            webView.load(req)
        }
    }
}
