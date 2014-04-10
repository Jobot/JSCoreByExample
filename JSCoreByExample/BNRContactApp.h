//
//  BNRContactApp.h
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

@import JavaScriptCore;

#import <Foundation/Foundation.h>

@class BNRContact;

@protocol BNRContactAppJS <JSExport>

- (void)addContact:(BNRContact *)contact;

@end

@interface BNRContactApp : NSObject <BNRContactAppJS>

- (NSUInteger)numberOfContacts;
- (BNRContact *)contactAtIndex:(NSUInteger)index;
- (void)insertContact:(BNRContact *)contact atIndex:(NSUInteger)index;
- (void)removeContactAtIndex:(NSUInteger)index;

@end
