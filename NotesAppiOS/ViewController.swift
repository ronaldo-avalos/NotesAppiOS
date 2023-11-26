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
        // Habilitar la edición de la tabla (deslizar para eliminar)
           notesTableView.allowsMultipleSelectionDuringEditing = true
           
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
    
    // Item selecionado
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let editNoteVC = storyboard.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController {
             // Configura la vista de edición de nota con la nota seleccionada
             editNoteVC.editingMode = true
             editNoteVC.noteToEdit = notes[indexPath.row]
             editNoteVC.idexNote = indexPath.row
             navigationController?.pushViewController(editNoteVC, animated: true)
         }
    }
    // Eliminar Item
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Mostrar diálogo de confirmación
            showDeleteConfirmationDialog(forRowAt: indexPath)
        }
    }


    // Dialogo de confirmacion
    func showDeleteConfirmationDialog(forRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Confirmar eliminación",
                                                message: "¿Estás seguro de que deseas eliminar esta nota?",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { _ in
            // Si el usuario confirma la eliminación, elimina la nota
            self.deleteNote(at: indexPath.row)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    func deleteNote(at index: Int) {
        // Eliminar la nota del array
        NotesManager.shared.delete(atIndex: index)
        
        // Actualizar el array y la tabla
        notes = NotesManager.shared.getNotes()
        notesTableView.reloadData()
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

