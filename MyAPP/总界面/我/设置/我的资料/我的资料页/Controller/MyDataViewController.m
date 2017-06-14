//
//  MyDataViewController.m
//  BeautyApp
//
//  Created by zhangming on 17/2/20.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "MyDataViewController.h"
#import "MyStatusViewController.h"
#import "MyDataCell.h"
#import <objc/runtime.h>
//#import <AipOcrSdk/AipOcrSdk.h>
//身份证识别添加AipOcrDelegate。
@interface MyDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIImagePickerControllerSourceType sourceType;
}

@property (weak, nonatomic) UITableView *tableView;

@property (copy , nonatomic) NSArray *titlesArr;
@property (copy , nonatomic) NSArray *titles2Arr;
@property (copy , nonatomic) NSArray *titles3Arr;
@property (copy , nonatomic) NSArray *titles4Arr;

//当前点击cell的index
@property (copy, nonatomic) NSIndexPath *index;

@end

static NSString *CELLID = @"myDataCELL";


@implementation MyDataViewController


- (NSArray *)titles{
    
    if (!_titlesArr) {
        
        _titlesArr = @[@"头像",@"昵称",@"手机号",@"地址",@"我的日常"];
    }
    return _titlesArr;
}

- (NSArray *)titles2{
    
    if (!_titles2Arr) {
        
        _titles2Arr = @[@"性别",@"家乡",@"个性签名",@"身份证识别"];
    }
    
    return _titles2Arr;
}

- (NSArray *)titles3{
    
    
    if (!_titles3Arr) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        NSData *headIm = [ud valueForKey:@"headIm"];
        
        
        NSString *name = [ud valueForKey:@"name"];
        if ([self isBlankString:name]) {
            
            name = @"未设置";
        }
        
        
        NSString *tel = [ud valueForKey:@"tel"];
        if ([self isBlankString:tel]) {
            
            tel = @"未设置";
        }
        
        NSString *adress = [ud valueForKey:@"adress"];
        if ([self isBlankString:adress]) {
            
            adress = @"未设置";
        }
        
        _titles3Arr = @[headIm,name,tel,adress,@""];
    }
    return _titles3Arr;
 }

- (NSArray *)titles4{
    
    if (!_titles4Arr) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSString *gender = [ud valueForKey:@"gender"];
        if ([self isBlankString:gender]) {
            
            gender = @"未设置";
        }
        
        NSString *home = [ud valueForKey:@"home"];
        if ([self isBlankString:home]) {
            
            home = @"未设置";
        }
        
        NSString *motto = [ud valueForKey:@"motto"];
        if ([self isBlankString:motto]) {
            
            motto = @"未设置";
        }
        
        NSString *cdId = [ud valueForKey:@"motto"];
        if ([self isBlankString:cdId]) {
            
            cdId = @"未设置";
        }
        
        _titles4Arr = @[gender,home,motto,cdId];
    }
    return _titles4Arr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavBarWithTitle:@"我的资料"];
    
    [self setupUI];
    
    //[[AipOcrService shardService] authWithAK:@"GTd4dZQVn1KH3aF2pWo32nO0" andSK:@"Zn8dSQhp5rcoNuGjdB2cHYz7N1C3Bvap"];
}

- (void)setupUI{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = TABBGCOLOR;
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.titles.count;
        
    }else{
        
        return self.titles2.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [MyDataCell Height:indexPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyDataCell *cell = [MyDataCell tempTableViewCellWith:tableView indexPath:indexPath];
    [cell reciveInfoWithTitleArr:self.titles andTitlesArr2:self.titles2 andTitlesArr3:self.titles3 andTitlesArr4:self.titles4 andIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _index = indexPath;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            [self goPhoto];
            
        }else if (indexPath.row == 1) {
            
            [self showAlertWithTitle:@"昵称" andStyle:1];
            
        }else if (indexPath.row == 2){
            
            [self showAlertWithTitle:@"手机号" andStyle:1];
            
        }else if (indexPath.row == 3){
            
            [self showAlertWithTitle:@"地址" andStyle:1];
            
        }else {
            
            MyStatusViewController *myStatueVC = [[MyStatusViewController alloc] init];
            [self.navigationController pushViewController:myStatueVC animated:YES];
        }
        
    }else{
        
        if (indexPath.row == 0) {
            
            [self showGenterAlert];
            
            
        }else if (indexPath.row == 1) {
            
            [self showAlertWithTitle:@"家乡" andStyle:1];
        }else if(indexPath.row == 2){
            
            [self showAlertWithTitle:@"个性签名" andStyle:1];
        }else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"打开注释即可真机测试" preferredStyle:UIAlertControllerStyleAlert];
        
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }]];
            [self presentViewController:alert animated:YES completion:^{
                
            }];

            //打开即可真机测试身份证识别,不好使的话查看百度后台key
//            UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont andDelegate:self];
//            [self presentViewController:vc animated:YES completion:nil];
        }
    }

}
#pragma mark - 展示性别Alert
- (void)showGenterAlert{
    
    
    MyDataCell *cell = (MyDataCell *)[self.tableView cellForRowAtIndexPath:_index];
    LXAlertView *alert=[[LXAlertView alloc] initWithGender:@"帅哥/美女" andMsg:@"帅哥" andMsg:@"美女" cancelBtnTitle:nil otherBtnTitle:@"OK" textBlock:^(NSString *text) {
        
        cell.setLa.text = text;
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:text forKey:[NSString stringWithFormat:@"gender"]];
        
    }];
    
    alert.animationStyle=1;
    [alert showLXAlertView];
    
}
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - 选择头像
- (void)goPhoto{
    
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            UIImagePickerController * picker = [[UIImagePickerController alloc]init];
            
            picker.delegate = self;
            
            picker.sourceType=sourceType;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        }else{
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:@"选择图片"
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"拍摄", @"图库",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];
        }
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        
        sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        
        picker.sourceType=sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if (buttonIndex == 1) {
        
        sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.sourceType=sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}

#pragma mark - 相册选择完成
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    MyDataCell *cell = (MyDataCell *)[self.tableView cellForRowAtIndexPath:_index];
    cell.headIm.image = image;
    
    //获取图片的data
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //将获取的data本地保存到plist文件当中
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headIm"];
    
    [self postNotifyWithName:NOTIFY_HEADIM];
}

#pragma mark - 弹出带有textfiled的Alert
- (void)showAlertWithTitle:(NSString *)title andStyle:(NSInteger)style{
    
    MyDataCell *cell = (MyDataCell *)[self.tableView cellForRowAtIndexPath:_index];
    LXAlertView *alert=[[LXAlertView alloc] initWithText:title cancelBtnTitle:nil otherBtnTitle:@"OK" textBlock:^(NSString *text) {
        
        NSLog(@"%@",text);
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
        if (_index.section == 0) {
            
            if (_index.row == 1) {
                
                if (text.length > 0) {
                    cell.setLa.text = text;
                    [ud setObject:text forKey:[NSString stringWithFormat:@"name"]];
                    [self postNotifyWithName:NOTIFY_CHANGENAME];
                }
                
                
            }else if (_index.row == 2){
                
                if (text.length > 0) {
                    cell.setLa.text = text;
                    [ud setObject:text forKey:[NSString stringWithFormat:@"tel"]];
                }
                
                
            }else if (_index.row == 3){
                
                if (text.length > 0) {
                    cell.setLa.text = text;
                    [ud setObject:text forKey:[NSString stringWithFormat:@"adress"]];
                }
                
            }
        }else{
            
            if (_index.row == 1){
                
                if (text.length > 0) {
                    cell.setLa.text = text;
                    [ud setObject:text forKey:[NSString stringWithFormat:@"home"]];
                }
                
            }else if (_index.row == 2){
                
                if (text.length > 0) {
                    cell.setLa.text = text;
                    [ud setObject:text forKey:[NSString stringWithFormat:@"motto"]];
                }
                
            }
        }
        
    }];
    alert.animationStyle=style;
    [alert showLXAlertView];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark AipOcrResultDelegate

- (void)ocrOnIdCardSuccessful:(id)result {
    NSLog(@"%@", result);
    NSString *title = nil;
    NSMutableString *message = [NSMutableString string];
    NSMutableString *cdId = [NSMutableString string];
    if(result[@"words_result"]){
        [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
            [cdId appendFormat:@"%@",key];
            
        }];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        
    }];
}


- (void)ocrOnFail:(NSError *)error {
    NSLog(@"%@", error);
    NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
