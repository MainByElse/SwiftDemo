//
//  NetworkTool.swift
//  SwiftDemo
//
//  Created by Else丶 on 2018/10/2.
//  Copyright © 2018 Else丶. All rights reserved.
//

import UIKit
import Moya

let path = String()
//var params: [String : String] = NSDictionary() as! [String : String]

class NetworkTool: NSObject {

}

enum MoyaApi {
    case Post
    case Get
}

//MARK: - 网络请求
extension MoyaApi : TargetType{
    
    var baseURL: URL {
        return URL.init(string: "http://121.42.156.151:52373")!
    }
    
    var path: String {
        switch self {
        case .Post:
            return "/api/HQOAApi/GetBannerList"
        case .Get:
            return self.path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Post:
            return .post
        case .Get:
            return .get
        }
    }
    
    var sampleData: Data {return Data(base64Encoded: "just for test")!}
    var task: Task {
        switch self {
        case .Post:
            return .requestData(try!JSONSerialization.data(withJSONObject: ["BannerType":"3" ,"Code":"1740"], options: [])) //参数放在HttpBody中  jsonToData(jsonDic: ["userName":account  ,"passWord":password])!
            
        case .Get:
            return .requestParameters(parameters: ["BannerType":"3" ,"Code":"1740"], encoding: URLEncoding.default)   //参数放在请求的url中
        }
    } // 请求任务
    
    var headers: [String : String]?{ return ["Content-type" : "application/json","Authorization" : "Basic aHFvYWFwcDAwMjo1YzY0N2Y0YTU1MzNmODA0YTQ2ODYyZWZlM2Q0NTc5Mg=="] }
    
}
