//
//  FoodCourseService.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/11/3.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class FoodCourseService: NSObject {
    class func handleFoodCourse(courseId:String,onViewController vc:UIViewController){
        //跳转食材课程分页
        let ctrl=FoodCourseController()
        ctrl.courseId=courseId
        vc.navigationController?.pushViewController(ctrl, animated: true)
    }
}
