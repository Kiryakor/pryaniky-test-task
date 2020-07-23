//
//  Model Builder.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMain(router:RouterProtocol) -> UIViewController
    static func createCell(router:RouterProtocol,view: TableViewCell,data:Content)
}

class ModuleBuilder: Builder {
    static func createCell(router: RouterProtocol,view: TableViewCell,data:Content) {
        let presenter = PresenterTableViewCell(view: view, router: router, data: data)
        view.presenter = presenter
    }
    
    static func createMain(router:RouterProtocol) -> UIViewController {
        let view = ViewController()
        let presenter = PresenterView(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
