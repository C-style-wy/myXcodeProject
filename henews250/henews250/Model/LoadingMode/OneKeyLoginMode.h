//
//  OneKeyLoginMode.h
//  henews250
//
//  Created by 汪洋 on 2016/10/21.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "BaseMode.h"

@interface OneKeyLoginMode : BaseMode

@property (copy, nonatomic) NSString *isSmsLogin;
@property (copy, nonatomic) NSString *chinaMobile;
@property (copy, nonatomic) NSString *chinaNet;
@property (copy, nonatomic) NSString *chinaUnicom;

@end
