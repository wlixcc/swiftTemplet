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
            var queue = QueueRingBuffer<String>(count: 3)
            queue.enqueue("Ray")
            queue.enqueue("Brian")
            queue.enqueue("Eric")
            print(queue)
            print(queue.dequeue())
            print(queue.peek)

        }
    }


}

