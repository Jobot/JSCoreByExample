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
#import "BNRContactListHeader.h"
#import "BNRContactListVC.h"

@interface BNRContactListVC ()

@property (nonatomic) BNRContactApp *app;
@property (nonatomic, readonly) NSString *contactCellID;
@property (nonatomic, readonly) UIColor *backgroundColor;

- (void)editContactsButtonPressed:(UIButton *)sender;
- (void)addContactButtonPressed;

@end

@implementation BNRContactListVC

@synthesize contactCellID = _contactCellID;
@synthesize backgroundColor = _backgroundColor;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // pretty up the view
    self.tableView.backgroundColor = self.backgroundColor;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 61;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"BNRContactListHeader" owner:self options:nil];
    BNRContactListHeader *header = [views objectAtIndex:0];
    header.backgroundColor = self.backgroundColor;
    [header.editContactButton addTarget:self action:@selector(editContactsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [header.addContactButton addTarget:self action:@selector(addContactButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    return header;
}

#pragma mark - Actions

- (void)editContactsButtonPressed:(UIButton *)sender
{
    [self setEditing:!self.editing animated:YES];
    
    if (self.editing) {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
    }
    
    NSLog(@"%@", self.app);
}

- (void)addContactButtonPressed
{
    NSLog(@"Add Contact Button Pressed");
}

@end
