//
//  RacesTableViewController.swift
//  P4 - Pokedex
//
//  Created by Mario Penavades on 24/10/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class RacesTableViewController: UITableViewController {
    var type : Type?
    var model = PokedexModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = type?.name
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return type?.races.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "racecell", for: indexPath)
        let race = type!.races[indexPath.row] // Existe a la fuerza, nunca va a ser nil
        cell.detailTextLabel?.text = String(race.code)
        cell.detailTextLabel?.textColor = UIColor.blue
        cell.textLabel?.text = race.name
        cell.imageView?.image = UIImage(named: race.icon)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebView"{
            let webVC = segue.destination as! WebViewController
            //Celda que he tocado
            if let ip = tableView.indexPathForSelectedRow{
                webVC.title = type!.races[ip.row].name
                webVC.race = type!.races[ip.row]
            }
        }
    }
    
}
