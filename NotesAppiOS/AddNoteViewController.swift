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
    @objc private func addNote(){
        guard let title = titleTextField.text,
                     let note = noteTexField.text else {
                   // Manejar la falta de datos ingresados
                   return
               }
               
               // Crear un objeto Note con los datos ingresados
               let newNote = Note(title: title,note: note)
               
               // Aquí puedes guardar newNote en UserDefaults, Core Data, etc.
               // Por ejemplo, guardarlo en UserDefaults
               do {
                   let encodedNote = try JSONEncoder().encode(newNote)
                   UserDefaults.standard.set(encodedNote, forKey: "storedNote")
                   // Asegúrate de manejar la recuperación y el almacenamiento de datos de manera adecuada
               } catch {
                   print("Error al codificar la nota: \(error)")
                   // Manejar errores de codificación
               }
               
               // Puedes agregar más lógica para notificar sobre la creación exitosa de la nota, navegación de regreso, etc.
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
