//
//  DetailViewController.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/7/3.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    var data: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: DetailCell.reuseIdentifier)
        let titleView = TitleView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 80))
        if let data = data {
            titleView.setTitle(data.owner?.login ?? "")
        }
        tableView.tableHeaderView = titleView
        tableView.separatorStyle = .none
    }
    
    @objc private func didTappedBackBtn() {
        navigationController?.popViewController(animated: true)
    }

}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier) as? DetailCell else {
            return UITableViewCell()
        }
        if let data = data {
            cell.setupCell(item: data)
        }
        return cell
    }
    
    
}
