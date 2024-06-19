//
//  ViewController.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/6/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchBarCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchBarCell.reuseIdentifier)
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarCell.reuseIdentifier) as? SearchBarCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        return cell
    }
}

extension ViewController: SearchBarCellDelegate {
    func didTappedSearchBtn(text: String) {
        searchRepo(text: text)
    }
}

