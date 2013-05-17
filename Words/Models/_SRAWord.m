// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRAWord.m instead.

#import "_SRAWord.h"

const struct SRAWordAttributes SRAWordAttributes = {
	.content = @"content",
};

const struct SRAWordRelationships SRAWordRelationships = {
	.letter = @"letter",
	.prefix = @"prefix",
};

const struct SRAWordFetchedProperties SRAWordFetchedProperties = {
};

@implementation SRAWordID
@end

@implementation _SRAWord

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SRAWord" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"SRAWord";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SRAWord" inManagedObjectContext:moc_];
}

- (SRAWordID*)objectID {
	return (SRAWordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic content;






@dynamic letter;

	

@dynamic prefix;

	






@end
