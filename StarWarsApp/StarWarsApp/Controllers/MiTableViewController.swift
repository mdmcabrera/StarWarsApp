//
//  MiTableViewController.swift
//  StarWarsApp
//
//  Copyright © 2019 Alex Garcia y Mar Cabrera. All rights reserved.
//

import UIKit
import Firebase

class MiTableViewController: UITableViewController, UISearchBarDelegate {

    
    // MARK: Properties
  
    let ref = Database.database().reference(withPath: "personajes")
    /*
    var misImagenes: [UIImage] = [
        UIImage(named: "animal.png")!,
        UIImage(named: "robot.png")!,
        UIImage(named: "humano.png")!
    ] */
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.colorTableView // color tableview
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        ref.observe(.value, with: { snapshot in
            var nuevosItems: [Personaje] = []
            
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let personajeItem = Personaje(snapshot: snapshot){
                    nuevosItems.append(personajeItem)
                }
            }
            items = nuevosItems
            self.tableView.reloadData()
        })
    }
    
    // MARK: UITableView Delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let personajeItem = items[indexPath.row]
        
        cell.backgroundColor = UIColor.colorCelda // Color celda
        cell.textLabel?.font = UIFont(name:"StarJedi", size:17.0)
        cell.textLabel?.textColor = UIColor.white
        
        cell.textLabel?.text = personajeItem.nombre
        cell.detailTextLabel?.text = personajeItem.raza
        cell.detailTextLabel?.textColor = UIColor.white
     //  cell.imageView?.image = misImagenes[indexPath.row]

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let personajeItem = items[indexPath.row]
            personajeItem.ref?.removeValue()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  guard let cell = tableView.cellForRow(at: indexPath) else { return }
      //  var personajeItem = items[indexPath.row]
        let personaje = items[indexPath.row]
        performSegue(withIdentifier: "tabloToview", sender: personaje)
        tableView.reloadData()
        
        
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        if segue.identifier == "tabloToview"{
           
        
            
           let destVC = segue.destination as! UITabBarController
            destVC.item = sender as? Personaje
            
            
        }
        
        
        
    }
 
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
        }
    }
    
    // MARK: Add Item
    
    @IBAction func addPersonaje(_ sender: Any) {
        let alert = UIAlertController(title: "Personaje",
                                      message: "Añadir un personaje",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Nombre"
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Edad"
        })
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Raza"
        })
        
        let saveAction = UIAlertAction(title: "Añadir", style: .default) { _ in
         guard  let textFieldNombre = alert.textFields?.first,
            let text = textFieldNombre.text else { return }
            let textFieldEdad = alert.textFields![1] as UITextField
            let textFieldRaza = alert.textFields![2] as UITextField
            
            let personajeItem = Personaje(nombre: textFieldNombre.text!,
                                         edad: textFieldEdad.text!,
                                         raza: textFieldRaza.text!)
            
            let personajeItemRef = self.ref.child(text.lowercased())
            personajeItemRef.setValue(personajeItem.toAnyObject())
            
          //  self.items.append(personajeItem)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    // ADDED NUEVO
    private func setUpSearchBar(){
        searchBar.delegate = self
    }

  
}
