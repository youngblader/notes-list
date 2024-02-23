//
//  NotesTableView.swift
//  NoteX
//
//  Created by Евгений Зорич on 22.02.24.
//

import UIKit

final class NotesTableView: UITableView {
    private var notes: [Note] = []
    
    var onNoteEditTapped: ((Note)->())?
    var onNoteDeleteTapped: ((Note)->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        
        self.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ notes: [Note]) {
        self.notes = notes
        self.reloadData()
    }
}

extension NotesTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let note = notes[indexPath.row]
            self.onNoteDeleteTapped?(note)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let note = notes[indexPath.row]
        
        onNoteEditTapped?(note)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseId) as! NoteCell
        
        let note = notes[indexPath.row]
        
        cell.update(note)
        
        return cell
    }
}
