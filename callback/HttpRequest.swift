//
//  HttpRequest.swift
//  callback
//
//  Created by mengyun on 2018/2/25.
//  Copyright © 2018年 mengyun. All rights reserved.
//

import Foundation
import UIKit

let host = "http://111.231.221.195"

//定义协议
protocol callBackDelegate {
    func callbackDelegatefuc(backMsg:String)
}
class HttpRequest: NSObject{
    //定义一个符合协议的代理对象
    var delegate:callBackDelegate?
    func processMethod(cmdStr:String?){
        DispatchQueue.global().async {
            let _ = self.getData(fid: "0225")
        }
    }
    
    func getData(fid: String){
        var xmlData:String = "error"
        let urlString = "\(host)/getMusicXmlData.php?file=\(fid)"
        print("urlstring is:",urlString)
        let url: URL = URL(string: urlString)!
        let request:NSURLRequest=NSURLRequest(url: url)
        //drawerVC.startAnimation()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest,completionHandler: {(data, response, error) ->Void in
            if error != nil {
                xmlData = "request failed;"
            }else{
                xmlData = String(data:data! ,encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                
            }
            if((self.delegate) != nil){
                DispatchQueue.main.async {
                    self.delegate?.callbackDelegatefuc(backMsg: xmlData)
                }
            }
        })as URLSessionTask
        dataTask.resume()
        return
    }
}

func syncRequestData(fid: String)->String?{
    var xmlData:String = "error"
    let semaphore = DispatchSemaphore(value: 0)
    let urlString = "\(host)/getMusicXmlData.php?file=\(fid)"
    print("urlstring is:",urlString)
    let url: URL = URL(string: urlString)!
    let request:NSURLRequest=NSURLRequest(url: url)
    //drawerVC.startAnimation()
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest,completionHandler: {(data, response, error) ->Void in
        if error != nil {
            semaphore.signal()
        }else{
            xmlData = String(data:data! ,encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            semaphore.signal()
        }
    })as URLSessionTask
    dataTask.resume()
    let waitTime = DispatchTime.now() + .seconds(88)
    _ = semaphore.wait(timeout: waitTime)
    //_ = semaphore.wait(timeout: DispatchTime.distantFuture)
    return xmlData
}


// 另一种回调实现方式：block
//class ProcessDataUseBlock: NSObject{
//    //定义block
//    typealias fucBlock = (_ backMsg :String) ->()
//    //创建block变量
//    var blockproerty:fucBlock!
//
//    func processMethod(cmdStr:String?){
//        if let _ = blockproerty{
//            blockproerty("backMsg---by block property")
//        }
//    }
//}

