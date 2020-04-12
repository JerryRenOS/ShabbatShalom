//
//  EventsViewController.swift
//  ShabbatShalom
//
//  Created by Jerry Ren on 4/5/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//


import UIKit

var eventsContainerArray = ["Netflix Dash", "Symphony Qi", "R-Ps Reunit", "Dato Knighto", "SupaMart Riot"]
  
class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTable.dataSource = self
        eventsTable.delegate = self

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
  //      eventsTable.reloadData()
        print("viewDidAppear called")
    }
    
    func updatingTable() {
        DispatchQueue.main.async {
            self.eventsTable.reloadData()
        }
    }
    
    // MARK: - Alert Controller Pop-Up
    
    @IBAction func cornerBarButtonTapped(_ sender: UIBarButtonItem) {
        
        var localTextfield = UITextField()
        
        let alertCon = UIAlertController(title: "What is your event?", message: "", preferredStyle: .alert)
        
        alertCon.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "E.g Pre-prom party"
            localTextfield = alertTextfield // not .text?
        }
        
        let alertAction = UIAlertAction(title: "Execute", style: .default) { (action) in
            eventsContainerArray.append(localTextfield.text!)
            self.eventsTable.reloadData()
        }
        alertCon.addAction(alertAction)
        present(alertCon, animated: true, completion: nil)
    }
}



extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventsTable.dequeueReusableCell(withIdentifier: GlobalConstants.eventsCell, for: indexPath) as! EventsTViCell
        
        cell.evTViCelloLabel.text = eventsContainerArray[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsContainerArray.count
    }
}

extension EventsViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        eventsTable.deselectRow(at: indexPath, animated: true)
        
        let primaryStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let destination = primaryStoryBoard.instantiateViewController(withIdentifier: GlobalConstants.EventDetailVCStoryboardID) as? EventDetailsViewController else {
            print("destination unclear bud")
            return
        }
        GlobalConstants.eViDetailsNavigationBarTitle = eventsContainerArray[indexPath.row]
        
        navigationController?.pushViewController(destination, animated: true)         
    }
    
    
    // make sure to check if isUserInteractionEnabled is checked or not
}



// MARK: - some useful didSelectRowAt codes:

//if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//    tableView.cellForRow(at: indexPath)?.accessoryType = .none
//} else {
//    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//}

