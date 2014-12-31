//
//  NSManagedObject+NLCoreData.m
//
//  Created by Jesper Skrufve <jesper@neolo.gy>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import "NSManagedObject+NLCoreData.h"

@interface NSManagedObject (NLCoreData_Private)

@end

#pragma mark -
@implementation NSManagedObject (NLCoreData)

#pragma mark - Lifecycle

- (void)populateWithDictionary:(NSMutableDictionary *)dictionary {
    @try {
        NSSet *nullSet = [dictionary keysOfEntriesWithOptions:NSEnumerationConcurrent passingTest: ^BOOL (id key, id obj, BOOL *stop) {
            return [obj isEqual:[NSNull null]] ? YES : NO;
        }];
        [dictionary removeObjectsForKeys:[nullSet allObjects]];
    }@catch (NSException *exception){}@finally {}
	[self populateWithDictionary:dictionary matchTypes:YES];
}

- (void)populateWithDictionary:(NSDictionary *)dictionary matchTypes:(BOOL)matchTypes {
	NSDictionary *attributes    = [[self entity] attributesByName];
	NSArray *keys               = [attributes allKeys];
	SEL translateSelector       = @selector(translatePopulationDictionary:);
	NSDictionary *arguments;

	if ([[self class] respondsToSelector:translateSelector])
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		arguments = [[self class] performSelector:translateSelector withObject:[NSMutableDictionary dictionaryWithDictionary:dictionary]];
#pragma clang diagnostic pop
	else
		arguments = dictionary;

	for (id key in arguments) {
		if (![keys containsObject:key]) {
#ifdef DEBUG
			NSLog(@"Populating %@, key not found: %@", NSStringFromClass([self class]), key);
#endif
			continue;
		}

		id object                           = [arguments objectForKey:key];
		NSAttributeDescription *description = [attributes objectForKey:key];
		BOOL typeMatch                      = !matchTypes;

		if (!typeMatch)
			switch ([description attributeType]) {
				case NSInteger16AttributeType:
				case NSInteger32AttributeType:
				case NSInteger64AttributeType:
				case NSDecimalAttributeType:
				case NSDoubleAttributeType:
				case NSFloatAttributeType:
				case NSBooleanAttributeType:

					typeMatch = [object isKindOfClass:[NSNumber class]];
					break;

				case NSStringAttributeType:

					typeMatch = [object isKindOfClass:[NSString class]];
					break;

				case NSDateAttributeType:

					typeMatch = [object isKindOfClass:[NSDate class]];
					break;

				case NSBinaryDataAttributeType:

					typeMatch = [object isKindOfClass:[NSData class]];
					break;

				case NSTransformableAttributeType:

					typeMatch = YES;
					break;

				case NSObjectIDAttributeType:
				case NSUndefinedAttributeType:

					typeMatch = NO;
					break;
			}

		if (typeMatch)
			[self setValue:object forKey:key];
	}
}

@end
