//
//  NoteViewCell.swift
//  NotesAppiOS
//
//  Created by ronaldo avalos on 24/11/23.
//

import UIKit

class NoteViewCell: UITableViewCell {

    @IBOutlet weak var titleNote: UILabel!
    @IBOutlet weak var conctentNote: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell(title: String, content: String) {
           titleNote.text = title
           conctentNote.text = content
           
       }

    
    
}
