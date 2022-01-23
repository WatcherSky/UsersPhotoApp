//
//  ViewController.swift
//  Test App
//
//  Created by Владимир on 19.01.2022.
//

import UIKit

class UsersViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak private var tableView: UITableView!
    private let url = "https://jsonplaceholder.typicode.com/users"
    private var users = [ResultsUsers]()
   
    //MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        setupTableView()
        setupTitle()
    }
    
    //MARK: - Functions
    private func setupTitle() {
        title = "Users"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func getUsers() {
        NetworkManager.shared.getUsersData(urlString: url) { [unowned self] (resultsData) in
            guard let resultsData = resultsData else { return }
            for results in 0..<resultsData.count  {
                self.users.append(resultsData[results])
            }
            tableView.reloadData()
        }
    }
}

//MARK: - Extensions
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumsViewController = AlbumsViewController.instantiateAlbumsVC()
        albumsViewController.id = users[indexPath.row].id
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(albumsViewController, animated: true)
    }
    
}
