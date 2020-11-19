//
//  ViewController.swift
//  Templet
//
//  Created by wl on 2020/11/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        example(of: "initializing a stack from an array literal") {
          var stack: Stack = [1.0, 2.0, 3.0, 4.0]
          print(stack)
          stack.pop()
        }
    }


}

