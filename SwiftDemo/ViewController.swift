//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Else丶 on 2018/3/31.
//  Copyright © 2018年 Else丶. All rights reserved.
//

import UIKit
import SnapKit
import ZCycleView
import Moya
import SwiftyJSON

class ViewController: UIViewController {

    //代理 将数据传回其他类,可选类型
    weak var delegate: ESViewControllerDelegate?
    //闭包 将第一条数据传递会其他类,可选类型
    var returnModelBlock: ((_ model:ESTableModel) -> Void)?
    
    
    var leftStr = String()
    
    lazy var dataArr = [ESTableModel]()
    
    lazy var tableView : UITableView = UITableView(frame: CGRect.init(x: 0, y: kNavBarHeight, width: ScreenWidth, height: ScreenHeight - kNavBarHeight - kTabbarHeight), style: UITableViewStyle.grouped)
    
    lazy var cycleView : ZCycleView = ZCycleView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: (ScreenWidth-30)*2/5))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.orange
        
        self.setupNav()
        self.setupUI()
    }
    
    //MARK: - UI
    func setupNav() {
        
        let navView : UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: kNavBarHeight))
        navView.backgroundColor = UIColor.white
        
        let leftBtn : UIButton = UIButton(type: UIButtonType.custom)
        if leftStr.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            leftBtn.setTitle(leftStr, for: UIControlState.normal)
        }else{
            leftBtn.setTitle("黄岛区", for: UIControlState.normal)
        }
        leftBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
        leftBtn.titleLabel?.font = UIFont.init(name: "PingFangSC-Regular", size: 15)
        leftBtn.addTarget(self, action: #selector(leftBtnClick), for: UIControlEvents.touchUpInside)
        navView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.left.equalTo(20)
        }
        
        let title : UILabel = UILabel.init()
        title.text = "SwiftDemo"
        title.font = UIFont.boldSystemFont(ofSize: 20)
        navView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerX.equalTo(navView)
            make.centerY.equalTo(leftBtn)
        }
        
        let addbtn : UIButton = UIButton()
        addbtn.setImage(UIImage.init(named: "add_gray"), for: UIControlState.normal)
        addbtn.addTarget(self, action: #selector(addbtnClick), for: UIControlEvents.touchUpInside)
        navView.addSubview(addbtn)
        addbtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navView).offset(10)
            make.right.equalTo(-15)
        }
        
        self.view.addSubview(navView)
    }

    func setupUI() {
        
        self.view.addSubview(tableView)
//        tableView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        tableView.backgroundColor = UIColor.white
//        tableView.separatorColor = UIColor.clear
        tableView.separatorStyle = .none
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        view.addSubview(tableView)
        
        //需要注册cell
        tableView.register(UINib.init(nibName: "YPScrollMenuCell", bundle: nil), forCellReuseIdentifier: "YPScrollMenuCell")
        
        self.getData()
    }
    
    // MARK: - 获取数据
    func getData() {
        ESTableManager.requestData { (flag, resList) in
            if flag{
                self.dataArr = resList!
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - target
    @objc func leftBtnClick() {
        print("leftBtnClick")
        let alert = UIAlertController.init(title: "左加号", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "请输入字符"
        }
        alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.leftStr = alert.textFields?[0].text ?? "黄岛区"
            self.setupNav()
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @objc func addbtnClick() {
        print("addbtnClick")
        
        let actionSheet = UIAlertController.init(title: "右加号", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: "行一", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            print("行一")
            
            self.networkRequest()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "行二", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            print("行二")
        }))
        actionSheet.addAction(UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    //MARK: - 网络请求
    func networkRequest() -> Void {
        
        let provider = MoyaProvider<MoyaApi>()
        provider.request(MoyaApi.Post, callbackQueue: nil, progress: { (response) in
            print("response = \(response)")
        }) { (result) in
            switch result {
            case let .success(result):
                do {
                    try print("result.mapJSON() = \(result.mapJSON())")
                    
                    let data = try JSONSerialization.data(withJSONObject: result.mapJSON(), options: [])
                    let json = try JSON(data: data)
                    print(json["Data"])
                    
                } catch {
                    print("MoyaError.jsonMapping(result) = \(MoyaError.jsonMapping(result))")
                }
            default:
                break
            }
            print("result = \(result.description)")
            let alert = UIAlertController(title: "网络请求", message: "result = \(result.description)", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Sure", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - delegate
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else{
            return self.dataArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell: YPScrollMenuCell = tableView.dequeueReusableCell(withIdentifier: "YPScrollMenuCell") as! YPScrollMenuCell
            return cell
            
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "CellID")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CellID")
            }
            let esModel: ESTableModel = self.dataArr[indexPath.row]
            cell?.textLabel?.text = String.init(format: "cell - %@", esModel.title ?? "无名称")
            cell?.detailTextLabel?.text = esModel.subTitle
            cell?.imageView?.image = UIImage.init(named: esModel.image ?? "占位")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return (ScreenWidth-30)*2/5
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            
            cycleView.placeholderImage = UIImage.init(named: "占位")
            cycleView.itemSize = CGSize.init(width: ScreenWidth-30, height: (ScreenWidth-30)*2/5)
            cycleView.itemSpacing = 5
            cycleView.itemCornerRadius = 5
            cycleView.setUrlsGroup(["http://121.42.156.151:96/2/1/100000/2/0/b74dd2db-64d2-47a1-8374-6333f096ff53.png","http://121.42.156.151:96/2/1/100000/2/0/15757c65-dad0-42e4-8a00-e19683eeee41.png","http://121.42.156.151:96/2/1/100000/2/0/e98cebc6-2a24-4228-bd7f-add2869f604f.png","http://121.42.156.151:96/2/1/100000/2/0/b74dd2db-64d2-47a1-8374-6333f096ff53.png","http://121.42.156.151:96/2/1/100000/2/0/15757c65-dad0-42e4-8a00-e19683eeee41.png"])
            return cycleView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print(String.init(format: "cell - %zd", indexPath.row))
        print("cell - \(indexPath.row)")
    }
}

// MARK: -------------------------- 模型 --------------------------
class ESTableModel: NSObject {
    var title: String?
    var subTitle: String?
    var image: String?
}
// MARK: -------------------------- View-Model --------------------------
class ESTableManager: NSObject {
    class func requestData(response:@escaping(_ flag:Bool,_ resArray: [ESTableModel]?) -> Void){
        //模拟数据
        var resList = [ESTableModel]()
        for i in 0...10 {
            let estm: ESTableModel = ESTableModel()
            estm.title = "\(i) row"
            estm.subTitle = [
                "月光推开窗亲吻脸颊，沁得芬芳轻叩门，敛去湖中婆娑影，拈起肩上落梨花",
                "屋檐下的风轻轻拂过了衣角，弄皱了桌上的画卷，月影疏疏，落花朵朵，不经意间，看成了风景",
                "远处的烟穿过水路，哼着不知名的小调，踏碎了一方的圆月",
                "谁家的酒酿醉了空气中潮湿的时光，睁眼瞬间，藏进了楼阁"
                ][i%4]
            estm.image = ["ic_all_inclusive_24px.jpg","ic_all_inclusive_48px.jpg","add_gray.jpg"][i%3]
            resList.append(estm)
        }
        //回调数据和当前状态
        response(true,resList)
    }
}

// MARK: -------------------------- 协议 --------------------------
@objc protocol ESViewControllerDelegate {
    //默认是必须实现的
    @objc optional func esViewControllerData(model: ESTableModel) -> Void
}
