//
//  AddNoteViewController.swift
//  NotesAppiOS
//
//  Created by ronaldo avalos on 24/11/23.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTexField: UITextField!
    
    
    var editingMode = false
     var noteToEdit: Note?
     var idexNote: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        // Do any additional setup after loading the view.
        
        if editingMode {
                  // Si estamos en modo de edición, configuramos los campos con los datos de la nota existente
                  if let note = noteToEdit {
                      titleTextField.text = note.title
                      noteTexField.text = note.note
                  }
              }
    }
    
    
    
    private func configureItems(){
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem:
                .save,
                target: self,
                        action: #selector(addNote))
    }
    @objc private func addNote() {
        guard let title = titleTextField.text,
              let note = noteTexField.text,
              !title.isEmpty,
              !note.isEmpty else {
            // Manejar la falta de datos ingresados
            return
        }
        
        if editingMode, let index = idexNote, let noteToEdit = noteToEdit {
            // Si estamos en modo de edición, actualizamos la nota existente
            var updatedNote = noteToEdit
            updatedNote.title = title
            updatedNote.note = note
            NotesManager.shared.update(note: updatedNote, atIndex: index)
        } else {
            // Si no estamos en modo de edición, creamos una nueva nota
            let newNote = Note(title: title, note: note)
            NotesManager.shared.save(note: newNote)
        }
       
        navigationController?.popViewController(animated: true)
        
        if let previousViewController = navigationController?.viewControllers.first(where: { $0 is ViewController }) {
             navigationController?.popToViewController(previousViewController, animated: true)
         }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
