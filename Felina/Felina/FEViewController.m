//
//  FEViewController.m
//  Felina
//
//  Created by Sam Bodanis on 08/02/2014.
//  Copyright (c) 2014 Sam Bodanis. All rights reserved.
//

#import "FEViewController.h"

@interface FEViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UILabel *errorMessageLabel;

@end

@implementation FEViewController

@synthesize emailTextField = _emailTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize errorMessageLabel = _errorMessageLabel;

- (UITextField *)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [[UITextField alloc] init];
    }
    return _emailTextField;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
    }
    return _passwordTextField;
}

- (UILabel *)errorMessageLabel {
    if (!_errorMessageLabel) {
        _errorMessageLabel = [[UILabel alloc] init];
    }
    return _errorMessageLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.emailTextField.tag = 0;
    self.emailTextField.delegate = self;
    self.passwordTextField.tag = 1;
    self.passwordTextField.delegate = self;
    
    UITapGestureRecognizer *dismissKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:dismissKeyboard];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSegueWithIdentifier:@"LoginToTabSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailTextField:(id)sender {
}

- (IBAction)passwordTextField:(id)sender {
}

// Cycle text fields
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 0) {
        UITextField *nextTextField = (UITextField*)[self.view viewWithTag:1];
        [nextTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self performSelector:@selector(LoginButtonPressed:) withObject:NULL];
    }
    return NO;
}

- (IBAction)LoginButtonPressed:(id)sender {
    int emailLength = (int)[self.emailTextField.text length];
    int passwordLength = (int)[self.passwordTextField.text length];
    
    if (emailLength > 0 && passwordLength > 0) {
//        BOOL loginWorked = YES;
//        if (loginWorked) {
//            [self performSegueWithIdentifier:@"LoginToTabSegue" sender:self];
//        }
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://ec2-54-194-186-121.eu-west-1.compute.amazonaws.com/"]];

        NSDictionary *params = @{@"email": @"fatsahaj@gmail.com", @"pass": @"assword"};

        [client postPath:@"login" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];

            NSLog(@"operation: %@\nresponse: %@", operation, json);
            if (json[@"res"]) {
                [self performSegueWithIdentifier:@"LoginToTabSegue" sender:self];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"operation: %@\nError%@", operation, error);
        }];
        
    } else {
        NSLog(@"Froyolo");
        if (emailLength == 0) {
            self.errorMessageLabel.text = @"Please enter an email";
        }
        if (passwordLength == 0) {
            self.errorMessageLabel.text = @"Please enter a password";
        }
        if (emailLength == 0 && passwordLength == 0) {
            self.errorMessageLabel.text = @"Please enter an email and password";
        }
        self.errorMessageLabel.alpha = 1;
        [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.errorMessageLabel.alpha = 0;
        } completion:nil];
    }
    
    
}

- (void)dismissKeyboard {
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView resignFirstResponder];
        }
    }
}


@end
