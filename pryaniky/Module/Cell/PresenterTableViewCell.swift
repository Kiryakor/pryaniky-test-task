//
//  PresenterTableViewCell.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

protocol PresenterTableViewCellProtocol: class {
    init(view:TableViewCellProtocol,router:RouterProtocol,data:Content)
    func chooseCell()
    func setupDataHz()
    func setupDataSelector()
    func setupDataPicture()
    func alertNotification(activeIndex:Int)
}

class PresenterTableViewCell: PresenterTableViewCellProtocol {
    
    var view:TableViewCellProtocol
    var router:RouterProtocol?
    var data:Content
    
    required init(view: TableViewCellProtocol, router: RouterProtocol,data:Content) {
        self.view = view
        self.router = router
        self.data = data
        chooseCell()
    }
    
    func chooseCell(){
        switch data.name {
        case "hz":
            setupDataHz()
        case "selector":
            setupDataSelector()
        case "picture":
            setupDataPicture()
        default:
            break
        }
    }
    
    func setupDataHz(){
        guard let text = self.data.data.text else { return  }
        view.setupHz(text: text)
    }
    
    func setupDataSelector(){
        var items:[String] = []
        data.data.variants?.forEach({ (element) in
            items.append(element.text)
        })
        view.setupSelector(items: items)
    }
    
    func setupDataPicture(){
        let url = URL(string: (data.data.url)!)
        Networking.loadImage(URL: url!) { [weak self](data) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.view.setupPicture(data: data)
            }
        }
    }
    
    func alertNotification(activeIndex:Int){
        let prepareData = data.data.variants![activeIndex].text
        let info:[String: String] = ["data": prepareData]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: info)
    }
}
