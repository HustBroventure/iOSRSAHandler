
## 介绍

iOS下使用openssl的加密解密签名和验证的封装代码。

### 使用
1.导入openssl和本项目的类文件



2.使用示例

```
NSString* private_key_string = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBALgv/syFH337KzC29KvR0p6cP+glRqjDYAQno5ifafXZjgf1EhBjZblKv+HiLAzNBOlYU1PnLuOOkZj6pg1A5HUZLpsbYa5Mwr1bUHALjXLaB3THCpZX51/b5L14erGo52Jv/j/63YljEtMm8ALmkY8S+3fPxFeY7ya+2VXMEtplAgMBAAECgYAguvauZWGpQ37zUy+7cLfa061PlYAu8TkYw+qAbqOnupdQtq4VF3S2LqBWhZiKVcxvovB70nM0oNsisjfb1xJBpyfDBFug7d+y2f8yr6aTOezoY5DBYEF3Svg9Kp9ra+vvAYX/7fh+tHCU0HOvp0z8ikZiRSWZaQ+3A2GiCIJrwQJBAPKVji89hGAMEWLJJFZaPiLBqZUwR2W/rp7Ely5ddKfjcosHhggHfOb71BnrMOm0h4S85Gx6a87n9R2To0c51q0CQQDCX6yYdt/9JGORyNSXfzMfSZyVOrMpIo77R0YwKa3UOwwLA56l2Lc4AYO10/lyAyZCKse2/5D9ZZUB7xoYEmGZAkB8MEJVPuoY/bSc3RqENrjetERsAwZaObJcx4oaC3AgTxmhwV1FmQfBfKTODBDDZE+Ijedm/ZlZmHhtBtstKJgVAkBKma/DgHRtUscIT90QHBjB3F3FhJb4pbPcyzksCQMXXmY73/LG0ktXqnUjlyy4zm6jnIm0OZgrOQ6chGkubfeZAkBMCGF2tPfEJh8XODOvlw5ADnUiq+Qe/abcpKowkiT9zP+rYT9XJAx7QxChjdwTZb6ahnJY1+ny1emEHUOs2fm8";
   
   
   NSString* public_key_string = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4L/7MhR99+yswtvSr0dKenD/oJUaow2AEJ6OYn2n12Y4H9RIQY2W5Sr/h4iwMzQTpWFNT5y7jjpGY+qYNQOR1GS6bG2GuTMK9W1BwC41y2gd0xwqWV+df2+S9eHqxqOdib/4/+t2JYxLTJvAC5pGPEvt3z8RXmO8mvtlVzBLaZQIDAQAB";
   
   
   NSString *publicKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_public_key.pem" ofType:nil];
   
   NSString *privateKeyFilePath = [[NSBundle mainBundle] pathForResource:@"rsa_private_key.pem" ofType:nil];
   
   
HBRSAHandler* handler = [HBRSAHandler new];

//两种方式导入

// [handler importKeyWithType:KeyTypePublic andPath:publicKeyFilePath];
       //[handler importKeyWithType:KeyTypePrivate andPath:privateKeyFilePath];
   [handler importKeyWithType:KeyTypePrivate andkeyString:private_key_string];
   [handler importKeyWithType:KeyTypePublic andkeyString:public_key_string];

   NSString* sig = [handler signString:@"签名字符串"];
   NSString* sigMd5 = [handler signMD5String:@"签名字符串"];
   NSLog(@"%@      %@",sig,sigMd5);
   
   BOOL isMatch = [handler verifyString:@"签名字符串" withSign:sig];
   BOOL isMatchMd5 = [handler verifyMD5String:@"签名字符串    
   NSLog(@"%d      %d",isMatch,isMatchMd5);

   NSString* enString = [handler encryptWithPublicKey:@"加密字符串"];
   NSString* deString = [handler decryptWithPrivatecKey:enString];
   NSLog(@"%@",deString);
```



### 注意


如果使用字符串形式的私钥，要使用openssl pkcs8 -topk8 -inform PEM -in private_rsa.pem -outform PEM -nocrypt -out private_rsa_pkcs8.pem  转化，取转化后的pem中的私钥字符串。（后边一定要加-out XXX.pem将转换后的私钥保存在XXX.pem，不然得到的结果要设置密码且显示在终端中，这个和得到pem中的私钥有差异。）
###  结果示例
![image](https://raw.githubusercontent.com/HustBroventure/iOSRSAHandler/master/1.png)
![image](https://raw.githubusercontent.com/HustBroventure/iOSRSAHandler/master/2.png)