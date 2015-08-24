//
//  ViewController.h
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *inputView;
- (IBAction)emoji:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *emojiButton;

@end

