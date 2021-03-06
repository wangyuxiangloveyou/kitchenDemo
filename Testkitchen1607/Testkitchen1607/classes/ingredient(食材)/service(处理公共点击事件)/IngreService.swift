//
//  IngreService.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreService: NSObject {
    class func handleEvent(urlString:String,onViewController vc:UIViewController){
        if urlString.hasPrefix("app://food_course_series"){
        //食材课程分级显示
            let array = urlString.componentsSeparatedByString("#")

            if array.count>1{
                let courseId=array[1]
                 FoodCourseService.handleFoodCourse(courseId, onViewController: vc)
                
            }
                
            }
        else if urlString.hasPrefix("http://video.szzhangchu.com"){
            //播放视频
            let array=urlString.componentsSeparatedByString("#")
            VideoService.playVideo(array.last, onViewController: vc)
         
        }
    }
}
