//
//  BNRContact.h
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRContact : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) NSString *address;

+ (instancetype)contactWithName:(NSString *)name
                          phone:(NSString *)phone
                        address:(NSString *)address;

@end
