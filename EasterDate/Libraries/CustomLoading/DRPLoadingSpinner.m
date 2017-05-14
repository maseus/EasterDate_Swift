//
//  DRPLoadingSpinner.m
//  EasterDate
//
//  Created by Eustachio Maselli on 23/04/17.
//  Copyright © 2017 Eustachio Maselli All rights reserved.
//

#import "DRPLoadingSpinner.h"

#define kInvalidatedTimestamp -1

@interface DRPLoadingSpinner () <CAAnimationDelegate>

//Parametri di riferimento.
@property BOOL isAnimating;
@property BOOL isFirstCycle;
@property NSUInteger colorIndex;
@property CAShapeLayer *circleLayer;

@end

@implementation DRPLoadingSpinner

#pragma mark - Life cycle

//Metodo di inizializzazione di sistema.
- (instancetype) init
{
    //Invocato il metodo della superclasse.
    self = [super initWithFrame: CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    
    //Inizializzazione personalizzata.
    if (self) [self setup];
    
    //Ritorna l'istanza inizializzata.
    return self;
}

//Metodo di inizializzazione di sistema.
- (instancetype) initWithFrame: (CGRect) frame
{
    //Invocato il metodo della superclasse.
    self = [super initWithFrame: frame];
    
    //Inizializzazione personalizzata.
    if (self) [self setup];
    
    //Ritorna l'istanza inizializzata.
    return self;
}

//Metodo di inizializzazione di sistema.
- (id) initWithCoder: (NSCoder *) aDecoder
{
    //Invocato il metodo della superclasse.
    self = [super initWithCoder: aDecoder];
    
    //Inizializzazione personalizzata.
    if (self) [self setup];
    
    //Ritorna l'istanza inizializzata.
    return self;
}

//Metodo per inizializzazione personalizzata.
- (void) setup
{
    self.circleLayer = [[CAShapeLayer alloc] init];
    self.drawCycleDuration = 0.75f;
    self.rotationCycleDuration = 1.5f;
    self.staticArcLength = 0.0f;
    self.maximumArcLength = (2 * M_PI) - M_PI_4;
    self.minimumArcLength = 0.1f;
    self.lineWidth = 2.0f;
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    //Sequenza di colori predefinita.
    self.colorSequence = @[[UIColor redColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor blueColor]];
    
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.circleLayer.strokeColor = self.colorSequence.firstObject.CGColor;
    self.circleLayer.hidden = YES;

    self.circleLayer.actions = @{@"lineWidth": [NSNull null], @"strokeEnd": [NSNull null], @"strokeStart": [NSNull null], @"transform": [NSNull null], @"hidden": [NSNull null]};
    
    //Aggiorna la visualizzazione dell'indicatore.
    [self refreshCircleFrame];
}

- (void) setFrame: (CGRect) frame
{
    //Invocato il metodo della superclasse.
    [super setFrame: frame];
    
    //Aggiorna la visualizzazione dell'indicatore.
    [self refreshCircleFrame];
}

//Metodo setter per l'arco dell'indicatore in stato di arresto.
- (void) setStaticArcLength: (CGFloat) staticArcLength
{
    _staticArcLength = staticArcLength;

    if (!self.isAnimating)
    {
        self.circleLayer.hidden = NO;
        self.circleLayer.strokeColor = self.colorSequence.firstObject.CGColor;
        self.circleLayer.strokeStart = 0.0f;
        self.circleLayer.strokeEnd = [self proportionFromArcLengthRadians: staticArcLength];
        self.circleLayer.transform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0.0f, 0.0f, 1.0f);
    }
}

//Metodo setter per la larghezza della linea dell'arco dell'indicatore.
- (void) setLineWidth: (CGFloat) lineWidth
{
    self.circleLayer.lineWidth = lineWidth;
}

//Metodo getter per la larghezza della linea dell'arco dell'indicatore.
- (CGFloat) lineWidth
{
    return self.circleLayer.lineWidth;
}

//Metodo per aggiornamento del layout dell'indicatore.
- (void) refreshCircleFrame
{
    CGFloat sideLen = MIN(self.layer.frame.size.width, self.layer.frame.size.height) - (2 * self.lineWidth);
    CGFloat xOffset = ceilf((self.frame.size.width - sideLen) / 2.0f);
    CGFloat yOffset = ceilf((self.frame.size.height - sideLen) / 2.0f);
    
    self.circleLayer.frame = CGRectMake(xOffset, yOffset, sideLen, sideLen);
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0f, 0.0f, sideLen, sideLen)].CGPath;
}

//Metodo di sistema per la gestione del layout principale.
- (void) layoutSublayersOfLayer: (CALayer *) layer
{
    //Invocato lo specifico metodo di riferimento.
    [super layoutSublayersOfLayer: layer];
    if (!self.circleLayer.superlayer) [self.layer addSublayer: self.circleLayer];
}

//Metodo per il lancio dell'animazione.
- (void) startAnimating
{
    //Termina un'eventuale animazione in corso.
    [self stopAnimating];
    
    self.circleLayer.hidden = NO;
    self.isAnimating = YES;
    self.isFirstCycle = YES;
    self.circleLayer.strokeEnd = [self proportionFromArcLengthRadians: self.minimumArcLength];
    self.colorIndex = 0;
    self.circleLayer.strokeColor = [self.colorSequence[self.colorIndex] CGColor];
    
    //Applica e lancia l'animazione prevista.
    [self addAnimationsToLayer: self.circleLayer reverse: NO rotationOffset: -M_PI_2];
}

//Metodo per l'arresto dell'animazione.
- (void) stopAnimating
{
    self.isAnimating = NO;
    self.circleLayer.hidden = YES;
    
    //Ferma ogni animazione in corso.
    [self.circleLayer removeAllAnimations];
}

- (CGSize) intrinsicContentSize
{
    return CGSizeMake(40.0f, 40.0f);
}

#pragma mark

//Metodo per configurazione e lancio dell'animazione prevista.
- (void) addAnimationsToLayer: (CAShapeLayer *) layer reverse: (BOOL) reverse rotationOffset: (CGFloat) rotationOffset
{
    CABasicAnimation *strokeAnimation;
    CGFloat strokeDuration = self.drawCycleDuration;
    CGFloat currentDistanceToStrokeStart = 2 * M_PI * layer.strokeStart;

    if (reverse)
    {
        [CATransaction begin];
        
        strokeAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
        CGFloat newStrokeStart = self.maximumArcLength - self.minimumArcLength;
        
        layer.strokeEnd = [self proportionFromArcLengthRadians: self.maximumArcLength];
        layer.strokeStart = [self proportionFromArcLengthRadians: newStrokeStart];
        
        strokeAnimation.fromValue = @(0);
        strokeAnimation.toValue = @([self proportionFromArcLengthRadians: newStrokeStart]);
        
    }
    else
    {
        CGFloat strokeFromValue = self.minimumArcLength;
        CGFloat rotationStartRadians = rotationOffset;

        if (self.isFirstCycle)
        {
            if (self.staticArcLength > 0 && self.staticArcLength <= self.maximumArcLength)
            {
                strokeFromValue = self.staticArcLength;
                strokeDuration *= (self.staticArcLength / self.maximumArcLength);
            }

            self.isFirstCycle = NO;
        }
        else rotationStartRadians += currentDistanceToStrokeStart;

        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
        rotationAnimation.fromValue = @(rotationStartRadians);
        rotationAnimation.toValue = @(rotationStartRadians + (2 * M_PI));
        rotationAnimation.duration = self.rotationCycleDuration;
        rotationAnimation.repeatCount = CGFLOAT_MAX;
        rotationAnimation.fillMode = kCAFillModeForwards;
        
        [layer removeAnimationForKey: @"rotation"];
        [layer addAnimation:rotationAnimation forKey: @"rotation"];

        [CATransaction begin];
        
        strokeAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
        strokeAnimation.fromValue = @([self proportionFromArcLengthRadians: strokeFromValue]);
        strokeAnimation.toValue = @([self proportionFromArcLengthRadians: self.maximumArcLength]);
        
        layer.strokeStart = 0;
        layer.strokeEnd = [strokeAnimation.toValue doubleValue];
    }
    
    strokeAnimation.delegate = self;
    strokeAnimation.fillMode = kCAFillModeForwards;
    strokeAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [CATransaction setAnimationDuration: strokeDuration];

    [layer removeAnimationForKey: @"stroke"];
    [layer addAnimation:strokeAnimation forKey: @"stroke"];

    [CATransaction commit];    
}

//Metodo gestore dell'arresto dell'animazione in corso.
- (void) animationDidStop: (CAAnimation *) anim finished: (BOOL) finished
{
    if (finished && [anim isKindOfClass: [CABasicAnimation class]])
    {
        CABasicAnimation *basicAnim = (CABasicAnimation *) anim;
        BOOL isStrokeStart = [basicAnim.keyPath isEqualToString: @"strokeStart"];
        BOOL isStrokeEnd = [basicAnim.keyPath isEqualToString: @"strokeEnd"];
        
        CGFloat rotationOffset = fmodf([[self.circleLayer.presentationLayer valueForKeyPath: @"transform.rotation.z"] floatValue], 2 * M_PI);
        [self addAnimationsToLayer: self.circleLayer reverse: isStrokeEnd rotationOffset: rotationOffset];
        
        if (isStrokeStart) [self advanceColorSequence];
    }
}

- (void) advanceColorSequence
{
    self.colorIndex = (self.colorIndex + 1) % self.colorSequence.count;
    self.circleLayer.strokeColor = [self.colorSequence[self.colorIndex] CGColor];
}

- (CGFloat) proportionFromArcLengthRadians: (CGFloat) radians
{
    return ((fmodf(radians, 2 * M_PI)) / (2 * M_PI));
}

@end
