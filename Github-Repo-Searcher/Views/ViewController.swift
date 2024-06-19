//
//  ViewController.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/6/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var datas: [Item] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchBarCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchBarCell.reuseIdentifier)
        tableView.register(UINib(nibName: RepoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: RepoCell.reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    
    private func searchRepo(text: String) {
        print("searching text: \(text)")
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(text)") else {
            print("invalid url")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let repoResponse = try? JSONDecoder().decode(Repositories.self, from: data) else {
                    print("decode failed")
                    return
                }
                print("decode successed")
                guard let items = repoResponse.items else {
                    print("no items")
                    return
                }
                
                self.datas = items
                
                for item in items {
                    print(item.fullName ?? "no full name")
                }
               
            }
        }
        task.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarCell.reuseIdentifier) as? SearchBarCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.reuseIdentifier) as? RepoCell else {
            return UITableViewCell()
        }
        let item = datas[indexPath.row - 1]
        cell.setupCell(item: item)
        return cell
        
    }
}

extension ViewController: SearchBarCellDelegate {
    func didEmptyText() {
        datas.removeAll()
    }
    
    func didTappedSearchBtn(text: String) {
        searchRepo(text: text)
    }
}

