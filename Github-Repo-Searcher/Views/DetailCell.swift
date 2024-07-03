//
//  DetailCell.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/7/3.
//

import UIKit

class DetailCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: DetailCell.self)
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var watcherLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var openIssueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(item: Item) {
        avatarView.loadImage(item.owner?.avatarUrl)
        titleLabel.text = item.fullName
        languageLabel.text = "Written in \(item.language ?? "")"
        starLabel.text = "\(item.stars ?? 0) stars"
        watcherLabel.text = "\(item.watchers ?? 0) watchers"
        forkLabel.text = "\(item.forks ?? 0) forks"
        openIssueLabel.text = "\(item.openIssues ?? 0) open issues"
    }
    
}
