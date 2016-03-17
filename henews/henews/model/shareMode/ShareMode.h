//
//  ShareMode.h
//  henews
//
//  Created by 汪洋 on 16/3/16.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareMode : NSObject

@property (nonatomic, retain) NSString *shareTitle;
@property (nonatomic, retain) NSString *shareUrl;
@property (nonatomic, retain) NSString *shareText;
@property (nonatomic, retain) NSString *shareImage;


- (id)initWithTitle:(NSString *)title text:(NSString *)text url:(NSString *)url image:(NSString *)image;
@end
