//
//  ViewController.swift
//  NotesAppiOS
//
//  Created by ronaldo avalos on 24/11/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var notesTableView: UITableView!
    var notes: [Note] = [] // Array para almacenar las notas
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        notesTableView.dataSource = self
    
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "mi-celda")
        
        notesTableView.delegate = self
        
        // Recuperar las notas guardadas en UserDefaults
        if let storedNotesData = UserDefaults.standard.data(forKey: "userNotes") {
            do {
                let storedNotes = try JSONDecoder().decode([Note].self, from: storedNotesData)
                notes = storedNotes // Agregar las notas recuperadas al array 'notes'
                notesTableView.reloadData() // Actualizar la tabla con las notas recuperadas
            } catch {
                print("Error al decodificar las notas: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "mi-celda", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }


    private func configureItems(){
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem:
                .add,
                target: self,
                        action: #selector(addButtonTapped))
    }
    
    
        
        @objc private func addButtonTapped() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Reemplaza "Main" con el nombre de tu storyboard
              if let secondVC = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController {
                  navigationController?.pushViewController(secondVC, animated: true)
              }
        }

    
        
}

