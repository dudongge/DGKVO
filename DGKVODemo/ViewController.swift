//
//  ViewController.swift
//  DGKVODemo
//
//  Created by dudongge on 2018/3/2.
//  Copyright © 2018年 dudongge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView()
        scrollView?.frame = CGRect(x: 20, y: 20, width: self.view.frame.size.width - 40, height: 200)
        scrollView?.backgroundColor = UIColor.blue
        scrollView?.contentSize = CGSize(width: self.view.frame.size.width - 40, height: 800)
        self.view.addSubview(scrollView!)
        weak var ws = self
        scrollView?.observe(self, keyPath: "contentOffset", closure: {
            print("\(ws!.scrollView!.contentOffset.y)")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

