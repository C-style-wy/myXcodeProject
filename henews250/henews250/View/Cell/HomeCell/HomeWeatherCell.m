//
//  HomeWeatherCell.m
//  henews250
//
//  Created by 汪洋 on 16/9/5.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "HomeWeatherCell.h"
#import "NetworkManager.h"
#import "CityManager.h"
#import "WeatherMode.h"

@implementation HomeWeatherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifer = @"HomeWeatherCell";
    HomeWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeWeatherCell" owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)setNews:(BOOL)hidden{
//    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(requestData:) userInfo:nil repeats:NO];
    NSString *weatherUrl = [DEF_GetWeatherurl stringByAppendingString:[[CityManager shareInstance] getCity]];
    [NetworkManager postRequestXmlWithURL:weatherUrl params:nil cacheBlock:^(NSDictionary *returnJson) {
        [self handlerWeatherBack:returnJson];
    } successBlock:^(NSDictionary *returnJson) {
        [self handlerWeatherBack:returnJson];
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)requestData:(NSTimer*)timer {
    NSString *weatherUrl = [DEF_GetWeatherurl stringByAppendingString:[[CityManager shareInstance] getCity]];
    [NetworkManager postRequestXmlWithURL:weatherUrl params:nil cacheBlock:^(NSDictionary *returnJson) {
        [self handlerWeatherBack:returnJson];
    } successBlock:^(NSDictionary *returnJson) {
        [self handlerWeatherBack:returnJson];
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
    [timer invalidate];
}

- (void)handlerWeatherBack:(NSDictionary*)data {
    WeatherMode *weatherData = [WeatherMode mj_objectWithKeyValues:data];
    ForecastMode *forecast = weatherData.forecast;
    NSArray *weathers = forecast.weather;
    WeatherItemMode *todayWeather = [weathers objectAtIndex:0];
    
    NSArray *aryHigh = [todayWeather.high componentsSeparatedByString:@" "];
    NSString *highWendu = [[aryHigh objectAtIndex:1] stringByReplacingOccurrencesOfString:DegreeCelsius withString:@""];
    
    NSArray *aryLow = [todayWeather.low componentsSeparatedByString:@" "];
    NSString *lowWendu = [aryLow objectAtIndex:1];
    
    self.todayWenDuLable.text = [[[[weatherData.city stringByAppendingString:@" "] stringByAppendingString:highWendu] stringByAppendingString:@"/"] stringByAppendingString:lowWendu];
    
    NSString *fengLi = [[[weatherData.fengxiang stringByAppendingString:weatherData.fengli] stringByAppendingString:@"  "] stringByAppendingString:@"空气质量:"];
    fengLi = [[[[fengLi stringByAppendingString:weatherData.environment.pm25] stringByAppendingString:@"("] stringByAppendingString:weatherData.environment.quality] stringByAppendingString:@")"];
    self.fengLi.text = fengLi;
    
    DayMode *todayDay = todayWeather.day;
    NSString *weatherText = todayDay.type;
    self.todayweatherLable.text = weatherText;
    self.todayImg.image = [UIImage imageNamed:weatherText];
    
    
    WeatherItemMode *Weather1 = [weathers objectAtIndex:1];
    NSArray *ary1 = [Weather1.date componentsSeparatedByString:@"日"];
    NSString *zhou1 = [[ary1 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
    self.time1.text = zhou1;
    DayMode *day1 = Weather1.day;
    NSString *w1 = day1.type;
    NSArray *aryHigh1 = [Weather1.high componentsSeparatedByString:@" "];
    NSString *highWendu1 = [[aryHigh1 objectAtIndex:1] stringByReplacingOccurrencesOfString:DegreeCelsius withString:@""];
    NSArray *aryLow1 = [Weather1.low componentsSeparatedByString:@" "];
    NSString *lowWendu1 = [aryLow1 objectAtIndex:1];
    NSString *wendu1 = [[[[w1 stringByAppendingString:@"  "]stringByAppendingString:highWendu1] stringByAppendingString:@"/"]stringByAppendingString:lowWendu1];
    self.wendu1.text = wendu1;
    self.weatherimg1.image = [UIImage imageNamed:w1];
    
    
    
    WeatherItemMode *Weather2 = [weathers objectAtIndex:2];
    NSArray *ary2 = [Weather2.date componentsSeparatedByString:@"日"];
    NSString *zhou2 = [[ary2 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
    self.time2.text = zhou2;
    DayMode *day2 = Weather2.day;
    NSString *w2 = day2.type;
    NSArray *aryHigh2 = [Weather2.high componentsSeparatedByString:@" "];
    NSString *highWendu2 = [[aryHigh2 objectAtIndex:1] stringByReplacingOccurrencesOfString:DegreeCelsius withString:@""];
    NSArray *aryLow2 = [Weather2.low componentsSeparatedByString:@" "];
    NSString *lowWendu2 = [aryLow2 objectAtIndex:1];
    NSString *wendu2 = [[[[w2 stringByAppendingString:@"  "]stringByAppendingString:highWendu2] stringByAppendingString:@"/"]stringByAppendingString:lowWendu2];
    self.wendu2.text = wendu2;
    self.weatherimg2.image = [UIImage imageNamed:w2];
    
    
    WeatherItemMode *Weather3 = [weathers objectAtIndex:3];
    NSArray *ary3 = [Weather3.date componentsSeparatedByString:@"日"];
    NSString *zhou3 = [[ary3 objectAtIndex:1] stringByReplacingOccurrencesOfString:@"星期" withString:@"周"];
    self.time3.text = zhou3;
    DayMode *day3 = Weather3.day;
    NSString *w3 = day3.type;
    NSArray *aryHigh3 = [Weather3.high componentsSeparatedByString:@" "];
    NSString *highWendu3 = [[aryHigh3 objectAtIndex:1] stringByReplacingOccurrencesOfString:DegreeCelsius withString:@""];
    NSArray *aryLow3 = [Weather3.low componentsSeparatedByString:@" "];
    NSString *lowWendu3 = [aryLow3 objectAtIndex:1];
    NSString *wendu3 = [[[[w3 stringByAppendingString:@"  "]stringByAppendingString:highWendu3] stringByAppendingString:@"/"]stringByAppendingString:lowWendu3];
    self.wendu3.text = wendu3;
    self.weatherimg3.image = [UIImage imageNamed:w3];
}
@end
