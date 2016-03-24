//
//  FXDiscoverViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 15/12/27.
//  Copyright (c) 2015年 fanxi. All rights reserved.
//

#import "FXDiscoverViewController.h"
#import "FXSearchBar.h"


@interface FXDiscoverViewController ()<UITextFieldDelegate>

@property (nonatomic,weak) UITextField *searchBar;

@end

@implementation FXDiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
 
        FXSearchBar *searchBar = [FXSearchBar searchBar];
        searchBar.frame = CGRectMake(0, 0, 300, 30);
        self.navigationItem.titleView = searchBar;
        searchBar.delegate = self;
        self.searchBar = searchBar;
           }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchBar resignFirstResponder];
    return YES;


}





@end
