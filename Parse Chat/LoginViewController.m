//
//  LoginViewController.m
//  Parse Chat
//
//  Created by Chizaram Chibueze on 5/30/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.userName.text;
    newUser.password = self.password.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (void)loginUser {
    NSString *username = self.userName.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (BOOL) checkIfEmpty:(NSString *)textString {
    if ([textString isEqual:@""]) {
        return true;
    }else {
        return false;
    }
}

- (IBAction)onSignUp:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Text Required"message:@"Text Field is empty"preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    
    if (![self checkIfEmpty:self.userName.text] || ![self checkIfEmpty:self.password.text]) {
        [self registerUser];
    } else {
        [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    }
}


- (IBAction)loginUser:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Text Required"message:@"Text Field is empty"preferredStyle:(UIAlertControllerStyleAlert)];
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    
    if (![self checkIfEmpty:self.userName.text] || ![self checkIfEmpty:self.password.text]) {
        [self loginUser];
    } else {
        [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    }
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
