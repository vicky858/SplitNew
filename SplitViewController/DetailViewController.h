//
//  DetailViewController.h
//  SplitViewController
//
//  Created by vignesh on 9/8/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>
#import "PatientDetails.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) PatientDetails* patDetails;
@property (strong, nonatomic) IBOutlet UIImageView *usrImg;
@property (strong, nonatomic) IBOutlet UILabel *usrName;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *mailId;
@property (strong, nonatomic) IBOutlet UILabel *primayContactNo;
@property (strong, nonatomic) IBOutlet UILabel *secondaryContactNo;
@property (strong, nonatomic) IBOutlet UILabel *language;
@property (strong, nonatomic) IBOutlet UILabel *financialClass;
@property (strong, nonatomic) IBOutlet UILabel *financialPayer;
@property (strong, nonatomic) IBOutlet UILabel *nextAppointmentDate;
@property (strong, nonatomic) IBOutlet UILabel *appDocName;
@property (strong, nonatomic) IBOutlet UILabel *lastAppDate;
@property (strong, nonatomic) IBOutlet UILabel *lastVisit;
@property (strong, nonatomic) IBOutlet UILabel *transportation;
@property (strong, nonatomic) IBOutlet UILabel *refDoc;
@property (strong, nonatomic) IBOutlet UILabel *lastSeenDoc;
@property (strong, nonatomic) IBOutlet UILabel *LastVisitDocAdd;
@property (strong, nonatomic) IBOutlet UILabel *diagonises;
@property (strong, nonatomic) IBOutlet UILabel *diganosesDate;
@property (strong, nonatomic) IBOutlet UILabel *allergies;
@property (strong, nonatomic) IBOutlet UILabel *perfPharmacy;

@end

