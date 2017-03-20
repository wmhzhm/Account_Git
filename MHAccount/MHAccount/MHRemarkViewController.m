//
//  MHRemarkViewController.m
//  MHAccount
//
//  Created by wmh—future on 2017/3/8.
//  Copyright © 2017年 MinghanWu. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS



#import "MHRemarkViewController.h"
#import "MHBill.h"
#import "Const.h"
#import "TMButton.h"
#import "UITextView+Placeholder.h"
#import "MHActionSheetView.h"
#import <Masonry.h>
#import <SVProgressHUD.h>

@interface MHRemarkViewController ()
<
UITextViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 备注内容 */
@property (nonatomic, strong) UITextView *contentTextView;
/** 输入辅助视图,存放camerBtn,limitLabel */
@property (nonatomic, strong) UIView *accessoryView;
/** 相机 */
@property (nonatomic, strong) UIButton *camerBtn;
/** 限制 */
@property (nonatomic, strong) UILabel *limitLabel;
@property (nonatomic, strong) MHActionSheetView *actionSheetView;
/** 显示提示表 default NO */
@property (nonatomic, assign, getter=isDisplayActionSheetView) BOOL displayActionSheetView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
/** 备注 */
@property (nonatomic, strong) NSString *reMarks;
/** 备注图片 */
@property (nonatomic, strong) NSData *photoData;
/** 记录辅助视图需要位移的数 */
@property (nonatomic,assign) CGFloat delta;
@end

@implementation MHRemarkViewController



#pragma mark - 单例

//static id _instance;
//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//    });
//    return _instance;
//}
//+ (instancetype)sharedInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    return _instance;
//}
//- (id)copyWithZone:(NSZone *)zone
//{
//    return _instance;
//}
//- (id)mutableCopyWithZone:(NSZone *)zone {
//    return _instance;
//}
#pragma mark - lazyLoading
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [UIImagePickerController new];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}
//视图左上角灰色时间
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14.0f];
        _timeLabel.textColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        NSMutableString *dateStr = self.bill.dateStr.mutableCopy;
        [dateStr replaceCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
        [dateStr replaceCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
        [dateStr insertString:@"日" atIndex:10];
        _timeLabel.text = dateStr;
    }
    return _timeLabel;
}

//输入框
- (UITextView *)contentTextView{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];

        _contentTextView.delegate = self;
        _contentTextView.font = [UIFont systemFontOfSize:20.0f];
        _contentTextView.placeholder = @"记录花销更记录生活...";
        _contentTextView.placeholderColor = LineColor;

    }
    return _contentTextView;
}

//辅助视图
- (UIView *)accessoryView{
    if (!_accessoryView) {
        _accessoryView = [[UIView alloc] init];
    }
    return _accessoryView;
}

//相机按钮
- (UIButton *)camerBtn{
    if (!_camerBtn) {
        _camerBtn = [[UIButton alloc] init];
        [_camerBtn setBackgroundImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];

        [_camerBtn addTarget:self action:@selector(clickCamerBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _camerBtn;
}

//字数限制Label
- (UILabel *)limitLabel{
    if (!_limitLabel) {
        _limitLabel = [[UILabel alloc] init];
        _limitLabel.textColor = LineColor;
        _limitLabel.text = @"0/40";
    }
    return _limitLabel;
}

//照片弹框
- (MHActionSheetView *)actionSheetView{
    if (!_actionSheetView) {
        _actionSheetView = [[MHActionSheetView alloc] init];
        _actionSheetView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
    }
    return _actionSheetView;
}



#pragma mark - systemMehtod
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delta = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavigationBar];
    [self layoutSubviews];
    [self registerNotification];
    [self actionSheetViewEvent];
    self.displayActionSheetView = NO;
    self.contentTextView.text = self.bill.reMarks;
    self.reMarks = self.bill.reMarks;
    self.photoData = self.bill.remarkPhoto;
    if (self.bill.remarkPhoto) {
        [self.camerBtn setImage:[UIImage imageWithData:self.bill.remarkPhoto] forState:UIControlStateNormal];
    }
    NSLog(@"bill = %@",self.bill);

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.contentTextView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}

- (void)dealloc {
    NSLog(@"good bye MHRemarkViewController");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//注册
- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setUpNavigationBar {
    TMButton *cancelBtn = [[TMButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [cancelBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.title = @"备注";
    
    TMButton *completeBtn = [[TMButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [completeBtn setTitleColor:SystemBlue forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(clickCompletedBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
}

- (void)layoutSubviews {
    WEAKSELF
    
    //左上角时间提示
        [self.view addSubview:self.timeLabel];
        [self.timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 30));
            make.left.equalTo(weakSelf.view).mas_offset(10);
            make.top.mas_equalTo(kMaxNBY);
        }];
 

    //输入框
        [self.view addSubview:self.contentTextView];
        [self.contentTextView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 300));
            make.top.equalTo(weakSelf.timeLabel.bottom);
            make.left.equalTo(weakSelf.timeLabel.left);
        }];
    
    
    //辅助视图
    [self.view addSubview:self.accessoryView];
    [self.accessoryView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 50));
        make.left.bottom.equalTo(weakSelf.view);
    }];
    
    //相机按钮
    [self.accessoryView addSubview:self.camerBtn];
    [self.camerBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(40, 40));
        make.left.equalTo(weakSelf.timeLabel);
        make.bottom.equalTo(weakSelf.accessoryView).offset(-10);
    }];

    //字数限制Label
    [self.accessoryView addSubview:self.limitLabel];
    [self.limitLabel makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(60, 30));
        make.bottom.equalTo(weakSelf.accessoryView).offset(-10);
        make.right.equalTo(weakSelf.accessoryView).offset(-20);
    }];

    //照片弹框View
    [self.view addSubview:self.actionSheetView];
    [self.actionSheetView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 0));
        make.left.bottom.right.equalTo(weakSelf.view);
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Notification Action
- (void)keyboardWillShow:(NSNotification *)noti {
    CGFloat keyboardY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat camerBtnY = CGRectGetMaxY(self.accessoryView.frame);
//    CGFloat delta = camerBtnY - keyboardY;
    self.delta = self.delta + camerBtnY - keyboardY;
    WEAKSELF
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [weakSelf.accessoryView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(-self.delta);
        }];
        //* 立即掉用layoutSubviews */
        [weakSelf.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide {
    WEAKSELF
    self.delta = 0;
    [self.accessoryView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view);
        //* 立即掉用layoutSubviews */
        [weakSelf.view layoutIfNeeded];
    }];
}


#pragma mark - action

/** 提示视图的事件 */
- (void)actionSheetViewEvent {
    WEAKSELF
    _actionSheetView.cancelBtnBlock = ^ {
        [weakSelf.actionSheetView updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 0));
        }];
        //* 立即掉用layoutSubviews */
        [weakSelf.view layoutIfNeeded];
        [weakSelf.contentTextView becomeFirstResponder];
        weakSelf.view.backgroundColor = [UIColor whiteColor];
        weakSelf.contentTextView.backgroundColor = [UIColor whiteColor];
        weakSelf.displayActionSheetView = NO;
    };
    
    _actionSheetView.albumBtnBlock = ^ {
        [weakSelf readPhoto];
    };
    
    _actionSheetView.camerBtnBlock = ^ {
        [weakSelf camera];
    };
}
- (void)camera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //  相机的调用为照相模式
        self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //  设置为NO则隐藏了拍照按钮
        self.imagePicker.showsCameraControls = YES;
        //  设置相机摄像头默认为前置
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //  设置相机闪光灯开关
        self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        /**
         * 如果相机是英文
         *  设置info.plist Localized resources can be mixed = YES;
         */
    } else {
        [self showSVProgressHUD:@"当前设备不支持相机调用"];
    }
    
}
/** 读取相册 */
- (void)readPhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}
//点击拍照按钮
- (void)clickCamerBtn:(UIButton *)sender {
    WEAKSELF
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5f animations:^{
        [weakSelf.actionSheetView updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 180));
        }];
        //* 立即掉用layoutSubviews */
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
        weakSelf.contentTextView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
        weakSelf.displayActionSheetView = YES;
    }];
}

//点击返回箭头
- (void)cancelBtn:(UIButton *)sender {
    [self.contentTextView resignFirstResponder];
    if (self.contentTextView.text.length>40) {
        [self showSVProgressHUD:@"备注超过最大字数"];
        return;
    }
    WEAKSELF
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.passbackBlock) {
            weakSelf.passbackBlock(weakSelf.reMarks,weakSelf.photoData);
        }
    }];
}
//点击完成按钮
- (void)clickCompletedBtn:(TMButton *)sender {
    [self.contentTextView resignFirstResponder];
    [self cancelBtn:sender];
}

#pragma mark - UIImagePickerControllerDelegate
//* 选择好image后做什么 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self.camerBtn setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    NSData *imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.8);
    self.photoData = imageData;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"text = %@",textView.text);
    self.reMarks = textView.text;
    self.limitLabel.text = [NSString stringWithFormat:@"%lu/40",(unsigned long)textView.text.length];
    if (textView.text.length>40) {
        self.limitLabel.textColor = [UIColor redColor];
    } else {
        self.limitLabel.textColor = LineColor;
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.isDisplayActionSheetView) {
        self.displayActionSheetView = NO;
        [self.actionSheetView updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 0));
        }];
        //* 立即掉用layoutSubviews */
        [self.view layoutIfNeeded];
        self.view.backgroundColor = [UIColor whiteColor];
        self.contentTextView.backgroundColor = [UIColor whiteColor];
    }
    return YES;
}


#pragma mark - SVProgressHUD
- (void)showSVProgressHUD:(NSString *)text {
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD showImage:nil status:text];
    //    [SVProgressHUD setMinimumSize:CGSizeMake(100, 60)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:18]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
@end
