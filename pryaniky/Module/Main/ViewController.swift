//
//  ViewController.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

protocol ViewProtocol: class {
    func reload()
    func alert(message:String)
}


class ViewController: UIViewController,ViewProtocol {

    var tableView:UITableView!
    var presenter:PresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.loadData()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func alert(message:String) {
        Alert.baseAlert(message: message, vc: self)
    }
}

extension ViewController{
    func setup(){
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellId)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellId, for: indexPath) as! TableViewCell
        presenter.createCell(indexPath: indexPath, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
