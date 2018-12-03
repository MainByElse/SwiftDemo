//
//  ESTabbarViewController.swift
//  SwiftDemo
//
//  Created by Else丶 on 2018/10/4.
//  Copyright © 2018 Else丶. All rights reserved.
//

import UIKit

class ESTabbarViewController: UITabBarController {

    lazy var vc1 : ViewController = ViewController()
    lazy var vc2 : ViewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = false  //避免受默认的半透明色影响，关闭
        self.tabBar.tintColor = UIColor.red //设置文字选中颜色
        self.tabBar.barTintColor = UIColor.white//整个tabbar背景色
        
        vc1.title = "首页"
        vc1.tabBarItem.image = UIImage.init(named: "ic_all_inclusive_24px")
        vc1.tabBarItem.selectedImage = UIImage.init(named: "ic_all_inclusive_48px")
        
        vc2.title = "副页"
        vc2.tabBarItem.image = UIImage.init(named: "ic_all_inclusive_24px")
        vc2.tabBarItem.selectedImage = UIImage.init(named: "ic_all_inclusive_48px")
        
        let nav1 = UINavigationController.init(rootViewController: vc1)
        let nav2 = UINavigationController.init(rootViewController: vc2)
        self.viewControllers = [nav1,nav2]
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
