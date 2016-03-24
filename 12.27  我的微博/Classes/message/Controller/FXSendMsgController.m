//
//  FXSendMsgController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/1/15.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXSendMsgController.h"

@interface FXSendMsgController ()
//@property (nonatomic,weak) UIButton *btn;

@end

@implementation FXSendMsgController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor redColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 100, 30)];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
//        btn.backgroundColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(quitSendMsg) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)quitSendMsg
{
  [self dismissViewControllerAnimated:YES completion:^{
      
  }];


}

@end
