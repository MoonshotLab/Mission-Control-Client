//
//  AttributedTextLabel.m
//  SampleApp
//
//  Created by Alex Goergisn on 19.12.15.
//  Copyright © 2015 Goergisn. All rights reserved.
//

#import "TVCEAttributedText.h"

@implementation TVCEAttributedText

+ (NSString *)name
{
    return @"tvce-attributedText";
}

+ (Class)elementClass
{
    return [TVTextElement class];
}

+ (Class)existingViewClass
{
    return [UILabel class];
}

+ (UIView *)viewForElement:(TVViewElement *)element existingView:(UIView *)existingView
{
    if (![element isKindOfClass:[self elementClass]] || (existingView && ![existingView isKindOfClass:[self existingViewClass]])) {
        return nil;
    }
    
    TVTextElement *textElement = (TVTextElement *)element;
    
    TVViewElementStyle *style = textElement.style;
    
    UILabel * attributedLabel = (UILabel *)existingView;
    if (!attributedLabel) {
        attributedLabel = [UILabel new];
        if (textElement.style.width && textElement.style.height) {
            attributedLabel.frame = CGRectMake(0, 0, style.width, style.height);
        }
    }
    
    attributedLabel.attributedText = textElement.attributedText;
    
    // allow for line breaks
    attributedLabel.lineBreakMode = NSLineBreakByWordWrapping;
    attributedLabel.numberOfLines = 0;
    
    // increase the line height
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:20];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedLabel.attributedText];
    NSRange stringRange = NSMakeRange(0, attributedString.length);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:stringRange];
    attributedLabel.attributedText = attributedString;
    
    [TVCustomStylesController applyCustomStyle:style toView:attributedLabel];
    
    if (style.backgroundColor.color) {
        attributedLabel.backgroundColor = style.backgroundColor.color;
    }
    
    return attributedLabel;

}

@end
