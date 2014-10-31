KamikazeDefense
===============
AS3 Flash Game

MainFile
`KamikazeDefense_proto.swf`

`(Clip) Me = "left awesome gun";`

Comman.as Basic Structural Class Use By Bose1.as,Enemy.as,Enemy_.as & stackBullet.as

it contain basic function which used by most of classes.

stackBullet.as baseClass of(stack,stack_e,stack_Fire,stack_Lazer,stack_Machine)
Comman class for every bullet Fired by enemy and user

there are 2 bullet holder bulletholder_mc,shipbulletholder_mc
shipbulletholder_mc is for Me bullets and bulletholder_mc is for Enemy 

There are two Basic type of Enemy Class

1. `(Enemy)` which fire limited bullets when `_in_area` is true & walk towards the `Me` and die `suicide`.
2. `(Enemy_)` which just walk towards the `Me` and die `suicide`.

Awesome Enemy.

3. `(Bose1)` Boss Enter the screen after every other Enemy Die. keep shooting until he or `Me` die.

`(Power)` is a class which decide when power up appear from above.
it contain code for basic drop animation with random speed and random position.

`(powerInd)` is class which used by clip just to show which powerup is activated . 

`(GameClass)` contains main game code logic.