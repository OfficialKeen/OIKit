//
//  ViewController.swift
//  OIKitPattern
//
//  Created by keenoi on 17/01/24.
//

import UIKit
import OIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemTeal
        
        view.VStack(spacing: 10, distribution: .fillEqually) {
            UIView()
                .background(.red)
            
            UIView()
                .background(.green)
            
            UIView()
                .background(.blue)
        }
    }
}

