//
//  DRPRefreshControl.m
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import "DRPRefreshControl.h"
#import "DRPLoadingSpinner.h"

@interface DRPRefreshControl () <UIScrollViewDelegate>

//Indicatore di sistema di riferimento.
@property (strong) UIRefreshControl *refreshControl;

//Indicatore principale di riferimento.
@property (strong) DRPLoadingSpinner *loadingSpinner;

//Riferimento al protocollo principale.
@property (weak) id originalDelegate;

//Tabella di riferimento.
@property (weak) UITableViewController *tableViewController;

//ScrollView di riferimento.
@property (weak) UIScrollView *scrollView;

@property BOOL awaitingRefreshEnd;
@property (strong) void (^refreshBlock)(void);
@property (weak) id refreshTarget;
@property (assign) SEL refreshSelector;

@end

@implementation DRPRefreshControl

//Metodo di inizializzazione di sistema.
- (instancetype) init
{
    //Invocato il metodo della superclasse.
    self = [super init];
    
    //Inizializzazione personalizzata.
    if (self)
    {
        self.loadingSpinner = [[DRPLoadingSpinner alloc] init];
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget: self action: @selector(refreshControlTriggered:) forControlEvents: UIControlEventValueChanged];
        [self.refreshControl addSubview: self.loadingSpinner];
    }

    //Ritorna l'istanza inizializzata.
    return self;
}

//Metodo per associazione dell'indicatore ad una tabella di riferimento.
- (void) addToTableViewController: (UITableViewController *) tableViewController refreshBlock: (void (^)(void)) refreshBlock
{
    //Invocato lo specifico metodo di riferimento.
    [self addToTableViewController: tableViewController];
    self.refreshBlock = refreshBlock;
}

//Metodo per associazione dell'indicatore ad una tabella di riferimento.
- (void) addToTableViewController: (UITableViewController *) tableViewController target: (id) target selector: (SEL) selector
{
    //Invocato lo specifico metodo di riferimento.
    [self addToTableViewController: tableViewController];
    self.refreshTarget = target;
    self.refreshSelector = selector;
}

//Metodo per associazione dell'indicatore ad una tabella di riferimento.
- (void) addToTableViewController: (UITableViewController *) tableViewController
{
    //Elimina ogni associazione precedente.
    [self removeFromPartnerObject];
    
    self.tableViewController = tableViewController;
    self.scrollView = self.tableViewController.tableView;

    self.tableViewController.refreshControl = self.refreshControl;
    [self.refreshControl.subviews.firstObject removeFromSuperview];
    
    self.originalDelegate = self.scrollView.delegate;
    self.scrollView.delegate = self;
}

//Metodo per associazione dell'indicatore ad una ScrollView di riferimento.
- (void) addToScrollView: (UIScrollView *) scrollView refreshBlock: (void (^)(void)) refreshBlock
{
    //Invocato lo specifico metodo di riferimento.
    [self addToScrollView: scrollView];
    self.refreshBlock = refreshBlock;
}

//Metodo per associazione dell'indicatore ad una ScrollView di riferimento.
- (void) addToScrollView: (UIScrollView *) scrollView target: (id) target selector: (SEL) selector
{
    //Invocato lo specifico metodo di riferimento.
    [self addToScrollView: scrollView];
    self.refreshTarget = target;
    self.refreshSelector = selector;
}

//Metodo per associazione dell'indicatore ad una ScrollView di riferimento.
- (void) addToScrollView: (UIScrollView *) scrollView
{
    NSAssert([scrollView respondsToSelector: @selector(refreshControl)], @"refreshControl is only available on UIScrollView on iOS 10 and up.");
    
    //Elimina ogni associazione precedente.
    [self removeFromPartnerObject];
    
    self.scrollView = scrollView;
    self.scrollView.refreshControl = self.refreshControl;
    [self.refreshControl.subviews.firstObject removeFromSuperview];

    self.originalDelegate = self.scrollView.delegate;
    self.scrollView.delegate = self;
}

//Metodo per rimozione dell'indicatore dal layout di riferimento..
- (void) removeFromPartnerObject
{
    if (self.tableViewController)
    {
        self.tableViewController.refreshControl = nil;
        self.tableViewController = nil;
    }

    self.refreshTarget = nil;
    self.refreshSelector = nil;
    self.scrollView.delegate = self.originalDelegate;
    self.scrollView = nil;
}

//Metodo per il lancio dell'operazione di aggiornamento.
- (void) beginRefreshing
{
    BOOL adjustScrollOffset = (self.scrollView.contentInset.top == -self.scrollView.contentOffset.y);
    
    self.loadingSpinner.hidden = NO;
    [self.refreshControl beginRefreshing];
    [self refreshControlTriggered: self.refreshControl];
    
    if (adjustScrollOffset) [self.scrollView setContentOffset: CGPointMake(0.0f, -self.scrollView.contentInset.top) animated: YES];
}

//Metodo per l'arresto dell'operazione di aggiornamento.
- (void) endRefreshing
{
    __weak DRPRefreshControl *weakSelf = self;
    
    if (self.scrollView.isDragging)
    {
        [self.refreshControl endRefreshing];
        return;
    }
    
    self.awaitingRefreshEnd = YES;
    NSString * const animationGroupKey = @"animationGroupKey";
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:
    ^{
        [weakSelf.loadingSpinner stopAnimating];
        [weakSelf.loadingSpinner.layer removeAnimationForKey: animationGroupKey];
        if (!weakSelf.scrollView.isDecelerating) weakSelf.awaitingRefreshEnd = NO;
    }];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath: @"transform"];
    CATransform3D scaleTransform = CATransform3DScale(CATransform3DIdentity, 0.25f, 0.25f, 1.0f);
    scale.toValue = [NSValue valueWithCATransform3D: scaleTransform];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath: @"opacity"];
    opacity.toValue = @(0);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale, opacity];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.loadingSpinner.layer addAnimation: group forKey: animationGroupKey];
    [CATransaction commit];
    
    [self.refreshControl endRefreshing];
}

//Metodo gestore dell'interazione con l'indicatore di aggiornamento.
- (void)refreshControlTriggered:(UIRefreshControl *)refreshControl {
    [self.loadingSpinner startAnimating];

    if (self.refreshBlock) {
        self.refreshBlock();
    } else if (self.refreshTarget && self.refreshSelector) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.refreshTarget performSelector:self.refreshSelector withObject:self];
        #pragma clang diagnostic pop
    }
}

//Metodo di sistema gestore della fine di un evento di dragging sulla ScrollView.
- (void) scrollViewDidEndDragging: (UIScrollView *) scrollView willDecelerate: (BOOL) decelerate
{
    if ([self.originalDelegate respondsToSelector :@selector(scrollViewDidEndDragging:willDecelerate:)]) [self.originalDelegate scrollViewDidEndDragging: scrollView willDecelerate:decelerate];
    if (self.loadingSpinner.isAnimating && !self.refreshControl.isRefreshing) [self endRefreshing];
}

//Metodo di sistema gestore della decelerazione della ScrollView.
- (void) scrollViewDidEndDecelerating: (UIScrollView *) scrollView
{
    if ([self.originalDelegate respondsToSelector: @selector(scrollViewDidEndDecelerating:)]) [self.originalDelegate scrollViewDidEndDecelerating: scrollView];
    if (!self.refreshControl.isRefreshing) self.awaitingRefreshEnd = NO;
}

//Metodo di sistema gestore di un evento di scrolling sulla ScrollView.
- (void) scrollViewDidScroll: (UIScrollView *) scrollView
{
    if ([self.originalDelegate respondsToSelector: @selector(scrollViewDidScroll:)]) [self.originalDelegate scrollViewDidScroll: scrollView];

    if (!self.refreshControl.hidden) self.loadingSpinner.frame = CGRectMake((self.refreshControl.frame.size.width - self.loadingSpinner.frame.size.width) / 2, (self.refreshControl.frame.size.height - self.loadingSpinner.frame.size.height) / 2, self.loadingSpinner.frame.size.width, self.loadingSpinner.frame.size.height);

    if (!self.awaitingRefreshEnd)
    {
        self.loadingSpinner.hidden = NO;

        const CGFloat stretchLength = M_PI_2 + M_PI_4;
        CGFloat draggedOffset = scrollView.contentInset.top + scrollView.contentOffset.y;
        CGFloat percentToThreshold = draggedOffset / [self appleMagicOffset];

        self.loadingSpinner.staticArcLength = MIN(percentToThreshold * stretchLength, stretchLength);
    }
}

- (CGFloat) appleMagicOffset
{
    __block NSInteger majorOSVersion;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        majorOSVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString: @"."] firstObject] integerValue];
    });

    return ((majorOSVersion <= 9) ? -109.0f : -129.0f);
}

- (BOOL) respondsToSelector: (SEL) aSelector
{
    return ([super respondsToSelector: aSelector] || [self.originalDelegate respondsToSelector: aSelector]);
}

- (id) forwardingTargetForSelector: (SEL) aSelector
{
    return self.originalDelegate;
}

@end
