//
//  IngreHeaderView.swift
//  Testkitchen1607
//
//  Created by qianfeng on 16/10/27.
//  Copyright © 2016年 zhb. All rights reserved.
//

import UIKit

class IngreHeaderView: UIView {
 var jumpClosure:IngreJumpClourse?
    //数据
    var listModel:IngreRecommendWidgetList?{
        didSet{
            configText((listModel?.title)!)
            print(listModel?.title)
        }
    }
    private var imageView:UIImageView?
  //文字
    private var titleLabel:UILabel?
    //左右的间距
    private var space:CGFloat=40
    //文字和图片的间距
    private var margin:CGFloat=20
    private var  iconW:CGFloat=44
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor=UIColor(white: 0.9, alpha: 1.0)
        let baView=UIView.creatView()
        baView.backgroundColor=UIColor.whiteColor()
        baView.frame=CGRect(x: 0, y: 10, width: bounds.size.width, height: 44)
        addSubview(baView)
        
        //点击事件
        let g=UITapGestureRecognizer(target: self, action: #selector(tapAction))
        baView.addGestureRecognizer(g)
        //文字
        titleLabel=UILabel.creatLabel(nil, textAlignmet:.Center, font: UIFont.systemFontOfSize(18))
        baView.addSubview(titleLabel!)
        
        //图片
        let image=UIImage(named: "more_icon")
        imageView=UIImageView(image:image)
        baView.addSubview(imageView!)
    }
    
   @objc private  func tapAction(){
    if jumpClosure != nil && listModel?.title_link != nil{
        jumpClosure!((listModel?.title_link)!)
    }
        
    }
    //显示文字
   private func configText(text:String){
        //计算文字的宽度
        let str=NSString(string: text)
        /*第一个参数:文字的最大范围
         第二个参数:文字的显示规范
         第三个参数:文字属性
         第四个参数:上下文*/
        let maxw=bounds.size.width-space*2-iconW-margin*2
        let attr=[NSFontAttributeName:UIFont.systemFontOfSize(18)]
        
        
        let w=str.boundingRectWithSize(CGSizeMake(maxw, 44), options: .UsesLineFragmentOrigin, attributes: attr, context: nil).size.width
        
        _=(maxw-w-margin*2-iconW)/2
        
        //设置文字
        titleLabel?.text=text
    
        //修改位置
        titleLabel?.frame=CGRectMake(space, 0, w, 44)
       imageView?.frame=CGRectMake(titleLabel!.frame.origin.x+w+margin, 0, iconW, iconW)
       
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
