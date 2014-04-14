//
//  CCLabelTTFExtended.h
//
//  Created by Bruno Capezzali on 20/12/12.
//

#import "cocos2d.h"

@interface CCLabelTTFExtended : CCLabelTTF
{    
    CGFloat _desiredFontSize;
    
    // shadow stuff
    CCSprite *_shadow;
    ccColor4B _shadowColor;
    CGPoint _shadowOffset;
}

+(id)labelExtendedWithString:(NSString*)string dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment
               vertAlignment:(CCVerticalTextAlignment)vertAlignment lineBreakMode:(CCLineBreakMode)lineBreakMode
                    fontName:(NSString*)name fontSize:(CGFloat)size;
    
-(id)initExtendedWithString:(NSString *)str dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment
              vertAlignment:(CCVerticalTextAlignment)vertAlignment lineBreakMode:(CCLineBreakMode)lineBreakMode
                   fontName:(NSString *)name fontSize:(CGFloat)size;

-(void)setString:(NSString *)string withNewDimensions:(CGSize)dimensions;

-(void)addShadowWithColor:(ccColor4B)color offset:(CGPoint)offset;
-(void)removeShadow;

-(void)customizeLikeAppleDefault;
-(void)customizeLikeAppleDefaultDarker;
-(void)customizeLikeAppleInverted;
-(void)customizeLikeError;
-(void)customizeBlueFont;
-(void)customizeBlackFont;
-(void)customizeWhiteFontBlackShadow;
-(void)customizeBlueFontWhiteShadow;
-(void)customizeBlueFontBlackShadow;
-(void)customizeYellowFontBlackShadow;
-(void)customizeRedFontBlackShadow;
-(void)customizeGreenFontBlackShadow;
-(void)customizeYellowFontBlueShadow;
-(void)customizeYellowFont;
-(void)customizeYellowFontBlueShadowRemo;

-(void)addDebugBounds;

@end
