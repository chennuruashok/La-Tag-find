//
//  Language.m
//  LaTagV1.0
//
//  Created by Apple on 27/12/13.
//  Copyright (c) 2013 Prakash. All rights reserved.
//

#import "Language.h"
static NSBundle *bundle = nil;
@implementation Language

+(void)initialize {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString *current = [languages objectAtIndex:0];
    if ([current isEqualToString:@"en"]) {
        [self setLanguage:current];
    }
    else if ([current isEqualToString:@"zh-Hans"]){
        
        [self setLanguage:current];
    }
    else{
        [self setLanguage:@"en"];
    }

}
+(void)setLanguage:(NSString *)code {
    NSString *path = [[ NSBundle mainBundle ] pathForResource:code ofType:@"lproj" ];
    // Use bundle = [NSBundle mainBundle] if you
    // dont have all localization files in your project.
    bundle = [NSBundle bundleWithPath:path];
}
+(NSString *)get:(NSString *)key alter:(NSString *)alternate {
    return [bundle localizedStringForKey:key value:alternate table:nil];
}
@end
