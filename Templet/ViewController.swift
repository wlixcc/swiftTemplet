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
        example(of: "using collection") {
            
          var list = LinkedList<Int>()
            list.append(1)
            list.append(2)
            list.append(3)
            list.append(4)
            var list2 = list
            
            list2.remove(after: list.node(at: 1)!)
            print(list2)
          
        }
    }


}

