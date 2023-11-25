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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        // Do any additional setup after loading the view.
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
        
        // Crear un objeto Note con los datos ingresados
        let newNote = Note(title: title, note: note)
        
        NotesManager.shared.save(note: newNote)
        navigationController?.popViewController(animated: true)
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
