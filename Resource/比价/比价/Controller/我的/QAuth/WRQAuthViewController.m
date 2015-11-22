//
//  WRQAuthViewController.m
//  我的微博
//
//  Created by apple-jd28 on 15/10/21.
//  Copyright © 2015年 apple-jd28. All rights reserved.
//

#import "WRQAuthViewController.h"

#import "WRAccount.h"
#import "WRAccountTool.h"

@interface WRQAuthViewController () <UIWebViewDelegate>

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end

@implementation WRQAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"4148204247";
    NSString *redirect_uri = @"http://www.baidu.com";
    NSString *URLStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    NSURL *URL = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
    webView.delegate = self;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showProgress];
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideProgress];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    
    if (range.length) {
        
        NSString *code = [urlStr substringFromIndex:range.length+range.location];
        [self accessTokenWithCode:code];
        
        return NO;
    }
    return YES;
}

//当发送的请求中截到 coder 把OAuth2/access_token 获取授权过的Access Token
- (void)accessTokenWithCode:(NSString *)code
{
    [WRAccountTool accountWithCode:code completionHandle:^(NSError *error) {
        
        
        
    }];
}

@end
