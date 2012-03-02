//
//  WizGlobalData.m
//  Wiz
//
//  Created by Wei Shijun on 3/9/11.
//  Copyright 2011 WizBrother. All rights reserved.
//

#import "WizGlobalData.h"
#import "WizSync.h"
#import "WizCreateAccount.h"
#import "WizVerifyAccount.h"
#import "WizDownloadPool.h"
#import "WizDocumentsByLocation.h"
#import "WizDocumentsByTag.h"
#import "WizDocumentsByKey.h"
#import "WizDownloadRecentDocuments.h"
#import "WizIndex.h"
#import "WizMisc.h"
#import "WizGlobals.h"
#import "WizDownloadObject.h"
#import "WizUploadObjet.h"
#import "LoginViewController.h"
#import "PickViewController.h"
#import "WizSyncByTag.h"
#import "WizSyncByLocation.h"
#import "WizSyncByKey.h"
#import "WizChangePassword.h"
#import "WizSettings.h"
#import "TTTAttributedLabel.h"

NSString* DataTypeOfSync = @"Sync";
NSString* DataTypeOfCreateAccount = @"CreateAccount";
NSString* DataTypeOfVerifyAccount = @"VerifyAccount";
NSString* DataTypeOfDocumentsByLocation = @"DocumentsByLocation";
NSString* DataTypeOfDocumentsByTag = @"DocumentsByTag";
NSString* DataTypeOfDownloadRecentDocuments = @"DownloadRecentDocuments";
NSString* DataTypeOfDocumentsByKey = @"DocumentsByKey";
//wiz-dzpqzb test
NSString* DataTypeOfDownloadObject = @"DownloadObject";
NSString* DataTypeOfUploadObject = @"UploadObject";
NSString* DataTypeOfUploadDocument= @"UploadDocument";
NSString* DataTypeOfUploadAttachment = @"UploadAttachment";
NSString* DataTypeOfDownloadDocument = @"DownloadDocument";
NSString* DataTypeOfDownloadAttachment = @"DownloadAttachment";
NSString* DataTypeOfIndex = @"Index";
NSString* DataTypeOfPickerView = @"PickViewOfUser";
NSString* DataTypeOfLoginView = @"wizLgoin";
NSString* DataMainOfWiz = @"wizMain";
NSString* DataTypeOfChangePassword = @"changeUserPassword";
static NSString* DataTypeOfSyncByTag = @"SyncByTag";
static NSString* DataTypeOfSyncByLocation = @"SyncByLocation";
static NSString* DataTypeOfSyncByKey = @"SyncByKey";

static NSString* DataTypeOfGlobalDownloadPool = @"GlobalDownloadPool";
//global image
NSString* DataIconForDocumentWithoutData = @"IconDocumentWithoutData";

static WizGlobalData* g_data;

@implementation WizGlobalData

@synthesize dict;

-(id) init
{
	if (self  = [super init])
	{
		NSString* logFileName = [[WizGlobals documentsPath] stringByAppendingPathComponent:@"info.log"];
		SetLogFileName([logFileName UTF8String]);
		//
		//
		NSMutableDictionary* d = [[NSMutableDictionary alloc] init] ;
		self.dict = d;
		[d release];
	}
	//
	return self;
}
-(void) dealloc
{
	dict = nil;
	//
	[super dealloc];
}

- (id) dataOfAccount: (NSString*) userId dataType: (NSString *) dataType
{
	NSString* key = [WizGlobalData keyOfAccount:userId dataType: dataType];
	//
	id val = [dict valueForKey:key];
	//
	return val;
}
- (void) setDataOfAccount: (NSString*) userId dataType: (NSString *) dataType data: (id) data
{
	NSString* key = [WizGlobalData keyOfAccount:userId dataType: dataType];
	//
	[dict setValue:data forKey:key];
}

- (WizSync *) syncData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfSync];
	if (data != nil)
		return data;
	//
	data = [[WizSync alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfSync data:data];
	 [data release];  return data;
}

- (WizCreateAccount *) createAccountData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfCreateAccount];
	if (data != nil)
		return data;
	//
	data = [[WizCreateAccount alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfCreateAccount data:data];
	 [data release];  return data;
}
- (WizVerifyAccount *) verifyAccountData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfVerifyAccount];
	if (data != nil)
		return data;
	//
	data = [[WizVerifyAccount alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfVerifyAccount data:data];
	 [data release];  return data;
}

- (WizChangePassword*) dataOfChangePassword:(NSString *)userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfChangePassword];
	if (data != nil)
		return data;
	//
	data = [[WizChangePassword alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfChangePassword data:data];
    [data release]; 
    return data;
}
- (WizDownloadDocument*) downloadDocumentData:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfDownloadDocument];
	if (data != nil)
		return data;
	//
	data = [[WizDownloadDocument alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDownloadDocument data:data];
	 [data release];  return data;
}
- (WizDownloadPool*) globalDownloadPool:(NSString *)userId
{
    WizDownloadPool* data = [self dataOfAccount:userId dataType:DataTypeOfGlobalDownloadPool];
    if (nil != data) {
        return data;
    }
    data= [[WizDownloadPool alloc] init];
    data.accountUserId = userId;
    [self setDataOfAccount:userId dataType:DataTypeOfGlobalDownloadPool data:data];
    [data release];
    return data;
}

- (WizDownloadAttachment*) downloadAttachmentData:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfDownloadAttachment];
	if (data != nil)
		return data;
	//
	data = [[WizDownloadAttachment alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDownloadAttachment data:data];
	 [data release];  return data;
}

- (UIImage*) documentIconWithoutData
{
    id data = [self dataOfAccount:DataMainOfWiz   dataType:DataIconForDocumentWithoutData ];
	if (data != nil)
		return data;
	//
	data = [UIImage imageNamed:@"documentWithoutData"];
	[self setDataOfAccount:DataMainOfWiz dataType:DataIconForDocumentWithoutData data:data];
    return data;
}

-(WizDownloadObject *) downloadObjectData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfDownloadObject];
	if (data != nil)
		return data;
	//
	data = [[WizDownloadObject alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDownloadObject data:data];
	 [data release];  return data;
}
- (void) stopSyncing
{
    for (int i = 0; i < [[WizSettings accounts] count]; i++) {
        NSString* userId = [WizSettings accountUserIdAtIndex:[WizSettings accounts] index:i];
        WizSync* sync = [self dataOfAccount:userId dataType:DataTypeOfSync];
        if (nil != sync) {
            [sync cancel];
        }
        WizSyncByKey* syncKey = [self dataOfAccount:userId dataType:DataTypeOfSyncByKey];
        if (nil != syncKey) {
            [syncKey cancel];
        }
        
        WizSyncByTag* syncTag = [self dataOfAccount:userId dataType:DataTypeOfSyncByTag];
        if (nil != syncTag) {
            [syncTag cancel];
        }
        WizSyncByLocation* syncLoc = [self dataOfAccount:userId dataType:DataTypeOfSyncByLocation];
        if (nil != syncLoc) {
            [syncLoc cancel];
        }
        
    }
}
- (WizSyncByTag*) syncByTagData:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfSyncByTag];
	if (data != nil)
		return data;
	data = [[WizSyncByTag alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfSyncByTag data:data];
    [data release];
    return data;
}
-(NSDictionary*) attributesForDocumentListName
{
    id data = [self dataOfAccount:DataOfGlobalShareDataWiz dataType:DataOfAttributesForDocumentListName];
	if (data != nil)
		return data;
	//
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    UIFont* stringFont = [UIFont boldSystemFontOfSize:15];
    CTFontRef font = CTFontCreateWithName((CFStringRef)stringFont.fontName, stringFont.pointSize, NULL);
    [dic setObject:(id)font forKey:(NSString*)kCTFontAttributeName];
    
    CTLineBreakMode lineBreakMode = kCTLineBreakByCharWrapping;
    CTParagraphStyleSetting settings[]={lineBreakMode};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings));
    [dic setObject:(id)paragraphStyle forKey:(NSString*)kCTParagraphStyleAttributeName];
    [self setDataOfAccount:DataOfGlobalShareDataWiz dataType:DataOfAttributesForDocumentListName data:dic];
    return dic;
}
- (NSDictionary*) attributesForAbstractViewParagraphPad
{
    id data = [self dataOfAccount:DataOfGlobalShareDataWiz dataType:DataOfAttributesForPadAbstractViewParagraph];
	if (data != nil)
		return data;
    NSMutableDictionary* attributeDic = [NSMutableDictionary dictionary];
    [attributeDic setObject:(id)[UIColor lightGrayColor].CGColor forKey:(NSString*)kCTUnderlineColorAttributeName];
    [attributeDic setObject:(id)[[UIColor grayColor] CGColor]  forKey:(NSString *)kCTForegroundColorAttributeName];
    long characheterSpacing = 0.5f;
    char characheter = (char)characheterSpacing;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &characheter);
    [attributeDic setObject:(id)num forKey:(NSString *)kCTKernAttributeName];
    
    CGFloat lineSpace = 19;
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierMinimumLineHeight;
    lineSpaceStyle.valueSize = sizeof(lineSpace);
    lineSpaceStyle.value = &lineSpace;
    CTParagraphStyleSetting settings[] = {lineSpaceStyle};
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, sizeof(settings));
    [attributeDic setObject:(id)style forKey:(id)kCTParagraphStyleAttributeName];
    UIFont* stringFont = [UIFont systemFontOfSize:13];
    CTFontRef font = CTFontCreateWithName((CFStringRef)stringFont.fontName, stringFont.pointSize, NULL);
    [attributeDic setObject:(id)font forKey:(NSString*)kCTFontAttributeName];
    [self setDataOfAccount:DataOfGlobalShareDataWiz dataType:DataOfAttributesForPadAbstractViewParagraph data:attributeDic];
    return attributeDic;
}
- (WizSyncByKey*) syncByKeyData:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfSyncByKey];
	if (data != nil)
		return data;
	data = [[WizSyncByKey alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfSyncByKey data:data];
    [data release];
    return data;
}
- (WizSyncByLocation*) syncByLocationData:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfSyncByLocation];
	if (data != nil)
		return data;
	data = [[WizSyncByLocation alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfSyncByLocation data:data];
    [data release];
    return data;
}


-(WizUploadObjet*) uploadObjectData:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType: DataTypeOfUploadObject];
	if (data != nil)
		return data;
	//
	data = [[WizUploadObjet alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfUploadObject data:data];
	 [data release];  return data;
}

-(WizUploadAttachment*) uploadAttachmentData:(NSString*) userId attachmentGUID:(NSString*) attachmentGUID owner:(WizApi*)owner
{
    WizUploadAttachment* data = [self dataOfAccount:userId dataType: DataTypeOfUploadAttachment];
	if (data != nil)
    {
        [data initWithObjectGUID:owner.apiURL token:owner.token kbguid:owner.kbguid attachmentGUID:attachmentGUID];
        data.owner = owner;
		return data;
    }
	//
	data = [[WizUploadAttachment alloc] initWithAccount:userId password:@""];
    [data initWithObjectGUID:owner.apiURL token:owner.token kbguid:owner.kbguid attachmentGUID:attachmentGUID];
    data.owner = owner;
	[self setDataOfAccount:userId dataType:DataTypeOfUploadAttachment data:data];
	 [data release];  return data;
}
-(WizUploadDocument*) uploadDocumentData:(NSString*) userId documentGUID:(NSString*) documentGUID owner:(WizSync*) owner
{
    WizUploadDocument* data = (WizUploadDocument*)[self dataOfAccount:userId dataType: DataTypeOfUploadDocument];
	if (data != nil)
    {
        [data initWithObjectGUID:owner.apiURL token:owner.token kbguid:owner.kbguid documentGUID:documentGUID];
        data.owner = owner;
		return data;
	}
	data = [[WizUploadDocument alloc] initWithAccount:userId password:@""];
    data.owner = owner;
    [data initWithObjectGUID:owner.apiURL token:owner.token kbguid:owner.kbguid documentGUID:documentGUID];
	[self setDataOfAccount:userId dataType:DataTypeOfUploadDocument data:data];
	 [data release];  return data;
}

- (WizDocumentsByLocation *) documentsByLocationData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfDocumentsByLocation];
	if (data != nil)
		return data;
	//
	data = [[WizDocumentsByLocation alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDocumentsByLocation data:data];
	 [data release]; 
    return data;
}

- (WizDocumentsByKey *) documentsByKeyData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfDocumentsByKey];
	if (data != nil)
		return data;
	//
	data = [[WizDocumentsByKey alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDocumentsByKey data:data];
	[data release];
    return data;
}


- (WizDocumentsByTag *) documentsByTagData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfDocumentsByTag];
	if (data != nil)
		return data;
	//
	data = [[WizDocumentsByTag alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDocumentsByTag data:data];
	[data release];
    return data;
}
- (WizDownloadRecentDocuments*) downloadRecentDocumentsData: (NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfDownloadRecentDocuments];
	if (data != nil)
		return data;
	//
	data = [[WizDownloadRecentDocuments alloc] initWithAccount:userId password:@""];
	[self setDataOfAccount:userId dataType:DataTypeOfDownloadRecentDocuments data:data];
    [data release];
	return data;
}

- (WizIndex *) indexData:(NSString*) userId
{
	id data = [self dataOfAccount:userId dataType: DataTypeOfIndex];
	if (data != nil)
		return data;
	//
	data = [[WizIndex alloc] initWithAccount:userId];
	[self setDataOfAccount:userId dataType:DataTypeOfIndex data:data];
    [data release];
	return data;	
}

- (LoginViewController*) wizMainLoginView:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType:DataTypeOfLoginView];
    if (data != nil) {
        return data;
    }
    data = [[LoginViewController alloc] init];
    [self setDataOfAccount:userId dataType:DataTypeOfLoginView data:data];
    [data release];
    return data;
}

- (PickerViewController*) wizPickerViewOfUser:(NSString*) userId
{
    id data = [self dataOfAccount:userId dataType:DataTypeOfPickerView];
    if (data != nil) {
        return data;
    }
    data = [[PickerViewController alloc] initWithUserID:userId];
    [self setDataOfAccount:userId dataType:DataTypeOfPickerView data:data];
    [data release];
    return data;
}

- (void) removeShareObjectData:(NSString*) dataType   userId:(NSString*) userId
{
    NSString* key = [WizGlobalData keyOfAccount:userId dataType: dataType];
    [dict removeObjectForKey:key];
}

- (void) removeAccountData:(NSString *)userId
{
    [self removeShareObjectData:DataTypeOfVerifyAccount userId:userId];
    [self removeShareObjectData:DataTypeOfUploadObject userId:userId];
    [self removeShareObjectData:DataTypeOfUploadDocument userId:userId];
    [self removeShareObjectData:DataTypeOfUploadAttachment userId:userId];
    [self removeShareObjectData:DataTypeOfCreateAccount userId:userId];
    [self removeShareObjectData:DataTypeOfSync userId:userId];
    [self removeShareObjectData:DataTypeOfSyncByKey userId:userId];
    [self removeShareObjectData:DataTypeOfSyncByLocation userId:userId];
    [self removeShareObjectData:DataTypeOfSyncByTag userId:userId];
    [self removeShareObjectData:DataTypeOfDocumentsByKey userId:userId];
    [self removeShareObjectData:DataTypeOfDocumentsByLocation userId:userId];
    [self removeShareObjectData:DataTypeOfDocumentsByTag userId:userId];
    [self removeShareObjectData:DataTypeOfDownloadAttachment userId:userId];
    [self removeShareObjectData:DataTypeOfDownloadDocument userId:userId];
    [self removeShareObjectData:DataTypeOfDownloadRecentDocuments userId:userId];
    [self removeShareObjectData:DataTypeOfGlobalDownloadPool userId:userId];
}

+ (NSString*) keyOfAccount:(NSString*) userId dataType: (NSString *) dataType
{
	NSString* key = [NSString stringWithFormat:@"%@_%@", userId, dataType];
	return key;
}
+ (WizGlobalData*) sharedData
{
	if (g_data == nil)
	{
		g_data = [[WizGlobalData alloc] init];
	}
	return g_data;
}
+ (void) deleteShareData
{
	if (g_data != nil)
	{
		[g_data release];
		g_data = nil;
	}
}


@end
