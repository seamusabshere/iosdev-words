// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRALetter.m instead.

#import "_SRALetter.h"

const struct SRALetterAttributes SRALetterAttributes = {
	.content = @"content",
};

const struct SRALetterRelationships SRALetterRelationships = {
	.words = @"words",
};

const struct SRALetterFetchedProperties SRALetterFetchedProperties = {
};

@implementation SRALetterID
@end

@implementation _SRALetter

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SRALetter" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SRALetter";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SRALetter" inManagedObjectContext:moc_];
}

- (SRALetterID*)objectID {
	return (SRALetterID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic content;






@dynamic words;

	
- (NSMutableSet*)wordsSet {
	[self willAccessValueForKey:@"words"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"words"];
  
	[self didAccessValueForKey:@"words"];
	return result;
}
	






@end
