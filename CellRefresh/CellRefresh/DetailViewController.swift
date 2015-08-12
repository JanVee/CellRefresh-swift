//
//  DetailViewController.swift
//  CellRefresh
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 jan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIWebViewDelegate {
    
    var detailID = NSInteger()
    var detailURL = "http://qingbin.sinaapp.com/api/html/108035.html"
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        self.title = "详情页面"
        self.webView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height-64)
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        view.addSubview(self.webView)
        
        // 创建返回按钮

        var btn = UIButton()
        btn.frame = CGRectMake(0, 0, 35, 35)
        var image = UIImage(named: "back_btn")
        btn.setBackgroundImage(image, forState: UIControlState.Normal)
        btn.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)
        var itemBtn = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = itemBtn
        
        loadData()
    }
    
    func backAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadData()
    {
        var url = NSURL(string: self.detailURL)
        var urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)
    }
    
    
    
    

}
