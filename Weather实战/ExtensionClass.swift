//
//  UIImageExtension.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/10.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit
import Alamofire

extension UIImage
{
    
   
  static  func getImageFromInternet(url:String) -> UIImage
  {
    
    let URL = NSURL(string: url)
    let data = NSData(contentsOfURL: URL!)
    
    let image =  UIImage(data: data!)
        return image!
    }
}
extension String
{
    static func transfromChineseToWord(str:String) ->(pinYin:String,firstLetter:String){
       
        
    
        
        let mutableString = NSMutableString(string:str)
        
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        
        CFStringTransform(mutableString, nil,kCFStringTransformStripDiacritics ,false)
        
        let str1 = String(mutableString)
        
        
        let pinYin = str1.capitalizedString
        let  helo = pinYin[pinYin.startIndex.advancedBy(0)]
        
        let firstLetter = String(helo)
        return(pinYin,firstLetter)
    }
}


