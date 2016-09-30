//
//  AFNetHelper.h
//  Weather实战
//
//  Created by 樊树康 on 16/9/10.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>

@interface AFNetHelper : NSObject
-(void)setNetWorkHelpercompletionHandler: (void (^) (id))Myblock;
@end
