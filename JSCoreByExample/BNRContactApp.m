//
//  BNRContactApp.m
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRContactApp.h"
#import "BNRContact.h"

@interface BNRContactApp()

@property (nonatomic) NSMutableArray *contacts;

@end

@implementation BNRContactApp

- (NSMutableArray *)contacts
{
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)addContact:(BNRContact *)contact
{
    if (contact) {
        [self.contacts addObject:contact];
    }
}

- (NSUInteger)numberOfContacts
{
    return [self.contacts count];
}

- (BNRContact *)contactAtIndex:(NSUInteger)index
{
    if (index <= [self.contacts count]) {
        return [self.contacts objectAtIndex:index];
    }
    
    return nil;
}

- (void)insertContact:(BNRContact *)contact atIndex:(NSUInteger)index
{
    if (index <= [self.contacts count]) {
        [self.contacts insertObject:contact atIndex:index];
    }
}

- (void)removeContactAtIndex:(NSUInteger)index
{
    if (index < [self.contacts count]) {
        [self.contacts removeObjectAtIndex:index];
    }
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithString:@"No contacts"];
    
    if ([self.contacts count] > 0) {
        BNRContact *contact = self.contacts[0];
        description = [NSMutableString stringWithFormat:@"Contacts: %@", contact.name];
    }
    
    if ([self.contacts count] > 1) {
        for (NSUInteger index = 1; index < [self.contacts count]; index++) {
            BNRContact *contact = self.contacts[index];
            [description appendString:[NSString stringWithFormat:@", %@", contact.name]];
        }
    }
    
    return description;
}

@end
