#include <spawn.h>
#include <signal.h>
@interface _CDBatterySaver
+ (id)batterySaver;
- (BOOL)setPowerMode:(long long)arg1 error:(id *)arg2;
@end
@interface SBTelephonyManager
+ (id)sharedTelephonyManager;
- (void)setIsInAirplaneMode:(BOOL)arg1;
@end
@interface FBSystemService
+ (id)sharedInstance;
- (void)exitAndRelaunch:(BOOL)arg1;
@end
BOOL shouldRespring = NO;
%hook SBPowerDownController
- (void)powerDown {
  [[objc_getClass("SBTelephonyManager") sharedTelephonyManager] setIsInAirplaneMode:YES];
  [[objc_getClass("_CDBatterySaver") batterySaver] setPowerMode:1 error:nil];
  shouldRespring = YES;
}
%end
%hook FBSystemService
-(void)shutdownAndReboot:(BOOL)arg1 {
  if(!arg1) {
    [[objc_getClass("SBTelephonyManager") sharedTelephonyManager] setIsInAirplaneMode:YES];
    [[objc_getClass("_CDBatterySaver") batterySaver] setPowerMode:1 error:nil];
    shouldRespring = YES;
  } else {
    [[objc_getClass("FBSystemService") sharedInstance] exitAndRelaunch:YES];
  }
}
%end
%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)arg1 {
  %orig;
  pid_t pid;
  int status;
  const char *argv[] = {"nohup", "/System/Library/CoreServices/cold.app/cold", NULL};
  posix_spawn(&pid, "/usr/bin/nohup", NULL, NULL, (char* const*)argv, NULL);
  waitpid(pid, &status, WEXITED);
}
- (_Bool)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 {
    int type = arg1.allPresses.allObjects[0].type;
    int force = arg1.allPresses.allObjects[0].force;
    if(type == 104 && force == 0 && shouldRespring) {
      [[objc_getClass("FBSystemService") sharedInstance] exitAndRelaunch:YES];
    }
    return %orig;
}
%end
