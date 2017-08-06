//
//  ViewController.m
//  ProjetoTeste
//
//  Created by Siddhartha Freitas on 05/08/17.
//  Copyright © 2017 Roadmaps. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <UIImageView+AFNetworking.h>
#import "CommentTableViewCell.h"
#import <SVProgressHUD.h>

@interface ViewController ()

@property (strong) NSMutableArray *comments;
@property (nonatomic) int page;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.comments = [NSMutableArray arrayWithArray: @[]];
    self.page = 1;
    
    // Isso aqui diz pra o iOS não criar espaços em cima das scrollviews, por causa do navigation bar
    self.automaticallyAdjustsScrollViewInsets = NO;

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self recarregarDados];
}

- (void) recarregarDados {
    self.page = 1;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [SVProgressHUD show];
    [manager GET:@"https://teste-aula-ios.herokuapp.com/comments.json"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [SVProgressHUD dismiss];
             self.comments = [NSMutableArray arrayWithArray:responseObject];
             [self.tableView reloadData];
         }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD dismiss];
             NSLog(@"Error: %@", error);
         }];
}

- (IBAction)recarregar:(id)sender {
    [self recarregarDados];
}

- (IBAction)novoComentario:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *comment = self.comments[indexPath.row];
    cell.userLabel.text = comment[@"user"];
    cell.commentLabel.text = comment[@"content"];
    cell.dataLabel.text = [comment[@"created_at"] substringToIndex:10];
    [cell.m_imageView setImageWithURL:[NSURL URLWithString:comment[@"image"]]
                   placeholderImage:[UIImage imageNamed:@"vangogh"]];
    
    if (indexPath.row == [self.comments count] - 1) {
        // Última célula, tenta carregar mais
        [self carregaProximaPagina];
    }
    
    return cell;
}

- (void) carregaProximaPagina {
    if (self.page == -1)
        return;
    self.page += 1;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:@"https://teste-aula-ios.herokuapp.com/comments.json"
      parameters:@{@"page":@(self.page)}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if ([responseObject count] == 0) {
                 // This will stop pagination from happening
                 self.page = -1;
             } else {
                 [self.comments addObjectsFromArray:responseObject];
                 [self.tableView reloadData];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}


@end
