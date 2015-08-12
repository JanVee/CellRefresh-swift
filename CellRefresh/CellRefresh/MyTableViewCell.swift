//
//  MyTableViewCell.swift
//  CellRefresh
//
//  Created by apple on 15/8/12.
//  Copyright (c) 2015年 jan. All rights reserved.
//

import UIKit
/**
 * 自定义cell
 */

class MyTableViewCell: UITableViewCell {
    /**
    * 变量定义
    */
    var titleLabel:UILabel?  // 文字
    var imageV:UIImageView?  // 图片

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView()
    {
        //var ti:UILabel?
        //var ti = UILabel(frame: CGRectMake(0, 0, 100, 20))
        
        
        titleLabel = UILabel(frame: CGRectMake(100, 0, 180, 80))
        titleLabel?.textAlignment = NSTextAlignment.Left
        titleLabel?.numberOfLines = 0
        self.addSubview(titleLabel!)
        
        imageV = UIImageView(frame: CGRectMake(15, 10, 60, 60))
        self.addSubview(imageV!)
    }
    
    func loadData(item:Model)
    {
        titleLabel?.text = item.title
        
        // 图片转换
        var thumbQueue = NSOperationQueue()
        var urlString = (item.image as String)
        var url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: thumbQueue, completionHandler: {
        response, data, error in
            if (error != nil){
                println(error)
            }else{
                let image = UIImage.init(data :data)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.imageV?.image = image;
                })
            }
        })
        imageV?.layer.masksToBounds = true
        imageV?.layer.cornerRadius = 16
        imageV?.image = UIImage(named: item.image)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
