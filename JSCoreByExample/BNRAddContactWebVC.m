//
//  BNRAddContactWebVC.m
//  JSCoreByExample
//
//  Created by Joseph W. Dixon on 4/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

@import JavaScriptCore;

#import "BNRAddContactWebVC.h"
#import "BNRContact.h"
#import "BNRContactApp.h"

@interface BNRAddContactWebVC () <UIWebViewDelegate>

@property (nonatomic, weak) BNRContactApp *app;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation BNRAddContactWebVC

- (instancetype)initWithApp:(BNRContactApp *)app
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.app = app;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Adding a Contact";
    
    // creat the web view
    CGRect webViewFrame = self.view.bounds;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webViewFrame];
    webView.delegate = self;

    // load the URL
    NSURL *URL = [NSURL URLWithString:@"http://josephwdixon.com/BNR/JSCoreByExample/BNRContactApp.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web View Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // get JSContext from UIWebView instance
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];

    // enable error logging
    [context setExceptionHandler:^(JSContext *context, JSValue *value) {
        NSLog(@"WEB JS: %@", value);
    }];
    
    // give JS a handle to our BNRContactApp instance
    context[@"myApp"] = self.app;
    
    // register BNRContact class
    context[@"BNRContact"] = [BNRContact class];
    
    // add function for processing form submission
    NSString *addContactText =
    @"var contactForm = document.forms[0];"
     "var addContact = function() {"
     "    var name = contactForm.name.value;"
     "    var phone = contactForm.phone.value;"
     "    var address = contactForm.address.value;"
     "    var contact = BNRContact.contactWithNamePhoneAddress(name, phone, address);"
     "    myApp.addContact(contact);"
     "};"
     "contactForm.addEventListener('submit', addContact);";
    [context evaluateScript:addContactText];
}

@end
