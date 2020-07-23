//
//  TableViewCell.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

protocol TableViewCellProtocol: class {
    static var cellId: String { get }
    func setupHz(text:String)
    func setupSelector(items:[String])
    func setupPicture(data:Data)
}

class TableViewCell: UITableViewCell, TableViewCellProtocol{
    
    static let cellId = "Cell"
    var cellImageView: UIImageView?
    var selector:UISegmentedControl?
    var presenter:PresenterTableViewCellProtocol!

    func setupHz(text:String){
        self.textLabel?.text = text
        self.textLabel?.textAlignment = .center
    }
    
    func setupSelector(items:[String]){
        selector = UISegmentedControl(items: items)
        selector?.frame = CGRect(x: 10, y: 5, width: frame.width - 20, height: frame.height - 10)
        selector?.selectedSegmentIndex = 0
        selector?.clipsToBounds = true
        addSubview(selector!)
        selector?.addTarget(self, action: #selector(tapSelector), for: .valueChanged)
    }
    
    func setupPicture(data:Data){
        cellImageView = UIImageView()
        cellImageView?.contentMode = .scaleAspectFit
        addSubview(cellImageView!)
        cellImageView?.image = UIImage(data: data)
        //почему-то через frame ячейка улетает в самый низ таблицы
        cellImageView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView!.topAnchor.constraint(equalTo: topAnchor),
            cellImageView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellImageView!.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellImageView!.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc func tapSelector(){
        let activeIndex = selector?.selectedSegmentIndex
        presenter.alertNotification(activeIndex:activeIndex!)
    }
}
