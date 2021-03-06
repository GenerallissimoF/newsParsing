//
//  NewsTableViewController.swift
//  newsParsing
//
//  Created by Ivan Adoniev on 14.01.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
    
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let person = person?[indexPath.row] else { return cell }
        var content = cell.defaultContentConfiguration()
        content.text = "\(person.name )" + " " + "\(person.surname )"
        cell.contentConfiguration = content
        return cell
    }
   
}
