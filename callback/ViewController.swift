//
//  ViewController.swift
//  callback
//
//  Created by mengyun on 2018/2/25.
//  Copyright © 2018年 mengyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, callBackDelegate {
    func callbackDelegatefuc(backMsg: String) {
        self.dataLabel.text = backMsg
        self.activityIndicator.stopAnimating()
        activityIndicator.isHidden = true;
    }
    let request=HttpRequest()
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var asyncButton: UIButton!
    @IBAction func asyncGetData(_ sender: Any) {
        self.dataLabel.text = ""
        activityIndicator.isHidden = false;
        activityIndicator.startAnimating()
        request.processMethod(cmdStr: "startProcess")
    }
    
    @IBOutlet var syncButton: UIButton!
    @IBAction func syncGetData(_ sender: Any) {
        self.dataLabel.text = "" //注意，此行代码实际上没有意义
        let str = syncRequestData(fid: "0225");
        self.dataLabel.text = str;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        request.delegate = self;
        activityIndicator.isHidden=true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

