//
//  CCLabelTTFExtended.m
//
//  Created by Bruno Capezzali on 20/12/12.
//

#import "CCLabelTTFExtended.h"

@implementation CCLabelTTFExtended

+(id)labelExtendedWithString:(NSString*)string dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment
               vertAlignment:(CCVerticalTextAlignment)vertAlignment lineBreakMode:(CCLineBreakMode)lineBreakMode
                    fontName:(NSString*)name fontSize:(CGFloat)size {
    
	return [[[self alloc] initExtendedWithString:string dimensions:dimensions alignment:alignment vertAlignment:vertAlignment lineBreakMode:lineBreakMode fontName:name fontSize:size] autorelease];
}

-(id)initExtendedWithString:(NSString *)str dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment
              vertAlignment:(CCVerticalTextAlignment)vertAlignment lineBreakMode:(CCLineBreakMode)lineBreakMode
                   fontName:(NSString *)name fontSize:(CGFloat)size {
    
    _desiredFontSize = size;
    _shadow = nil; // no shadow for now
    if ( (self = [super initWithString:str dimensions:dimensions hAlignment:alignment vAlignment:vertAlignment lineBreakMode:lineBreakMode fontName:name fontSize:size]) ) {
        
    }
    return self;
}

-(void)setString:(NSString*)str {
    
    fontSize_ = _desiredFontSize * CC_CONTENT_SCALE_FACTOR();
    UIFont *uifont = [UIFont fontWithName:fontName_ size:fontSize_];
    CGSize testLabelSize;
    while ( YES ) {
        /* For finding the correct font size to use we need to simulate the resulting label size.
         * If the size is to wide then we need to make some font size adjustments */
        testLabelSize = [str sizeWithFont:uifont
                        constrainedToSize:CGSizeMake(dimensions_.width, dimensions_.height*2)
                            lineBreakMode:(NSLineBreakMode)lineBreakMode_];
        
        if ( testLabelSize.height <= dimensions_.height ) {
            break;
        }
        
        fontSize_ -= 1.0f;
        uifont = [uifont fontWithSize:fontSize_];
    }
    
    // Notify us if label has changed the font size
    if ( fontSize_ < _desiredFontSize ) {
        CCLOG(@"[CCLabelTTFExtended] Changing font size from %.0f to %.0f",
              _desiredFontSize, fontSize_ / CC_CONTENT_SCALE_FACTOR());
    }
    
    // Found the right font size, now we generate the texture with the correct text
    [super setString:str];

    // If the label has a shadow then we have to update
    if ( _shadow ) {
        [self addShadowWithColor:_shadowColor offset:_shadowOffset];
    }
}

-(void)setString:(NSString *)string withNewDimensions:(CGSize)dimensions {
    
    dimensions_ = CGSizeMake( dimensions.width * CC_CONTENT_SCALE_FACTOR(),
                             dimensions.height * CC_CONTENT_SCALE_FACTOR() );
    [self setString:string];
}

-(void)addShadowWithColor:(ccColor4B)color offset:(CGPoint)offset {
    
    [self removeShadow];
    
    if ( !self.texture ) return; // empty label case
    
    _shadowColor = color;
    _shadowOffset = offset;
    
    _shadow = [CCSprite spriteWithTexture:self.texture];
    [_shadow setColor:ccc3(_shadowColor.r, _shadowColor.g, _shadowColor.b)];
    [_shadow setOpacity:_shadowColor.a];
    [_shadow setPosition:ccp(contentSize_.width*0.5f+_shadowOffset.x,
                            contentSize_.height*0.5f+_shadowOffset.y)];
    [self addChild:_shadow z:-1];
}

-(void)removeShadow {
    
    if ( !_shadow ) return;
    
    [self removeChild:_shadow cleanup:NO];
    _shadow = nil;
}

-(void)setOpacity:(GLubyte)opacity {
    
    [super setOpacity:opacity];
    
    if ( _shadow ) {
        [_shadow setOpacity:opacity];
    }
}

-(void)addDebugBounds {
    
    [self removeChildByTag:1337 cleanup:NO];
    CCLayerColor *back =
    [CCLayerColor layerWithColor:ccc4(200, 0, 60, 80)
                           width:dimensions_.width/CC_CONTENT_SCALE_FACTOR()
                          height:dimensions_.height/CC_CONTENT_SCALE_FACTOR()];
    
    [self addChild:back z:-10 tag:1337];
}

-(void)customizeLikeAppleDefault {
    [self setColor:ccGRAY];
    [self addShadowWithColor:ccc4(255, 255, 255, 255) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeLikeAppleDefaultDarker {
    [self setColor:ccc3(60, 60, 60)];
    [self addShadowWithColor:ccc4(255, 255, 255, 255) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeLikeAppleInverted {
    [self setColor:ccWHITE];
    [self addShadowWithColor:ccc4(128, 128, 128, 200) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeLikeError {
    [self setColor:ccc3(255, 100, 100)]; // rosso chiaro
    [self addShadowWithColor:ccc4(0, 0, 0, 200) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeBlueFont {
    [self setColor:ccc3(78, 138, 217)];
    [self addShadowWithColor:ccc4(0, 0, 0, 200) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeBlackFont {
    [self setColor:ccc3(130, 130, 130)];
    [self addShadowWithColor:ccc4(80, 80, 80, 230) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeWhiteFontBlackShadow {
    [self setColor:ccWHITE];
    [self addShadowWithColor:ccc4(0, 0, 0, 255) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeBlueFontWhiteShadow {
    [self setColor:ccBLUE];
    [self addShadowWithColor:ccc4(255, 255, 255, 255) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeBlueFontBlackShadow {
    [self setColor:ccBLUE];
    [self addShadowWithColor:ccc4(0, 0, 0, 190) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeYellowFont {
    [self setColor:ccc3(212, 148, 9)];
}
-(void)customizeYellowFontBlackShadow {
    [self setColor:ccc3(212, 148, 9)];
    [self addShadowWithColor:ccc4(0, 0, 0, 255) offset:ccp(2.0f, -2.0f)];
}

-(void)customizeYellowFontBlueShadowRemo {
    [self setColor:ccc3(0, 0, 0)];
    [self addShadowWithColor:ccc4(255, 255, 255, 255) offset:ccp(1.0f, -1.0f)];
}

-(void)customizeYellowFontBlueShadow {
    [self setColor:ccc3(255, 255, 11)];
    [self addShadowWithColor:ccc4(0, 0, 255, 255) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeRedFontBlackShadow {
    [self setColor:ccc3(255, 0, 0)];
    [self addShadowWithColor:ccc4(0, 0, 0, 200) offset:ccp(0.0f, -1.0f)];
}

-(void)customizeGreenFontBlackShadow {
    [self setColor:ccc3(26, 113, 3)];
    [self addShadowWithColor:ccc4(0, 0, 0, 200) offset:ccp(0.0f, -1.0f)];
}

@end
