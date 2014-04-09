//
//  BNRContactApp.h
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRContact;

@interface BNRContactApp : NSObject

- (void)addContact:(BNRContact *)contact;
- (NSUInteger)numberOfContacts;
- (BNRContact *)contactAtIndex:(NSUInteger)index;
- (void)insertContact:(BNRContact *)contact atIndex:(NSUInteger)index;
- (void)removeContactAtIndex:(NSUInteger)index;

@end
