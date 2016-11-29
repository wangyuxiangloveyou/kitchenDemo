//
//  FoodCourseDetail.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodCourseDetail: NSObject {
    
    var code:String?
    var data:FoodCourseDetailData?
    var msg:String?
    var timestamp:NSNumber?
    var version:String?
    class func parseData(data:NSData)->FoodCourseDetail{
        let json=JSON(data: data)
        let model=FoodCourseDetail()
        model.code=json["code"].string
        model.data=FoodCourseDetailData.parse(json["data"])
        model.msg=json["msg"].string
        model.timestamp=json["timestamp"].number
        model.version=json["version"].string
        return model
    }
}

class FoodCourseDetailData: NSObject {
    var album:String?
    var album_logo:AnyObject?
    var create_time:String?
    
    var data:[FoodCourseSerial]?
    var episode:NSNumber?
    var last_uqdate:String?
    
    var order_no:String?
    var play:AnyObject?
    var relate_activity:String?
    
    var series_id:String?
    var series_image:String?
    var series_name:String?
    
    var series_title:String?
    var share_description:String?
    var share_image:String?
    
    var share_title:String?
    var share_url:String?
    var tag:String?
    class func parse(json:JSON)->FoodCourseDetailData{
        let model=FoodCourseDetailData()
        
        model.album=json["album"].string
        model.album_logo=json["album_logo"].string
        model.create_time=json["create_time"].string
        
        var array=[FoodCourseSerial]()
        for (_,subjson) in json["data"]{
            let serialModel=FoodCourseSerial.parse(subjson)
            array.append(serialModel)
        }
        model.data=array
        model.episode=json["episode"].number
        model.last_uqdate=json["last_uqdate"].string
        
        model.order_no=json["order_no"].string
        model.play=json["play"].number
        model.relate_activity=json["relate_activity"].string
        
        model.series_id=json["series_id"].string
        model.series_image=json["series_image"].string
        model.series_name=json["series_name"].string
        
        model.series_title=json["series_title"].string
        model.share_description=json["share_description"].string
        model.share_image=json["share_image"].string
        
        model.share_title=json["share_title"].string
        model.share_url=json["share_url"].string
        model.tag=json["tag"].string
        return model
    }
    
}

class FoodCourseSerial: NSObject {
    var course_id:NSNumber?
    var course_image:String?
    var course_introduce:String?
    
    var course_name:String?
    var course_subject:String?
    var course_video:String?
    
    var exisode:NSNumber?
    var is_collect:NSNumber?
    var is_like:NSNumber?
    
    var ischarge:String?
    var price:String?
    var video_watchcount:NSNumber?
    class func parse(json:JSON)->FoodCourseSerial{
        let model=FoodCourseSerial()
        
        model.course_id=json["course_id"].number
        model.course_image=json["course_image"].string
        model.course_introduce=json["course_introduce"].string
        
        model.course_name=json["course_name"].string
        model.course_subject=json["course_subject"].string
        model.course_video=json["course_video"].string
        
        model.exisode=json["exisode"].number
        model.is_collect=json["is_collect"].number
        model.is_like=json["is_like"].number
        
        model.ischarge=json["ischarge"].string
        model.price=json["price"].string
        model.video_watchcount=json["video_watchcount"].number
        
        
        return model
    }
}












