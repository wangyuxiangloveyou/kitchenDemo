//
//  BaseViewController.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/21.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

/*视图控制器的公共父类
 用来封住一些公共的代码
 */

class BaseViewController: UIViewController {
    
    //导航上面添加按钮
    
    func addNavBtn(imageName:String,target:AnyObject?,action:Selector,isLeft:Bool){
        let btn=UIButton.creatBtn(nil, bgImageName: imageName, highlightImageName: nil, selectImageName: nil, target: target, action: action)
        btn.frame=CGRectMake(0, 0, 24, 36)
        let barBtn=UIBarButtonItem(customView: btn)
        if isLeft{
            navigationItem.leftBarButtonItem=barBtn
            
        }else{
            navigationItem.rightBarButtonItem=barBtn
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    view.backgroundColor=UIColor(white: 0.9, alpha: 1.0)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
