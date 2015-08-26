//
//  ViewController.m
//  TBEmojiKeyBoard
//
//  Created by ChenHao on 8/24/15.
//  Copyright (c) 2015 Teambition. All rights reserved.
//

#import "ViewController.h"
#import "TBEmojiKeyboard.h"

@interface ViewController ()

@property (nonatomic, strong) TBEmojiKeyboard *keyboard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    self.keyboard= [[TBEmojiKeyboard alloc] init];
    //[self.view addSubview:self.keyboard];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notif userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    CGRect viewSize = [[UIScreen mainScreen] bounds];
    viewSize.size.height -=keyboardRect.size.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.frame = viewSize;
    }];
    
}

- (void)keyboardShow:(NSNotification *)notif {
  
}

- (void)keyboardWillHide:(NSNotification *)notif {
    NSDictionary* userInfo = [notif userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGRect viewSize = [[UIScreen mainScreen] bounds];
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.view.frame = viewSize;
    }];
}

- (void)keyboardHide:(NSNotification *)notif {
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.inputView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emoji:(id)sender {
    [self.inputView becomeFirstResponder];
    
    [self.inputView switchToEmojiKeyboard:self.keyboard];
//    [self.keyboard showKeyboard];
    [self.emojiButton setAction:@selector(sKeyboard)];
    [self.emojiButton setTitle:@"键盘"];
    
}

- (void)sKeyboard {

    [self.inputView switchToDefaultKeyboard];
    [self.emojiButton setAction:@selector(emoji:)];
    [self.emojiButton setTitle:@"表情"];
}




@end
