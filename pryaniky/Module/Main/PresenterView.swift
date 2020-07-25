//
//  PresenterView.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    init(view:ViewProtocol,router:RouterProtocol)
    func loadData()
    func numberOfRowsInSection() -> Int
    func didSelectRowAt(indexPath:IndexPath)
    func createCell(indexPath:IndexPath,cell:TableViewCell)
    func checkNotification()
    func findDataIndex(index:Int) -> Int
}

class PresenterView: PresenterProtocol {
    
    let view:ViewProtocol
    var data:Main?
    var router:RouterProtocol
    
    required init(view: ViewProtocol,router:RouterProtocol) {
        self.view = view
        self.router = router
        checkNotification()
    }
    
    func loadData() {
        Networking.loadData(URL: URL(string: "https://pryaniky.com/static/json/sample.json")!) { [weak self] (data,response,error)  in
            guard let data = data, error == nil else {
                self?.view.alert(message: "Не удалось подключиться к серверу")
                return
            }
            DispatchQueue.main.async {
                guard let data = try? JSONDecoder().decode(Main.self, from: data) else {
                    self?.view.alert(message: "Не удалось декодровать данные")
                    return
                }
                self?.data = data
                self?.view.reload()
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return data?.view.count ?? 0
    }
    
    func didSelectRowAt(indexPath:IndexPath) {
        let index = findDataIndex(index: indexPath.row)
        view.alert(message: (data?.data[index])!.name)
    }
    
    func createCell(indexPath:IndexPath,cell:TableViewCell){
        let index = findDataIndex(index: indexPath.row)
        ModuleBuilder.createCell(router: router, view: cell, data: (data?.data[index])!)
    }
    
    func checkNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
    
    @objc func showSpinningWheel(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            view.alert(message: dict.allValues[0] as! String)
        }
    }
    
    func findDataIndex(index:Int) -> Int{
        var indexData:Int = -1 
        for i in 0..<(self.data?.data.count)!{
            if self.data?.data[i].name == self.data?.view[index]{
                indexData = i
                break
            }
        }
        return indexData
    }
}
