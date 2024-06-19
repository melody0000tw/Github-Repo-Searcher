//
//  SearchBarCell.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/6/19.
//

import UIKit

protocol SearchBarCellDelegate: AnyObject {
    func didTappedSearchBtn(text: String)
}

class SearchBarCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SearchBarCell.self)
    @IBOutlet weak var searchBar: UISearchBar!
    
    weak var delegate: SearchBarCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        searchBar.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SearchBarCell: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            print("empty text")
            return
        }
        delegate?.didTappedSearchBtn(text: text)
        
        print("searchBarTextDidEndEditing: \(String(describing: text))")
        self.searchBar.resignFirstResponder()
    }
}
