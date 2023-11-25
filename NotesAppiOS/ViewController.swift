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
    let notesM = NotesManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        notesTableView.dataSource = self
    
        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "mi-celda")
        
        notesTableView.delegate = self
        
        notes = NotesManager.shared.getNotes()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notes = NotesManager.shared.getNotes() // Obtener las notas actualizadas
        notesTableView.reloadData() // Recargar la tabla con las notas actualizadas
    }
    
    
    private func configureItems(){
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem:
                .add,
                target: self,
                        action: #selector(addButtonTapped))
    }
    
    
        
    @objc private func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController {
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }

    
        
}

