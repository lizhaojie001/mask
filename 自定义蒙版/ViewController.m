//
//  ViewController.m
//  自定义蒙版
//
//  Created by yanqing on 2017/4/26.
//  Copyright © 2017年 zj. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    /**
     *  图片选择器
     */
    UIImagePickerController * _imagePickerController;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign) int tag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    self.tableView  =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self.view addSubview:self.tableView];
    _imagePickerController = [[UIImagePickerController alloc]init];
    _imagePickerController.delegate = self;
    
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

}


//
//  NXHPersonSetController.m
//  农事无忧
//
//  Created by Mac on 16/9/12.
//  Copyright © 2016年 HBNXWLKJ. All rights reserved.
//

//#import "NXHPersonSetController.h"
#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    
    
    
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    _imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage ];
    
    //视频上传质量
    //UIImagePickerControllerQualityTypeHigh高清
    //UIImagePickerControllerQualityTypeMedium中等质量
    //UIImagePickerControllerQualityTypeLow低质量
    //UIImagePickerControllerQualityType640x480
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    //设置摄像头模式（拍照，录制视频）为录像模式
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    //NSLog(@"相册");
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image =info[@"UIImagePickerControllerEditedImage"];
   // MYLog(@"%@",info);
    if (self.tag > 1) {
        self.tag =0;
    }
    
    switch (self.tag) {
        case 0:
            self.imageView1.image =image;
            break;
        case 1:
       self.imageView3.image =
            self.imageView2.image = image;
            
    }
    self.tag ++;
    
    [_imagePickerController dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView3.bounds;
    UIImage *maskImage =self.imageView1.image;
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    //apply mask to image layer￼
    self.imageView3.layer.mask = maskLayer;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1
    ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",indexPath];
    
    return cell;
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            
            UIAlertController * alter =  [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromCamera];
            }];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self selectImageFromAlbum];
            }];
            UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alter addAction:action1];
            [alter addAction:action2];
            [alter addAction:action3];
            [self presentViewController:alter animated:YES completion:nil];
            
            break;
        }
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    [self alterSetTitle:@"设置姓名"];
                }
                    break;
                case 1:
                    break;
                case 2:
                {
                    break;
                }
                default:
                    
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self alterSetTitle:@"设置地址"];
                    break;
                    
                default:
                {
                 
                }
                    
                    
                    
                    break;
            }
            break;
            
        default:
            switch (indexPath.row) {
                case 0:
                    [self alterSetTitle:@"设置地区"];
                    break;
                    
                default:
                    [self alterSetTitle:@"个性签名"];
                    break;
            }
            break;
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)alterSetTitle:(NSString *)title {
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alter addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }  ];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alter addAction:action1];
    [alter addAction: action2];
    [self presentViewController:alter animated:YES completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
