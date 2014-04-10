//
//  BNRContactListVC.m
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/7/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRContact.h"
#import "BNRContactApp.h"
#import "BNRContactCell.h"
#import "BNRContactListVC.h"
#import "BNRAddContactWebVC.h"

@interface BNRContactListVC ()

@property (nonatomic) BNRContactApp *app;
@property (nonatomic, readonly) NSString *contactCellID;
@property (nonatomic, readonly) UIColor *backgroundColor;
@property (nonatomic, readonly) UIBarButtonItem *addContactButton;

- (void)addContactButtonPressed;

@end

@implementation BNRContactListVC

@synthesize contactCellID = _contactCellID;
@synthesize backgroundColor = _backgroundColor;
@synthesize addContactButton = _addContactButton;

#pragma mark - Initializers

- (instancetype)initWithApp:(BNRContactApp *)app
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.app = app;
    }
    return self;
}

#pragma mark - Custom Getters and Setters

- (NSString *)contactCellID
{
    if (!_contactCellID) {
        _contactCellID = @"ContactCellID";
    }
    return _contactCellID;
}

- (UIColor *)backgroundColor
{
    if (!_backgroundColor) {
        _backgroundColor = [UIColor colorWithRed:0.1 green:0.8 blue:1.0 alpha:1.0];
    }
    return _backgroundColor;
}

- (UIBarButtonItem *)addContactButton
{
    if (!_addContactButton) {
        _addContactButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContactButtonPressed)];
    }
    return _addContactButton;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"All My Contacts";

    self.navigationController.navigationBar.barTintColor = self.backgroundColor;
    
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem setRightBarButtonItems:@[ self.addContactButton, self.editButtonItem ]];
    
    // register nib for reusable cells
    UINib *cellNib = [UINib nibWithNibName:@"BNRContactCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:self.contactCellID];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.app numberOfContacts];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get the contact
    BNRContact *contact = [self.app contactAtIndex:indexPath.row];
    
    // get a reusable cell
    BNRContactCell *cell = [tableView dequeueReusableCellWithIdentifier:self.contactCellID forIndexPath:indexPath];
    
    // configure the cell
    cell.name.text = contact.name;
    cell.phone.text = contact.phone;
    cell.address.text = contact.address;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    BNRContact *contact = [self.app contactAtIndex:sourceIndexPath.row];
    [self.app removeContactAtIndex:sourceIndexPath.row];
    [self.app insertContact:contact atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.app removeContactAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!editing) {
        NSLog(@"%@", self.app);
    }
}

#pragma mark - Actions

- (void)addContactButtonPressed
{
    NSLog(@"Add Contact Button Pressed");
    BNRAddContactWebVC *webVC = [[BNRAddContactWebVC alloc] initWithNibName:@"BNRAddContactWebVC" bundle:nil];
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
