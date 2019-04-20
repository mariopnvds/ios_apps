//
//  TypesTableViewController.swift
//  P4 - Pokedex
//
//  Created by Mario Penavades on 24/10/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class TypesTableViewController: UITableViewController {

    var model = PokedexModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.types.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "typecell", for: indexPath) as! CellTypeTableViewCell
        let type = model.types[indexPath.row]
        cell.typeImage?.image = UIImage(named: type.icon)
        cell.nameLabel?.text = String(type.name)
        cell.numberLabel?.text = String(type.races.count)+" races"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRaces"{
            let rtvc = segue.destination as! RacesTableViewController
            //Celda que he tocado
            if let ip = tableView.indexPathForSelectedRow{
                rtvc.type = model.types[ip.row]
            }
        }
    }
    /*func backToTypes(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }*/
}
