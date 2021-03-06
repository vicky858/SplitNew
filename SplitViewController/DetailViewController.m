//
//  DetailViewController.m
//  SplitViewController
//
//  Created by vignesh on 9/8/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "DetailViewController.h"
#import "SplitViewController-Bridging-Header.h"
#import "PatientDetails.h"
#import "DateValueFormatter.h"

@interface CubicLineSampleFillFormatter : NSObject <IChartFillFormatter>
{
}
@end

@implementation CubicLineSampleFillFormatter

- (CGFloat)getFillLinePositionWithDataSet:(LineChartDataSet *)dataSet dataProvider:(id<LineChartDataProvider>)dataProvider
{
   
    return -10.f;

}

@end

@interface DetailViewController () <ChartViewDelegate>


@property (strong, nonatomic) IBOutlet LineChartView *chartView;
@property (strong, nonatomic) UILabel *imgLbl;


@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setPatDetails:(PatientDetails*)newDetailItem {
    if (_patDetails != newDetailItem) {
        _patDetails = newDetailItem;
        }
}

- (void)configureView {
    // Update the user interface for the detail item.
    
    if (self.patDetails) {
        [_usrImg setImage:[UIImage imageNamed:_patDetails.usrImg]];
        [_imgLbl setText:_patDetails.usrName];
        [_usrName setText:_patDetails.usrName];
        [_gender setText:_patDetails.gender];
        [_age setText:_patDetails.age];
        [_mailId setText:_patDetails.mailId];
        [_primayContactNo setText:_patDetails.primayContactNo];
        [_secondaryContactNo setText:_patDetails.secondaryContactNo];
        [_language setText:_patDetails.language];
        [_financialClass setText:_patDetails.financialClass];
        [_financialPayer setText:_patDetails.financialPayer];
        [_nextAppointmentDate setText:[NSString stringWithFormat:@"Next %@",_patDetails.nextAppointmentDate]];
        [_appDocName setText:_patDetails.appDocName];
        [_lastAppDate setText:[NSString stringWithFormat:@"Next %@",_patDetails.lastAppDate]];
        [_lastVisit setText:_patDetails.lastVisit];
        [_transportation setText:_patDetails.transportation];
        [_refDoc setText:_patDetails.refDoc];
        [_lastSeenDoc setText:_patDetails.lastSeenDoc];
        [_LastVisitDocAdd setText:_patDetails.LastVisitDocAdd];
        [_diagonises setText:_patDetails.diagonises];
        [_diganosesDate setText:_patDetails.diganosesDate];
        [_allergies setText:_patDetails.allergies];
        [_perfPharmacy setText:_patDetails.perfPharmacy];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _usrImg.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(173.0f/255.0f) blue:(199.0f/255.0f) alpha:1.0];
    _usrImg.layer.masksToBounds = YES;
    _usrImg.layer.cornerRadius = 20.0;
    
    _imgLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, _usrImg.bounds.size.width-28, _usrImg.bounds.size.width, 28)];
    _imgLbl.backgroundColor = [UIColor colorWithRed:(178.0f/255.0f) green:(178.0f/255.0f) blue:(178.0f/255.0f) alpha:1.0];
    _imgLbl.textColor = [UIColor whiteColor];
    _imgLbl.textAlignment = NSTextAlignmentCenter;
    [_usrImg addSubview:_imgLbl];
    
    [self configureView];
    [self setUpLineChartView];
    [self populateChartData];
   
}



-(void)setUpLineChartView{
    _chartView.delegate = self;

    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"You need to provide data for the chart.";
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = YES;
    _chartView.highlightPerDragEnabled = YES;
    _chartView.backgroundColor = UIColor.whiteColor;
    _chartView.legend.enabled = YES;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:10.f];
    xAxis.labelTextColor = [UIColor colorWithRed:180/255.0 green:51/255.0 blue:36/255.0 alpha:1.0];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = YES;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.granularity = 3600.0;
    xAxis.valueFormatter = [[DateValueFormatter alloc] init];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12.f];
    leftAxis.labelTextColor = [UIColor colorWithRed:180/255.0 green:51/255.0 blue:36/255.0 alpha:1.0];
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.granularityEnabled = YES;
    leftAxis.axisMinimum = 0.0;
    leftAxis.axisMaximum = 170.0;
    leftAxis.yOffset = -9.0;
    leftAxis.labelTextColor = [UIColor colorWithRed:180/255.0 green:51/255.0 blue:36/255.0 alpha:1.0];
    
    _chartView.rightAxis.enabled = YES;
    _chartView.rightAxis.labelTextColor = [UIColor colorWithRed:180/255.0 green:51/255.0 blue:36/255.0 alpha:1.0];
     _chartView.rightAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12.f];
    _chartView.legend.form = ChartLegendFormLine;
    
   }

-(void)populateChartData{
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval hourSeconds = 3600.0;
    
    int count = 5;
    int range = 100;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    NSTimeInterval from = now - (count / 2.0) * hourSeconds;
    NSTimeInterval to = now + (count / 2.0) * hourSeconds;
    
    for (NSTimeInterval x = from; x < to; x += hourSeconds)
    {
        double y = arc4random_uniform(range) + 50;
        [values addObject:[[ChartDataEntry alloc] initWithX:x y:y]];
    }
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    [colors addObject:[UIColor colorWithRed:54/255.f green:68/255.f blue:212/255.f alpha:1.f]];
    
    NSMutableArray *circleColor =[[NSMutableArray alloc]init];

    [circleColor addObject:[UIColor colorWithRed:101/255.f green:64/255.f blue:166/255.f alpha:1.f]];
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.colors = colors;
        set1.values = values;
        set1.circleColors = circleColor;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        set1.colors = colors;
        set1.valueTextColor = [UIColor colorWithRed:180/255.0 green:51/255.0 blue:36/255.0 alpha:1.0];
        set1.lineWidth = 1.5;
        set1.circleColors = circleColor;
        set1.drawCirclesEnabled = YES;
        set1.circleHoleColor = [UIColor grayColor];
        set1.drawValuesEnabled = YES;
        set1.fillAlpha = 1.0;
        set1.fillColor = [UIColor colorWithRed:51/255.0 green:181/255.0 blue:229/255.0 alpha:1.0];
        set1.highlightColor = [UIColor colorWithRed:214/255.0 green:69/255.0 blue:119/255.0 alpha:1.0];
        set1.drawCircleHoleEnabled = YES;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.blackColor];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:9.0]];
        
        _chartView.data = data;
    }
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
