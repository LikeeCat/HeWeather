//
//  AFNetHelper.m
//  Weather实战
//
//  Created by 樊树康 on 16/9/10.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//
#define  MapAnalyzeBaseURL  "http://restapi.amap.com/v3/geocode/regeo?"
#define  MapAnalyKey  "&key=e8ba6e7f8fd9699f47affcd525f1f300"
#import "AFNetHelper.h"
@implementation AFNetHelper
-(void)setNetWorkHelpercompletionHandler: ( void (^) (id))Myblock{
   
    
    //创建一个变量接受JSON数据
    //当在block内部使用block外部定义的局部变量时,如果变量没有被__block修饰,则在block内部是readonly(只读的),
    //不能对他修改,如果想修改,变量前必须要有__block修饰
    //__block的作用告诉编译器,编译时在block内部不要把外部变量当做常量使用,还是要当做变量使用.
     // 如果再block中访问全局变量,就不需要__block修饰.
    // __block id JSONData;
    NSURLSession *configuration = [NSURLSessionConfiguration defaultSessionConfiguration ];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];

    
    
    NSString *URLString = @MapAnalyzeBaseURL;
    NSDictionary *paramters = @{@"output":@"JSON",@"location":@"116.310003,39.991957",@"key":@"e8ba6e7f8fd9699f47affcd525f1f300",@"radius":@"1000",@"extensions":@"all"
                                };
    
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]requestWithMethod:@"GET" URLString:URLString parameters:paramters error:nil ];
    
 

    NSURLSessionDataTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error){
            NSLog(@"error");
        }else{
//            NSLog(@"%@",responseObject);
            Myblock(responseObject);
        }
        }
                                
];
    [task resume];
   
}

@end