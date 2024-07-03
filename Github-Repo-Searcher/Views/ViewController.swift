//
//  ViewController.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/6/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl = UIRefreshControl()
    
    var datas: [Item] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: SearchBarCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: SearchBarCell.reuseIdentifier)
        tableView.register(UINib(nibName: RepoCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: RepoCell.reuseIdentifier)
        tableView.addSubview(refreshControl)
        let titleView = TitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 80))
        titleView.setTitle("Repository Search")
        tableView.tableHeaderView = titleView
        refreshControl.addTarget(self, action: #selector(refreshData) , for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    private func presentAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        controller.addAction(okAction)
        present(controller, animated: true, completion: completion)
    }
    
    @objc private func refreshData() {
        print("refreshing...")
        guard let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SearchBarCell,
              let text = cell.searchBar.text
        else { return }
        
        searchRepo(text: text)
    }
    
   private func searchRepo(text: String) {
        guard !text.isEmpty else {
            self.presentAlert(title: "Oops!", message: "The data could't be read because it is missing.") {
                self.refreshControl.endRefreshing()
            }
            return
        }
        print("searching text: \(text)")
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(text)") else {
            print("invalid url")
            refreshControl.endRefreshing()
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let repoResponse = try? JSONDecoder().decode(Repositories.self, from: data) else {
                    print("decode failed")
                    self.refreshControl.endRefreshing()
                    return
                }
                print("decode successed")
                guard let items = repoResponse.items else {
                    print("no items")
                    self.refreshControl.endRefreshing()
                    return
                }
                
                self.datas = items
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = datas[indexPath.row - 1]
        print("selected repo: \(data.fullName!)")
        let detailVC = DetailViewController()
        detailVC.data = data
        navigationController?.pushViewController(detailVC, animated: true)
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

