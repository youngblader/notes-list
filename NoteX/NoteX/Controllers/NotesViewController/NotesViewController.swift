//
//  NotesViewController.swift
//  NoteX
//
//  Created by Евгений Зорич on 22.02.24.
//

import UIKit
import SnapKit

final class NotesViewController: UIViewController {
    private let notesViewModel: NotesViewModelProtcol
    
    //MARK: - Views
    private lazy var addNotesButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        
        button.tintColor = .white
        button.backgroundColor = .primary
        
        button.widthAnchor.constraint(equalToConstant: 53).isActive = true
        button.heightAnchor.constraint(equalToConstant: 53).isActive = true
        
        button.layer.cornerRadius = 26
        
        button.addTarget(self, action: #selector(didButtonTapped(sender:)), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    init(notesViewModel: NotesViewModelProtcol) {
        self.notesViewModel = notesViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc private func didButtonTapped(sender: UIButton) {
        sender.showAnimation({})
    }
}

//MARK: - Setup Views
private extension NotesViewController {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(addNotesButton)
    }
    
    func setupConstraints() {
        addNotesButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.right.equalTo(view).inset(20)
        }
    }
}
