// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SRAWord.h instead.

#import <CoreData/CoreData.h>


extern const struct SRAWordAttributes {
	__unsafe_unretained NSString *content;
} SRAWordAttributes;

extern const struct SRAWordRelationships {
	__unsafe_unretained NSString *letter;
	__unsafe_unretained NSString *prefix;
} SRAWordRelationships;

extern const struct SRAWordFetchedProperties {
} SRAWordFetchedProperties;

@class SRALetter;
@class SRAPrefix;



@interface SRAWordID : NSManagedObjectID {}
@end

@interface _SRAWord : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SRAWordID*)objectID;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) SRALetter *letter;

//- (BOOL)validateLetter:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) SRAPrefix *prefix;

//- (BOOL)validatePrefix:(id*)value_ error:(NSError**)error_;





@end

@interface _SRAWord (CoreDataGeneratedAccessors)

@end

@interface _SRAWord (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;





- (SRALetter*)primitiveLetter;
- (void)setPrimitiveLetter:(SRALetter*)value;



- (SRAPrefix*)primitivePrefix;
- (void)setPrimitivePrefix:(SRAPrefix*)value;


@end
