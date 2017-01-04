//
//  UISwitch+Night.m
//  UISwitch+Night
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and
//  test it. And finally open a pull request.

#import "UISwitch+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UISwitch ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKColorPicker> *pickers;

@end

@implementation UISwitch (Night)


- (DKColorPicker)dk_onTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_onTintColorPicker));
}

- (void)dk_setOnTintColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_onTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.onTintColor = picker(self.dk_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setOnTintColor:"];
}

- (DKColorPicker)dk_thumbTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_thumbTintColorPicker));
}

- (void)dk_setThumbTintColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_thumbTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.thumbTintColor = picker(self.dk_manager.themeVersion);
    [self.pickers setValue:[picker copy] forKey:@"setThumbTintColor:"];
}


@end
