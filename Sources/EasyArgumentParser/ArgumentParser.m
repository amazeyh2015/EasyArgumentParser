//
//  ArgumentParser.m
//  
//
//  Created by yuhan on 2024/6/19.
//

#import "ArgumentParser.h"

@interface ArgumentParser ()

@property (nonatomic) NSMutableDictionary<NSString *, NSArray<NSString *> *> *stateTable;

@end

@implementation ArgumentParser

- (instancetype)init {
    self = [super init];
    if (self) {
        // inputs: option, other
        _stateTable = [NSMutableDictionary dictionary];
        _stateTable[@"start"] = @[@"option", @"command"];
        _stateTable[@"command"] = @[@"option", @"command"];
        _stateTable[@"option"] = @[@"option", @"value"];
        _stateTable[@"value"] = @[@"option", @"end"];
    }
    return self;
}

- (ArgumentParseResult *)parse:(NSArray<NSString *> *)words {
    ArgumentParseResult *result = [[ArgumentParseResult alloc] init];
    NSString *state = @"start";
    NSMutableArray *commands = [NSMutableArray array];
    NSMutableArray *arguments = [NSMutableArray array];
    for (NSString *word in words) {
        NSInteger index = 1;
        NSString *value = word;
        if ([word hasPrefix:@"--"]) { // option
            index = 0;
            value = [word substringFromIndex:2];
        } else if ([word hasPrefix:@"-"] && word.length == 2) { // option for short
            index = 0;
            value = [word substringFromIndex:1];
        }
        state = self.stateTable[state][index];
        if ([state isEqualToString:@"command"]) {
            [commands addObject:value];
        } else if ([state isEqualToString:@"option"]) {
            [arguments addObject:[NSMutableArray arrayWithObjects:value, @"", nil]];
        } else if ([state isEqualToString:@"value"]) {
            [arguments.lastObject setObject:value atIndex:1];
        } else if ([state isEqualToString:@"end"]) {
            break;
        }
    }
    result.commands = commands;
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    for (NSArray *kv in arguments) {
        temp[kv[0]] = kv[1];
    }
    result.arguments = temp;
    return result;
}

@end
