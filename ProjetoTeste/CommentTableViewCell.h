//
//  CommentTableViewCell.h
//  ProjetoTeste
//
//  Created by Crystian Leao on 05/08/17.
//  Copyright © 2017 Roadmaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
