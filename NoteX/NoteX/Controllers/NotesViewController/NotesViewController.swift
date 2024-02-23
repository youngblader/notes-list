//
//  NotesViewController.swift
//  NoteX
//
//  Created by Евгений Зорич on 22.02.24.
//

import UIKit
import SnapKit

final class NotesViewController: UIViewController {
    private var viewModel: NotesViewModelProtocol
    
    //MARK: - Views
    private lazy var notesTableView = NotesTableView()
    
    private lazy var addNotesButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        
        button.imageEdgeInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        
        button.widthAnchor.constraint(equalToConstant: 53).isActive = true
        button.heightAnchor.constraint(equalToConstant: 53).isActive = true
        
        button.tintColor = .white
        button.backgroundColor = .primary
        button.layer.cornerRadius = 26
        
        button.addTarget(self, action: #selector(didButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupViews()
        setupConstraints()
        
        notesTableView.onNoteEditTapped = { note in
            self.editNoteItem(note)
        }
        
        notesTableView.onNoteDeleteTapped = { note in
            self.viewModel.removeNoteItem(note)
        }
        
        viewModel.onNoteItemsSaved = { notes in
            self.notesTableView.update(notes)
        }
        
        viewModel.retrieveNoteItems()
    }
    
    init(notesViewModel: NotesViewModelProtocol) {
        self.viewModel = notesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit vc")
    }
    
    private func editNoteItem(_ note: Note) {
        let alert = UIAlertController(title: "Edit your Note", message: "Make it a new name", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.text = note.name
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self.viewModel.editNoteItem(note, text)
            self.viewModel.retrieveNoteItems()
        })
        
        [cancelAction, saveAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addNoteItem() {
        let alert = UIAlertController(title: "Add your Note", message: "Add a new note", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Save", style: .default, handler: { _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self.viewModel.addNoteItem(text)
            self.viewModel.retrieveNoteItems()
        })
        
        [cancelAction, confirmAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @objc private func didButtonTapped(sender: UIButton) {
        sender.showAnimation({
            self.addNoteItem()
        })
    }
}

//MARK: - Setup Views
private extension NotesViewController {
    func setup() {
        self.title = "NoteX"
        view.backgroundColor = .white
    }
    
    func setupViews() {
        view.addSubview(notesTableView)
        view.addSubview(addNotesButton)
    }
    
    func setupConstraints() {
        notesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addNotesButton.snp.makeConstraints { make in
            make.right.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
