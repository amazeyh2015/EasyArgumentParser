//
//  ArgumentParseResult.h
//  
//
//  Created by yuhan on 2024/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArgumentParseResult : NSObject

@property (nonatomic, copy) NSArray<NSString *> *commands;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *arguments;

@end

NS_ASSUME_NONNULL_END
