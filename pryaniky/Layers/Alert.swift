//
//  Alert.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class Alert {
    static func baseAlert(message:String,vc:UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
