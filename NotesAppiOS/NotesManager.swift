//
//  NotesManager.swift
//  NotesAppiOS
//
//  Created by ronaldo avalos on 24/11/23.
//

import Foundation

class NotesManager {
    static let shared = NotesManager()
    private let userDefaults = UserDefaults.standard
    private let noteKey = "userNotes"
    
    func save(note: Note) {
        var savedNotes = getNotes()
        savedNotes.append(note)
        saveNotes(savedNotes)
    }
    
    func update(note: Note, atIndex index: Int) {
        var savedNotes = getNotes()
        savedNotes[index] = note
        saveNotes(savedNotes)
    }
    
    func delete(atIndex index: Int) {
        var savedNotes = getNotes()
        savedNotes.remove(at: index)
        saveNotes(savedNotes)
    }
    
    func getNotes() -> [Note] {
        if let data = userDefaults.value(forKey: noteKey) as? Data,
           let savedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            return savedNotes
        }
        return []
    }
    
    private func saveNotes(_ notes: [Note]) {
        if let encoded = try? JSONEncoder().encode(notes) {
            userDefaults.set(encoded, forKey: noteKey)
        }
    }
}
