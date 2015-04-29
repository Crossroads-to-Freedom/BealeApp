//
//  TwitterView.m
//  BealeApp
//
//  Created by Will Cobb on 4/22/15.
//  Copyright (c) 2015 Apprentice Media LLC. All rights reserved.
//

#import "TwitterView.h"

@implementation TwitterView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.delegate = self;
    NSString * html = @"<a class='twitter-timeline' href='https://twitter.com/BealeStApp' data-widget-id='590325474150121472'>Tweets by @BealeStApp</a><script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document,'script','twitter-wjs');</script>";
    [self loadHTMLString:html baseURL:nil];
    NSLog(@"Twitter");
    return self;
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }

    return YES;
}

-(void) hid
{

}

-(void) appeared
{
    NSLog(@"Appeared");
    while (YES) {
        if ([self canGoBack]) {
            NSLog(@"A");
            [self goBack];
        } else {
            NSLog(@"B");
            break;
        }
    }
}

@end
