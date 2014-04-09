//
//  BNRContact.m
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRContact.h"

@interface BNRContact()

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *address;

@end

@implementation BNRContact

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <%@, %@>", self.name, self.phone, self.address];
}

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone address:(NSString *)address
{
    BNRContact *contact = [BNRContact new];
    contact.name = name;
    contact.phone = phone;
    contact.address = address;
    return contact;
}

@end
