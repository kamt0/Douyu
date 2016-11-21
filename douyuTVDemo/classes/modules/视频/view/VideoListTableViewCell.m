//
//  VideoListTableViewCell.m
//  douyuTVDemo
//
//  Created by 揭康伟 on 16/5/27.
//  Copyright © 2016年 kamto. All rights reserved.
//

#import "VideoListTableViewCell.h"

#import "NSString+addition.h"

@interface VideoListTableViewCell ()

@property (nonatomic ,strong) UIImageView *cover_imageView;//图片

@property (nonatomic ,strong) UILabel *titleLable;//标题

@property (nonatomic ,strong) UILabel *video_length;//时长

@property (nonatomic ,strong) UILabel *upload_time;//更新时间

@end

@implementation VideoListTableViewCell

-(void)dealloc{
    
    _upload_time  = nil;
    
    _video_length = nil;
    
    _cover_imageView = nil;
    
    _titleLable = nil;
    
    _Model = nil;
    
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    //初始化控件
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 90);
        
        
        _cover_imageView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        _cover_imageView.tintColor = [UIColor lightGrayColor];
        
        [self addSubview:_cover_imageView];
        
        
        //_titleLable = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, self.frame.size.width - 160, self.frame.size.height - 40)];
        _titleLable = [[UILabel alloc]init];
        _titleLable.numberOfLines = 2;
        
        _titleLable.textAlignment = NSTextAlignmentLeft;
        
        _titleLable.font = [UIFont systemFontOfSize:14];
        
        _titleLable.textColor = [UIColor blackColor];
        
        [self addSubview:_titleLable];
        
        
        _video_length = [[UILabel alloc]init];
        
        _video_length.textAlignment = NSTextAlignmentRight;
        
        _video_length.textColor = [UIColor grayColor];
        
        _video_length.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_video_length];
        
        
        _upload_time = [[UILabel alloc]init];
        
        _upload_time.textAlignment = NSTextAlignmentLeft;
        
        _upload_time.textColor = [UIColor grayColor];
        
        _upload_time.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_upload_time];
        
        //约束
        
        _cover_imageView.sd_layout.topSpaceToView(self,10).leftSpaceToView(self,10).widthIs(100).heightIs(70);
        
        _titleLable.sd_layout.leftSpaceToView(_cover_imageView,10).topSpaceToView(self,20).rightSpaceToView(self,20).autoHeightRatio(0);
        
        _upload_time.sd_layout.leftSpaceToView(_cover_imageView,10).bottomSpaceToView(self,10).heightIs(16);
       
        _video_length.sd_layout.rightSpaceToView(self,30).bottomSpaceToView(self,10).heightIs(16);
        
        
        
    }
    
    return self;
    
}

//设置布局

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
}

//重写set方法

-(void)setModel:(VideoListModel *)Model{
    
    if (_Model != Model) {
        
        _Model = Model;
        
    }
    
    //赋值
    
    [_cover_imageView sd_setImageWithUrl:Model.cover_url placeholderImage:[[UIImage imageNamed:@"imagedefault"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    _titleLable.text = Model.title;
    
    _video_length.text = Model.video_length;
    
    _upload_time.text = Model.upload_time;
    
    //计算titleLable内容所需高度
    CGFloat titleLableHeight = [Model.title textHeight:self.width font:14];
    
    //设置高度
    
    _titleLable.frame = CGRectMake(_titleLable.frame.origin.x , _titleLable.frame.origin.y , _titleLable.frame.size.width , titleLableHeight);
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
