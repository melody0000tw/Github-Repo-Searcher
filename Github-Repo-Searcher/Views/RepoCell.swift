//
//  RepoCell.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/6/19.
//

import UIKit

class RepoCell: UITableViewCell {
    static let reuseIdentifier = String(describing: RepoCell.self)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        avatarView.layer.cornerRadius = 50
        // Initialization code
    }
    
    func setupCell(item: Item) {
        titleLabel.text = item.fullName
        descriptionLabel.text = item.description
        avatarView.loadImage(item.owner?.avatarUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
