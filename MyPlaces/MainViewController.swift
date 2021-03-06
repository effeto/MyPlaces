//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Демьян on 01.10.2021.
//

import UIKit
import RealmSwift
import SwiftUI

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reverseSortingButton: UIBarButtonItem!
    
    
    var places: Results<Place>!
    var ascendingSorting = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true

        return cell
    }
    
    //MARK: Table View Delegate
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let place = places[indexPath.row]
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in

        StorageManager.deleteObject(place)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
         
        
        
    let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

    return swipeActions
}
    
    

        
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place = places[indexPath.row]
            let newPlaceVc = segue.destination as! NewPlaceViewController
            newPlaceVc.currentPlace = place
             
        }

    }
    
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? NewPlaceViewController else {return}
        
        newPlaceVC.savePlace()
        tableView.reloadData()
    }

    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reverseSorting(_ sender: Any) {
        
        ascendingSorting.toggle()
        
        sorting()
    }
    
    private func sorting() {
        
        if segmentedControl.selectedSegmentIndex ==  0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        }else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
    
    
}
