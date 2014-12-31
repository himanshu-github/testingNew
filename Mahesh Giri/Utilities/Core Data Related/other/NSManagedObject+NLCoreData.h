//
//  NSManagedObject+NLCoreData.h
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

#import <CoreData/CoreData.h>

@interface NSManagedObject (NLCoreData)

/**
 @name Population
 @param dictionary NSDictionary with data to populate object
 */
- (void)populateWithDictionary:(NSDictionary *)dictionary;

/**
 @name Population
 @param dictionary NSDictionary with data to populate object
 @param matchTypes Check for data type match before setting value
 A class can optionally implement +(NSDictionary *)translatePopulationDictionary:(NSMutableDictionary *)dictionary to modify the dictionary before it's sent to this method (e.g., if the server sends "user_id" and your model has a userId, use this to modify the dictionary).
 */
- (void)populateWithDictionary:(NSDictionary *)dictionary matchTypes:(BOOL)matchTypes;

@end
