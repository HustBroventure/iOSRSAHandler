//
//  ViewController.m
//  iOSRSAHandlerDemo
//
//  Created by wangfeng on 15/10/17.
//  Copyright (c) 2015年 HustBroventure. All rights reserved.
//

#import "ViewController.h"
#import "HBRSAHandler.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UIButton *enBtn;
@property (weak, nonatomic) IBOutlet UIButton *deBtn;
@property (weak, nonatomic) IBOutlet UIButton *sigBtn;
@property (weak, nonatomic) IBOutlet UILabel *result1;

@property (weak, nonatomic) IBOutlet UILabel *result2;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@end

@implementation ViewController
{
    HBRSAHandler* _handler;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    NSString* private_key_string = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALgv/syFH337KzC29KvR0p6cP+glRqjDYAQno5ifafXZjgf1EhBjZblKv+HiLAzNBOlYU1PnLuOOkZj6pg1A5HUZLpsbYa5Mwr1bUHALjXLaB3THCpZX51/b5L14erGo52Jv/j/63YljEtMm8ALmkY8S+3fPxFeY7ya+2VXMEtplAgMBAAECgYAguvauZWGpQ37zUy+7cLfa061PlYAu8TkYw+qAbqOnupdQtq4VF3S2LqBWhZiKVcxvovB70nM0oNsisjfb1xJBpyfDBFug7d+y2f8yr6aTOezoY5DBYEF3Svg9Kp9ra+vvAYX/7fh+tHCU0HOvp0z8ikZiRSWZaQ+3A2GiCIJrwQJBAPKVji89hGAMEWLJJFZaPiLBqZUwR2W/rp7Ely5ddKfjcosHhggHfOb71BnrMOm0h4S85Gx6a87n9R2To0c51q0CQQDCX6yYdt/9JGORyNSXfzMfSZyVOrMpIo77R0YwKa3UOwwLA56l2Lc4AYO10/lyAyZCKse2/5D9ZZUB7xoYEmGZAkB8MEJVPuoY/bSc3RqENrjetERsAwZaObJcx4oaC3AgTxmhwV1FmQfBfKTODBDDZE+Ijedm/ZlZmHhtBtstKJgVAkBKma/DgHRtUscIT90QHBjB3F3FhJb4pbPcyzksCQMXXmY73/LG0ktXqnUjlyy4zm6jnIm0OZgrOQ6chGkubfeZAkBMCGF2tPfEJh8XODOvlw5ADnUiq+Qe/abcpKowkiT9zP+rYT9XJAx7QxChjdwTZb6ahnJY1+ny1emEHUOs2fm8";
    
    
    NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4L/7MhR99+yswtvSr0dKenD/oJUaow2AEJ6OYn2n12Y4H9RIQY2W5Sr/h4iwMzQTpWFNT5y7jjpGY+qYNQOR1GS6bG2GuTMK9W1BwC41y2gd0xwqWV+df2+S9eHqxqOdib/4/+t2JYxLTJvAC5pGPEvt3z8RXmO8mvtlVzBLaZQIDAQAB";
    
    
    NSString *publicKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_public_key.pem" ofType:nil];
    
    NSString *privateKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_private_key.pem" ofType:nil];
    
    HBRSAHandler* handler = [HBRSAHandler new];
        // [handler importKeyWithType:KeyTypePublic andPath:publicKeyFilePath];
        //[handler importKeyWithType:KeyTypePrivate andPath:privateKeyFilePath];
    [handler importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
    [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];
    _handler = handler;
    NSString* sig = [handler signString:@"wangfeng"];
    NSString* sigMd5 = [handler signMD5String:@"wangfeng"];
    NSLog(@"%@      %@",sig,sigMd5);
    
    BOOL isMatch = [handler verifyString:@"wangfeng" withSign:sig];
    BOOL isMatchMd5 = [handler verifyMD5String:@"wangfeng" withSign:sigMd5];
    
    NSLog(@"%d      %d",isMatch,isMatchMd5);

    NSString* enString = [handler encryptWithPublicKey:@"wangfeng"];
    NSString* deString = [handler decryptWithPrivatecKey:enString];
    NSLog(@"%@",deString);
    

    self.result1.adjustsFontSizeToFitWidth = YES;
    
}

- (IBAction)enClick:(id)sender {
    if(self.input.text.length > 0 ){
        NSString* result = [_handler encryptWithPublicKey:self.input.text];
        self.result1.text = result;
    }
}
- (IBAction)signClick:(id)sender {
    if(self.input.text.length > 0 ){
        NSString* result = [_handler signString:self.input.text];
        self.result1.text = result;
    }
}

- (IBAction)deClick:(id)sender {
    if(self.result1.text.length > 0 ){
        NSString* result = [_handler decryptWithPrivatecKey:self.result1.text];
        self.result2.text = result;
    }
}
- (IBAction)verifyClick:(id)sender {
    if(self.result1.text.length > 0  && self.input.text.length > 0){
        BOOL result = [_handler verifyString:self.input.text withSign:self.result1.text];
        self.result2.text = [NSString stringWithFormat:@"验证签名结果(1成功，0失败)： %d",result];
    }
}


@end
