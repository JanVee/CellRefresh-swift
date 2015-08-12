//
//  ViewController.swift
//  CellRefresh
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 jan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView : UITableView!
    var dataArray : NSMutableArray = []
    var thumbQueue = NSOperationQueue()
    let hackerNewsApiUrl = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "第一个swift版Demo"
        creatTableView()
        loadDataSource()
    }
    
/**********************************************************************************************/
/****** ----------*******-----------我是分割线---------***********------------***************
                ******************************************
                **************--      加载数据        --**************
                ******************************************
        ----------*******----------***********------------*************************************/
/*********************************--我是分割线---************************************************/
    func loadDataSource()
    {
        var loadURL = NSURL(string: hackerNewsApiUrl)
        var request = NSURLRequest(URL: loadURL!)
        
        // 请求线程
        var loadDataSourceQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: loadDataSourceQueue, completionHandler: {response, data, error in
        
            if(error != nil)
            {
                println(error)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                })
                
            }else
            {
                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                
                let newsDataSource = json["item"] as! NSArray
                dispatch_async(dispatch_get_main_queue(), {
                
                
                    self.dataArray = NSMutableArray()
                    // 遍历数组
                    for dict in newsDataSource
                    {
                        var item = Model()
                        item.title = dict["title"] as! String
                        item.image = dict["thumb"] as! String
                        self.dataArray.addObject(item)
                    }
                    // 刷新时间
                    var sendDate = NSDate()
                    var dateformatter = NSDateFormatter()
                    dateformatter.setLocalizedDateFormatFromTemplate("yyyy年MM月dd日 hh:mm:ss")
                    var locationTime = String()
                    locationTime = dateformatter.stringFromDate(sendDate)
                    var title = NSAttributedString(string: "上次刷新时间\(locationTime)")
                    self.refreshControl.attributedTitle = title
                    self.refreshControl.endRefreshing()
                    
                    // 刷新表格
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    
    /**
    * 创建TableView
    */
    func creatTableView()
    {
        self.tableView = UITableView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height-64), style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        view.addSubview(self.tableView)
        
        refreshControl.attributedTitle = NSAttributedString(string: "哥在帮你加载")
        refreshControl.addTarget(self, action: "loadDataSource", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    /**
    * 数据源方法
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.tableView.registerClass(MyTableViewCell.self, forCellReuseIdentifier: "cell")
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        var item = Model()
        item = self.dataArray[indexPath.row] as! Model
        if self.dataArray.count != 0
        {
            cell.loadData(item)
        }
        return cell
    }
    /**
    * cell高度
    */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("点击了row = 第%d行" ,indexPath.row)
        var detailVc = DetailViewController()
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

