//
//  Language.h
//  LaTagV1.0
//
//  Created by Apple on 27/12/13.
//  Copyright (c) 2013 Prakash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject
+(void)initialize ;
+(void)setLanguage:(NSString *)code;
+(NSString *)get:(NSString *)key alter:(NSString *)alternate;

@end
