//
//  FXOauthViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXOauthViewController.h"
//#import "AFNetworking.h"
#import "FXAccount.h"
#import "FXAccountTool.h"
#import "FXWeiboTool.h"
#import "MBProgressHUD+MJ.h"
//#import "FXHttpTool.h"

@interface FXOauthViewController () <UIWebViewDelegate>

@end

@implementation FXOauthViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *wb = [[UIWebView alloc] init];
    wb.frame = self.view.bounds;
    wb.delegate = self;
    [self.view addSubview:wb];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2497360706&redirect_uri=www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [wb loadRequest:request];
    
    
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        [self accessTokenWithCode:code];
        return NO;
    }
    
            return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"哥正在帮你登陆中···"];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];

}

/*
 请求参数
 必选 	类型及范围 	说明
 client_id 	true 	string 	申请应用时分配的AppKey。
 client_secret 	true 	string 	申请应用时分配的AppSecret。
 grant_type 	true 	string 	请求的类型，填写authorization_code
 
 
 grant_type为authorization_code时
 
 必选 	类型及范围 	说明
 code 	true 	string 	调用authorize获得的code值。
 redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
 
 
 */



- (void)accessTokenWithCode:(NSString *)code
{
   
    // 1.封装请求参数
    FXAccessTokenParam *param = [[FXAccessTokenParam alloc] init];
    param.client_id = @"2497360706";
    param.client_secret = @"ec09eeafa2192e0c6ce935cf48997644";
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = @"http://www.baidu.com";
    
    [FXAccountTool accessTokenWithParam:param success:^(FXAccessTokenResult *result) {
        
        [FXAccountTool saveAccount:result]; //  储存模型数据
        
        [FXWeiboTool chooseRootController]; //  新特性/去首页
        
        [MBProgressHUD hideHUD];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
    }];

    

    
    

    
//    
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    
//    parameters[@"client_id"] = @"2497360706";
//    parameters[@"client_secret"] = @"ec09eeafa2192e0c6ce935cf48997644";
//    parameters[@"grant_type"] = @"authorization_code";
//    parameters[@"code"] = code;
//    parameters[@"redirect_uri"] = @"http://www.baidu.com";
//    
//    
//    [FXHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:parameters success:^(id jason) {
//        FXAccount *account = [FXAccount accountWithDict:jason];
//        [FXAccountTool saveAccount:account];
//        [FXWeiboTool chooseRootController];
//    } failure:^(NSError *error) {
//           [MBProgressHUD hideHUD];
//    }];


}




@end
