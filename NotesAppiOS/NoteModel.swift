//
//  NoteModel.swift
//  NotesAppiOS
//
//  Created by ronaldo avalos on 24/11/23.
//

import Foundation
struct Note: Codable {
    var title: String
    var note: String   
    
    
    enum  CodingKeys: String, CodingKey {
        case title
        case note
    
}


}
