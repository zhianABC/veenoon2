//
//  JHSlideView.m
//  APoster
//
//  Created by chen jack on 13-6-18.
//  Copyright (c) 2013年 chen jack. All rights reserved.
//

#import "JHSlideView.h"

@implementation JHSlideView
@synthesize maxValue;
@synthesize minValue;
@synthesize maxL;
@synthesize _isShowValue;

@synthesize delegate;

- (id) initWithSliderBg:(UIImage*)sliderBg frame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _isShowValue = YES;
        
        _sliderBg = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                            frame.size.height/2,
                                                            frame.size.width-40,
                                                            6)];
        UIImage *img = [UIImage imageNamed:@"progress_bk.png"];
        img = [img stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        _sliderBg.image = img;
        //_sliderBg.layer.contentsGravity = kCAGravityCenter;
        _sliderBg.clipsToBounds = YES;
        [self addSubview:_sliderBg];
        
        _sliderFr = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                  frame.size.height/2,
                                                                  frame.size.width-40,
                                                                  6)];
        img = [UIImage imageNamed:@"process_light.png"];
        img = [img stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        _sliderFr.image = img;
        //_sliderFr.layer.contentsGravity = kCAGravityResizeAspect;
        _sliderFr.center = CGPointMake(_sliderFr.center.x, _sliderBg.center.y);
        [self addSubview:_sliderFr];
        
        _thumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"progress_thumb.png"]];
        [self addSubview:_thumb];
        _thumb.center = CGPointMake(0, _sliderFr.center.y);
        
        
        valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        [self addSubview:valueLabel];
        valueLabel.textColor = [UIColor whiteColor];
        valueLabel.font = [UIFont systemFontOfSize:13];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        
        maxL = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-40,
                                                         0,
                                                         40, frame.size.height)];
        [self addSubview:maxL];
        maxL.textColor = [UIColor whiteColor];
        maxL.font = [UIFont systemFontOfSize:12];
        maxL.textAlignment = NSTextAlignmentRight;
        maxL.text = @"180s";
        
    }
    
    return self;
}

- (void) setRoadImage:(UIImage *)image{
    
   // [slider setMinimumTrackImage:image forState:UIControlStateNormal];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint p = [[touches anyObject] locationInView:self];
    CGRect rc = CGRectMake(0, 0,
                           self.frame.size.width-40,
                           self.frame.size.height);
    
    CGRect rc1 = CGRectMake(0, 0,
                            self.frame.size.width-30,
                            self.frame.size.height);
    
    
    if (CGRectContainsPoint(rc1, p)) {
        
        CGPoint colorPoint = p;
        colorPoint.y = _sliderFr.center.y;
        if(colorPoint.x < 0)
            colorPoint.x = 0;
        if(colorPoint.x > rc.size.width - 0)
            colorPoint.x = rc.size.width - 0;
        _thumb.center = colorPoint;
        
        
        int w = rc.size.width;
        int subw = _thumb.center.x;
        int value = (maxValue - minValue + 1)*(float)subw/w + minValue;
        
        if(value > maxValue)
            value = maxValue;

        // NSLog(@"value = %d", value);
        
        [self sliderValueChanged:value];
    
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint p = [[touches anyObject] locationInView:self];
    CGRect rc = CGRectMake(0, 0,
                           self.frame.size.width-40,
                           self.frame.size.height);
    
    CGRect rc1 = CGRectMake(0, 0,
                           self.frame.size.width-30,
                           self.frame.size.height);
    
    
    if (CGRectContainsPoint(rc1, p)) {
        
        CGPoint colorPoint = p;
        colorPoint.y = _sliderFr.center.y;
        if(colorPoint.x < 0)
            colorPoint.x = 0;
        if(colorPoint.x > rc.size.width - 0)
            colorPoint.x = rc.size.width - 0;
        _thumb.center = colorPoint;
        
        
        int w = rc.size.width;
        int subw = _thumb.center.x;
        int value = (maxValue - minValue + 1)*(float)subw/w + minValue;
        
        // NSLog(@"value = %d", value);
        if(value > maxValue)
            value = maxValue;

        [self sliderValueChanged:value];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
   
    
}

- (void) sliderValueChanged:(int)value{
    
    if(_isShowValue)
    {
        valueLabel.text = [NSString stringWithFormat:@"%ds", value];
        valueLabel.center  = CGPointMake(_thumb.center.x, valueLabel.center.y);
    }
    
    CGRect rc = _sliderFr.frame;
    rc.size.width = _thumb.center.x;
    _sliderFr.frame = rc;
    
    
    if(delegate && [delegate respondsToSelector:@selector(didSlideValueChanged:index:)])
    {
        [delegate didSlideValueChanged:value index:(int)self.tag];
    }
    
}


- (int) getScaleValue{
   
    CGRect rc = CGRectMake(0, 0,
                           self.frame.size.width-40,
                           self.frame.size.height);
    
        int w = rc.size.width;
        int subw = _thumb.center.x;
        int value = (maxValue - minValue + 1)*(float)subw/w + minValue;

    return value;
}


- (void) setScaleValue:(int)value{
    
    CGRect rc = CGRectMake(0, 0,
                           self.frame.size.width-40,
                           self.frame.size.height);
    
    int w = rc.size.width;
    float subw = (value - minValue)*w/(maxValue - minValue + 1);
    
    _thumb.center = CGPointMake(subw, _thumb.center.y);
    
    [self sliderValueChanged:value];
}


- (void) dealloc
{
  
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
