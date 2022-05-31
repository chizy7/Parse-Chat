//
//  ChatViewController.m
//  Parse Chat
//
//  Created by Chizaram Chibueze on 5/31/22.
//

#import "ChatViewController.h"
#import <Parse/Parse.h>

@interface ChatViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *allMessages;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
}

- (void)onTimer {
    PFQuery *query = [PFQuery queryWithClassName:@"Message_FBU2021"];
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        if (messages != nil) {
            // do something with the array of object returned by the call
            self.allMessages = messages;
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (IBAction)sendButtonTapped:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_FBU2021"];
    // Use the name of your outlet to get the text the user typed
        chatMessage[@"text"] = self.messageField.text;

    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (succeeded) {
                NSLog(@"The message was saved!");
            } else {
                NSLog(@"Problem saving message: %@", error.localizedDescription);
            }
        }];
}

// 1) numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO: Configure to return number of rows for the chat messages
    return 0;
}

// 2) cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Update to configure and return a custom cell
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
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
