//
//  ClueTableViewController.swift
//  P5 - Quiz
//
//  Created by Mario Penavades on 06/11/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class ClueTableViewController: UITableViewController {

    var clues = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cluecell", for: indexPath)
        cell.textLabel?.text = clues[indexPath.row]
        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
