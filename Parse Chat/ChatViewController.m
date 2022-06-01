//
//  ChatViewController.m
//  Parse Chat
//
//  Created by Chizaram Chibueze on 5/31/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>

@interface ChatViewController ()

@property (weak, nonatomic) IBOutlet UITextField *messageField;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onSendMessage:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    chatMessage[@"text"] = self.messageField.text;
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"The message was saved!");
                self.messageField.text = nil;
            } else {
                NSLog(@"Saving the message failed.");
            }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
