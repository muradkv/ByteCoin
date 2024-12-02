//
//  ViewController.swift
//  ByteCoin
//
//  Created by murad on 30.11.2024.
//

import UIKit

class ByteCoinViewController: UIViewController {
    
    //MARK: - Properties
    
    let byteCoinView = ByteCoinView()
    
    override func loadView() {
        view = byteCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

