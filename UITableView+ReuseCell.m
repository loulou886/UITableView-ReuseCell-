//
//  UITableView+ReuseCell.m
//
//  Created by chenlu on 2018/3/1.
//

#import "UITableView+ReuseCell.h"

@implementation UITableView(ReuseCell)

+ (void)load {
    Method orgM = class_getInstanceMethod([self class], @selector(dequeueReusableCellWithIdentifier:));
    Method swizzleM = class_getInstanceMethod([self class], @selector(cl_dequeueReusableCellWithIdentifier:));
    method_exchangeImplementations(orgM, swizzleM);
}

- (UITableViewCell *)cl_dequeueReusableCellWithIdentifier:(NSString *)identifier {
    UITableViewCell* cell = [self cl_dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
        cell = [self cl_dequeueReusableCellWithIdentifier:identifier];
    }
    return cell;
}

@end
