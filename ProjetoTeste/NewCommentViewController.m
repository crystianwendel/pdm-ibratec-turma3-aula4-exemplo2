//
//  NewCommentViewController.m
//  ProjetoTeste
//
//  Created by Crystian Leao on 05/08/17.
//  Copyright © 2017 Roadmaps. All rights reserved.
//

#import "NewCommentViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface NewCommentViewController ()

@end

@implementation NewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)enviarClick:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *parameters = @{
        @"comment": @{
            @"user":self.userTxt.text,
            @"content":self.commentTxt.text
            }
        };
    [SVProgressHUD show];
    [manager  POST:@"https://teste-aula-ios.herokuapp.com/comments.json"
        parameters:parameters
           success:^(AFHTTPRequestOperation *operation, id responseObject) {
               [SVProgressHUD dismiss];
               [self.navigationController popViewControllerAnimated:YES];
           }           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [SVProgressHUD dismiss];
               [self.navigationController popViewControllerAnimated:YES];
           }];
}

- (IBAction)cancelarClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
