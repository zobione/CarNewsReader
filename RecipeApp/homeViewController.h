//
//  homeViewController.h
//  RecipeApp
//
//  Created by Emilien Sanchez on 02/06/2014.
//  Copyright (c) 2014 Emilien Sanchez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "iCarousel.h"

@interface homeViewController : UIViewController < AVSpeechSynthesizerDelegate, MPMediaPickerControllerDelegate, iCarouselDataSource, iCarouselDelegate>
{
    MPMusicPlayerController *musicPlayer;
    bool *meteo;
    MPMediaItem * item2;
    int *numberOfMusic;
}

-(void)pause:(bool)state;
-(void)addOverlay:(NSInteger)active;
-(void) registerMediaPlayerNotifications;


@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;


@property (strong, nonatomic) NSArray *News; //Contain all the news
@property (strong, nonatomic) NSArray *News2; //Contain all the news
@property (strong, nonatomic) NSMutableArray *NewsWithoutHTML; //Contain all the news
@property (strong, nonatomic) NSArray *Title; //Contain all the news title
@property (strong, nonatomic) NSArray *Source; //Contain all the news title

@property (assign, nonatomic) bool active; //Not used
@property (nonatomic, assign) NSInteger Overlay; //return yes if the overlay view is on
@property (nonatomic, assign) NSInteger Stop_Vue; //return yes if the app has been stopped
@property (assign, nonatomic) UIView *NewView; //contains the Overlay view
@property (nonatomic, assign) NSInteger Anim; //returns yes if the animation is on
@property (assign, nonatomic) CALayer *Objet; //
@property (nonatomic, assign) NSInteger StartApp; //returns yes if the app just started
@property (strong, nonatomic) UILabel *State; //display the state of the app
@property (assign, nonatomic) bool Pause; //use to pause the speech
@property (assign, nonatomic) int NbArticle; //use to pause the speech
@property (assign, nonatomic) double lowPassResults;
@property (assign, nonatomic) int ActionArticle; //use to select what kind for article to play


@property (strong, nonatomic) UILabel *Titre;//display the state of the app
@property (strong, nonatomic) UILabel *URL;
@property (strong, nonatomic) UILabel *feedSource; //display the state of the app
@property (strong, nonatomic) UIImageView *Content; //display the state of the app
@property (strong, nonatomic) UIImageView *Icon; //display the state of the app

@property (strong, nonatomic) AVSpeechUtterance *utterance; //contain the speech
@property (strong, nonatomic) AVSpeechSynthesizer *synth; //defines the synth voice

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) NSString *longitude;
@property (nonatomic, assign) NSString *latitude;

@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@end
