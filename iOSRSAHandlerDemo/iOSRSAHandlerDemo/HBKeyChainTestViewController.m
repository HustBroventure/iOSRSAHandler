//
//  HBKeyChainTestViewController.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 16/6/6.
//  Copyright © 2016年 HustBroventure. All rights reserved.
//

#import "HBKeyChainTestViewController.h"
#import "HBKeyChainWrapper.h"

@interface HBKeyChainTestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITextView *restTextView;
@property (nonatomic, strong) NSMutableString* logString;
@end

NSString* const kKchainChainID = @"kKchainChainID";
@implementation HBKeyChainTestViewController

#pragma mark - vc-life-circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.logString = [[NSMutableString alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - public methords

#pragma mark - private-tools methords
- (void)initData
{
    
}

#pragma mark - event methords

#pragma mark - delegate methords

#pragma mark - property-setter-getter

- (IBAction)add:(id)sender {
   BOOL status = [HBKeyChainWrapper addData:self.textField.text forService:kKchainChainID];
    if (status) {
        NSString* result = [NSString stringWithFormat:@"写入成功；key= %@   value= %@\n",kKchainChainID,self.textField.text];
        [self.logString appendString:result];
        self.restTextView.text = self.logString;
    }else{
        NSLog(@"写入失败； %@   value= %@",kKchainChainID,self.textField.text);
        NSString* result = [NSString stringWithFormat:@"写入失败； %@   value= %@\n",kKchainChainID,self.textField.text];
        [self.logString appendString:result];
        self.restTextView.text = self.logString;
    }
}
- (IBAction)delete:(id)sender {
    BOOL status = [HBKeyChainWrapper deleteDataWithService:kKchainChainID];
    if (status) {
        NSString* result = [NSString stringWithFormat:@"删除成功；key= %@ \n",kKchainChainID];
        [self.logString appendString:result];
        self.restTextView.text = self.logString;

        NSLog(@"删除成功；key= %@ ",kKchainChainID);
    }else{
        NSLog(@"删除失败");
    }
}
- (IBAction)update:(id)sender {
    BOOL status = [HBKeyChainWrapper updateData:self.textField.text forService:kKchainChainID];
    if (status) {
        NSString* result = [NSString stringWithFormat:@"更新成功； %@   value= %@\n",kKchainChainID,self.textField.text];
        [self.logString appendString:result];
        self.restTextView.text = self.logString;
        
    }else{
    }

}
- (IBAction)fetch:(id)sender {
    
    id obj= [HBKeyChainWrapper queryDataWithService:kKchainChainID];
     NSLog(@"%@",obj);
    NSString* result = [NSString stringWithFormat:@"读取成功 key = %@ value = %@ \n",kKchainChainID,obj];
    [self.logString appendString:result];
    self.restTextView.text = self.logString;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
    
}
@end
