//
//  FXComposeViewController.m
//  12.27  我的微博
//
//  Created by fanxi on 16/2/10.
//  Copyright (c) 2016年 fanxi. All rights reserved.
//

#import "FXComposeViewController.h"
#import "FXTextView.h"
//#import "AFNetworking.h"
#import "FXAccount.h"
#import "FXAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "FXComposetoolbar.h"
#import "FXHttpTool.h"

@interface FXComposeViewController () <FXComposetoolbarDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,weak) FXTextView *textView;
@property (nonatomic,weak) FXComposetoolbar *toolbar;
@property (nonatomic,weak) UIImageView *imageView;

@end

@implementation FXComposeViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    [super viewDidAppear:YES];
    [self.textView becomeFirstResponder];


}

- (void)viewDidLoad
{

    [self setupNavBar];   //设置导航栏属性
    
    [self setupTextView];  // 添加textView
    
    [self setupComposeToolbar];  //添加 toolbar
    
    [self setupImageView];

}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(5, 80, 60, 60);
    [self.textView addSubview:imageView];
    self.imageView = imageView;
  
}

- (void)setupComposeToolbar
{
    FXComposetoolbar *toolbar = [[FXComposetoolbar alloc] init];
   
    CGFloat toolbarH = 44;
    CGFloat toolbarX = 0;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
     toolbar.delegate = self;
    
}

- (void)composeToolbar:(FXComposetoolbar *)toolbar didClickedButton:(FXComposetoolbarButtonType)buttonType
{
    NSLog(@"%d",buttonType);
    
    
    [self openPicture];
   

}


/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
    
   
}

/**
 *  打开相册
 */
- (void)openPicture
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self.navigationController presentViewController:ipc animated:YES completion:nil];
    
//    pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
//    
//}
//pickerImage.delegate = self;
//pickerImage.allowsEditing = NO;


}
/**
 *  图片选择控制器的代理
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    [picker dismissViewControllerAnimated:YES completion:nil];     // 1.销毁picker控制器
    UIImage *image = info[UIImagePickerControllerOriginalImage];   // 1.确定图片
    self.imageView.image = image;

}

- (void)setupNavBar
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";


}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 *  发微博
 */
- (void)send
{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FXAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
    
    [FXHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params  success:^(id jason) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
         [MBProgressHUD showError:@"发送失败"];
    }];
    
    
    if (self.imageView.image) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }

    [self dismissViewControllerAnimated:YES completion:nil];     //关闭控制器
}

- (void)sendWithImage
{

//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [FXAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    NSMutableArray *formDataArray = [NSMutableArray array];
    FXFormData *formData = [[FXFormData alloc] init];
    formData.data = UIImageJPEGRepresentation(self.imageView.image, 0.5);
    formData.name = @"pic";
    formData.mimeType = @"image/jpeg";
    formData.fileName = @"";
    [formDataArray addObject:formData];
    
//    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 1.0);
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
   
    [FXHttpTool postWithURL:@"https://upload.api.weibo.com/2/statuses/upload.json" params:params formDataArray:formDataArray success:^(id jason) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
          [MBProgressHUD showError:@"发送失败"];
    }];

}

- (void)sendWithoutImage
{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = [FXAccountTool account].access_token;
        params[@"status"] = self.textView.text;
    
//        [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            [MBProgressHUD showSuccess:@"发送成功"];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [MBProgressHUD showError:@"发送失败"];
//       }];

  [FXHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id jason) {
       [MBProgressHUD showSuccess:@"发送成功"];
  } failure:^(NSError *error) {
       [MBProgressHUD showError:@"发送失败"];
  }];

}


- (void)setupTextView
{
    FXTextView *textView = [[FXTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事";
//    textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

/**
 *  键盘弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{

     CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
        
    }];
    
    

}

/**
 *  键盘隐藏
 
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];


}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

}

- (void)textDidChange
{

    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);

}

@end
