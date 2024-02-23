//
//  NoteCell.swift
//  NoteX
//
//  Created by Евгений Зорич on 22.02.24.
//

import UIKit
import SnapKit

final class NoteCell: UITableViewCell {
    static let reuseId = "NoteCell"
    
    private var nameLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ note: Note) {
        let date = note.createdAt ?? Date()
        let dateString = Date.dateFromString(date)
        
        self.nameLabel.text = note.name
        self.dateLabel.text = dateString
    }
}

private extension NoteCell {
    func setupViews() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).inset(5)
            make.left.right.equalTo(contentView).inset(16)
        }
    }
}
