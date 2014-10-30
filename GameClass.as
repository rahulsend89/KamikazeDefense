﻿package {	import flash.display.*;	import flash.events.*;	import flash.text.TextField;	import flash.geom.*;	import flash.utils.*;	import Me;	import ScreenShake;	import flash.utils.getDefinitionByName;	public class GameClass extends MovieClip {		var shieldTimer:Number = 3000;		public var power_Shield:Boolean = false;		var healthPack:Number = 20;		var bullets:Number = 0;		public var power_Machine:Boolean = false;		public var power_Multi:Boolean = false;		public var power_Lazer:Boolean = false;		public var power_Fire:Boolean = false;		public var power_Machine_bullets:Number = 20;		public var power_Multi_bullets:Number = 20;		public var power_Lazer_bullets:Number = 20;		public var power_Fire_bullets:Number = 20;		public var stagew:Number=800;		public var stageh:Number=600;		public var reputation_meter:Number=100;		public var guntype:Number=0;		public var mcClip:Me;		public var van_health:Number=100;		public var levelNo:Number;		public var _press:Boolean=false;		public var _reduce_val:Number=0;		public var __reduce_val:Number=0;		public var ___reduce_val:Number=0;		public var money:Number=0;		public var freePlayMode:Boolean = false;		private var boseStart:Boolean = false;		public var curbArray:Array=new Array(1,0,0,0,0,0,0,0);		private var timer:Timer = new Timer(100000,25000);		private var gameOverTimer:Timer = new Timer(3000,1);		private var boseVal;		private var gameStateVal:Boolean = true;		public var gamePause:Boolean = false;		public var ar_level_hdd:Array=[[5,3,1,0,0,0,0,0,1],[10,7,2,1,0,0,0,0,0,1],[10,7,1,1,1,0,0,0,0,0,1],[10,7,3,2,1,1,0,0,0,0,0,1],[10,7,3,1,1,1,1,0,0,0,0,0,1],[10,7,4,3,1,1,1,1,0,0,0,0,0,1]];		//public var ar_level_hdd:Array=[[1,1,0,0,2,0,2,0,1],[10,7,2,1,0,0,0,0,0,1],[10,7,1,1,1,0,0,0,0,0,1],[10,7,3,2,1,1,0,0,0,0,0,1],[10,7,3,1,1,1,1,0,0,0,0,0,1],[1,1,0,0,0,0,0,0,0,0,0,0,0,1]];		private var ar_level_easy:Array=[[5,3],[7,5,3],[10,7,5,3],[10,7,5,4,3],[10,7,5,4,3,3],[10,7,5,4,3,3,3]];		private var ar_level:Array = new Array();		public var ar_:Array=new Array;		public var ar__:Array=new Array;		var ar:Array;		private var tempVal:Number=0;		public function GameClass () {			var mainClass=this.root  as  MovieClip;			power_Shield = false;			power_Machine= false;			power_Multi= false;			power_Lazer= false;			power_Fire= false;			//trace (mainClass.levelNo);			money = 0;		}		public function playAgain (par) {			van_health = 100;			startLevel (par);		}		private function pauseScreen_(e:Event):void{			if (!gameStateVal) {				pause_mc.gotoAndStop(2);				gamePause = true;			}		}		private function pauseScreen(e:MouseEvent){			if (!gameStateVal) {				if (gamePause) {					e.currentTarget.gotoAndStop(1);					gamePause = false;				}else{					e.currentTarget.gotoAndStop(2);					gamePause = true;				}			}		}		public function startLevel (par) {			gamePause = false;			boseStart = false;			gameStateVal  = false;			pause_mc.addEventListener(MouseEvent.CLICK,pauseScreen);			if (freePlayMode) {				timer.addEventListener(TimerEvent.TIMER, ActivateBose);				timer.start();				level_txt.text = "SURVIVAL";			}else{				gameOverTimer.addEventListener(TimerEvent.TIMER, gameOverTimerCall);						level_txt.text = par;			}			var main_movieclip:MovieClip = this.root as MovieClip;			score_txt.text = ""+money;			if (main_movieclip.gameMode == "easy") {				ar_level = ar_level_easy;			} else {				ar_level = ar_level_hdd;			}			//trace(ar_level+" : ");			var reputation_meter_mc=this.getChildByName("reputation_meter_mc")  as  MovieClip;			//reputation_meter_mc.gotoAndStop (100);			var num:int = par-1;			//groundtype=groundtype_ar[num];			tempVal=0;			//panBG (par);			ar_=new Array  ;			ar__=new Array  ;			//gun_mc.gun_mc.gotoAndStop (guntype);			//gun_mc.startGun ();			mcClip=new Me ();			stage.addEventListener (MouseEvent.MOUSE_DOWN,Click);			//stage.addEventListener (MouseEvent.MOUSE_OUT,mouseout);			stage.addEventListener (MouseEvent.MOUSE_UP,mouseout);			stage.addEventListener (KeyboardEvent.KEY_DOWN,changeGun);			stage.addEventListener(Event.DEACTIVATE, pauseScreen_);			//mcClip = this.getChildByName("ship_mc") as Me;						holder_mc.addChild(mcClip);			mcClip.name = "ship_mc";			mcClip.x = 20;			mcClip.y = stage.stageHeight/2;						holder_mc.par=par;			mcClip.per = van_health;			if (curbArray[6] == 1) {				mcClip.man1_mc.visible=true;			}			if (curbArray[7] == 1) {				mcClip.man2_mc.visible=true;			}			var _par:Number=par - 1;			var levellen:Number=ar_level[_par].length;			_reduce_val= levellen+1;			var numCal:Number = 0;			if (! isNaN(levellen)) {				for (var j:Number=0; j < levellen; j++) {					_reduce_val--;					var ar_level_par:Number=ar_level[_par][j];					if (ar_level_par==0) {						numCal++;						_reduce_val++;					}					if (! isNaN(ar_level_par)) {						for (var k:Number=0; k < ar_level_par; k++) {							//trace ("clip"+j+"_"+k+"_mc");							tempVal++;							var _val:Number=j + 1;							var s:String="clip" + _val + "_mc";							var _Class:Class=getDefinitionByName(s)  as  Class;							var clip:MovieClip=new _Class;							//clip = new clip_mc();							holder_mc.addChild (clip);							ar_.push (clip);							clip.name="clip" + j + "_" + k + "_mc";														clip.reduceVal=(_reduce_val*2) + (guntype);								//clip.reduceVal=(_reduce_val/1.5) + (guntype/3);							//}							clip._type=j;							clip.shootVal = (clip._type+1);							//clip.val_txt.text=String(roundDecimalToPlace(clip.reduceVal,1)+" : "+roundDecimalToPlace(clip.shootVal,1));							clip.x=- clip.width + 10;							var randomX:Number=(Math.random() * (stage.stageWidth)) - (stage.stageWidth);							var randomY:Number=(Math.random() * (stage.stageHeight - 50)) + 10;														//var startPoint__l:Point=new Point((Math.random() *  (stage.stageWidth))-stage.stageWidth,randomY__l);														var startPoint:Point=new Point(0,0);							if (j==0 || j==1 || j==4||j==6) {								clip.typeE = "normal";								startPoint=new Point((Math.random() *(stage.stageWidth * (j + (ar_level_par/2))))+stage.stageWidth,stage.stageHeight-85);								clip.endPoint=randomX;								clip.speed = (Math.random()*2)+2;							}else if(j==2 || j==3){								clip.typeE = "normal";								startPoint=new Point((Math.random() *(stage.stageWidth * (j + (ar_level_par/2))))+stage.stageWidth,stage.stageHeight/2);								clip.endPoint=randomX;								clip.speed = (Math.random()*3)+2;							}else if(j==5 || j==7){								clip.typeE = "normal";								startPoint=new Point((1 *(stage.stageWidth * (j + (ar_level_par/2))))+stage.stageWidth,100);								clip.endPoint=randomX;								clip.speed = (Math.random()*4)+3;							}else{								clip.typeE = "bose";								startPoint=new Point(stage.stageWidth+stage.stageWidth/2,stage.stageHeight/2);								clip.endPoint=randomX;								clip.speed = 4;							}							clip.startPoint = startPoint;							clip.x=startPoint.x;							clip.y=startPoint.y;							clip.addEventListener (Event.ENTER_FRAME,startMoving);							clip.addEventListener(Event.REMOVED_FROM_STAGE,removeStartMoving);							mcClip.clipAr.push(clip);							//trace(mcClip+" : ");						}					}				}			}			//ar_.sortOn (["y"],Array.NUMERIC);			//short (ar_,this.holder_mc);		}		private function ActivateBose(e:TimerEvent):void{			timer.stop();			boseStart = true;		}		private function gameOverTimerCall(e:TimerEvent):void{			holder_mc.removeChild (boseVal);			gameOver(false);		}		public function removeStartMoving(e:Event){			e.target.removeEventListener (Event.ENTER_FRAME,startMoving);		}		public function startMoving (event:Event):void {			if (!gamePause) {				if (event.target.x>0&& event.target.x<stage.stageWidth) {					event.target._in_area = true;				} else {					event.target._in_area = false;				}				if (event.target.typeE == "normal") {					if (event.target.endPoint < event.target.x) {						event.target.x-= event.target.speed;					} else {						event.target.x = event.target.endPoint ;					}				}else if(boseStart){					if (event.target.x > 400) {						event.target.x-= event.target.speed;					} else {						event.target.x = 400;					}				}				if (event.target.x<=10) {					if (!power_Shield) {						mcClip.per-=(event.target._type+1)*2;					}					doit(event.target);				}				/*var mc:MovieClip=this.gun_mc.cur_mc;				var _par:Number=lholder_mc.par - 1;				var levellen:Number=ar_levelL[_par].length;				if (! isNaN(levellen)) {					for (var j:Number=0; j < levellen; j++) {						var ar_level_par:Number=ar_levelL[_par][j];						if (! isNaN(ar_level_par)) {							for (var k:Number=0; k < ar_levelL[_par][j]; k++) {								//trace ("clip"+j+"_"+k+"_mc");								var str:String="clip" + j + "_" + k + "_mc";								var mcC:MovieClip=lholder_mc.getChildByName(str)  as  MovieClip;								if (mcC != null) {									var rect:Rectangle=getCollisionRect(mcC,mc,mc.parent,true,255);									//if ((rect.width!=0 || rect.height!=0)) {}									if (mcC.hitTestObject(mc) && this._press && this.gun_mc.mainVal == 1 && this.gun_mc.mouseDownVal && this.gun_mc.shoot) {										mcC.press=true;										//mcC.reduceVal += this.gun_mc.guntype/2;									} else {										mcC.press=false;									}								}							}						}					}				}*/			}		}		public function gameOver (par) {			if (!gameStateVal) {				pause_mc.removeEventListener(MouseEvent.CLICK,pauseScreen);				gameStateVal = true;				var mainClip:MovieClip=this.root  as  MovieClip;				var power_mc:MovieClip = this.getChildByName("power_mc") as MovieClip;								if (par) {					//trace ("GameOver");					money = 0;					removeEventListeners ();					mainClip.gameFeed_mc.gotoAndStop (3);				} else {					//trace ("GameWin : " + mainClip + " : " + mainClip.gameFeed_mc);					removeEventListeners ();					//trace (mainClip.levelNo+" : levelNo");					if (mainClip.levelNo==6) {						mainClip.gameFeed_mc.gotoAndStop (4);					} else {						mainClip.gameFeed_mc.gotoAndStop (2);					}				}			}		}		public function removeEventListeners () {			stage.removeEventListener (MouseEvent.CLICK,Click);			stage.removeEventListener (MouseEvent.MOUSE_UP,mouseout);			stage.removeEventListener (KeyboardEvent.KEY_DOWN,changeGun);			mcClip.shoot = false;			removeChildrenOf(shipbulletholder_mc);			removeChildrenOf(holder_mc);		}		public function removeChildrenOf (mc:MovieClip):void {			if (mc.numChildren != 0) {				var k:int=mc.numChildren;				while (k--) {					//mc.getChildAt (k);					mc.removeChildAt( k );				}			}		}		public function doit (par):void {			var _blast:blast=new blast();			if (!freePlayMode) {				if (tempVal == 2) {					boseStart = true;				}				mcClip.clipAr.splice(mcClip.clipAr.indexOf(par),1);				if (tempVal <= 1) {					mcClip.reduceVal=0;					//mcClip.press=false;					if (!isNaN(par._type)) {						money+= (par._type+1) * 100;						score_txt.text = ""+money;						ScreenShake.go (root,par._type*5,0.2);						//trace (money+" : money "+(par._type+1));					}					var bigblast:bigBlast = new bigBlast();					holder_mc.addChild (bigblast);					bigblast.x=300;					bigblast.y=225;					par.removeEventListener (Event.ENTER_FRAME,startMoving);					boseVal = par;					//holder_mc.removeChild (par);					gameOverTimer.start();				} else {					tempVal--;					mcClip.reduceVal=0;					//mcClip.press=false;					//trace (mcClip.press+" : "+mcClip.name+" : "+tempVal+" : "+par+" : "+par._type);					if (!isNaN(par._type)) {						money+= (par._type+1) * 100;						score_txt.text = ""+money;						ScreenShake.go (root,par._type*5,0.2);						//trace (money+" : money "+(par._type+1));					}					//var _blast:blast=new blast();					holder_mc.addChild (_blast);					_blast.x=par.x + par.holder_mc.x;					_blast.y=par.y + par.holder_mc.y;					par.removeEventListener (Event.ENTER_FRAME,startMoving);					holder_mc.removeChild (par);				}			}else{				holder_mc.addChild (_blast);				_blast.x=par.x + par.holder_mc.x;				_blast.y=par.y + par.holder_mc.y;				if (par.typeE == "bose") {					boseStart = false;					timer.start();				}				mcClip.reduceVal=0;				if (!isNaN(par._type)) {					money+= (par._type+1) * 100;					score_txt.text = ""+money;					ScreenShake.go (root,par._type*5,0.2);					par.x = par.startPoint.x;					if (par.typeE == "bose") {						//par.y = stage.stageHeight/2					}else{							par.y = par.startPoint.y;					}					par.per = 100;					par.removed = false;					//trace (money+" : money "+(par._type+1));				}				//var _blast:blast=new blast();				//par.removeEventListener (Event.ENTER_FRAME,startMoving);				//holder_mc.removeChild (par)			}		}		private function changeGun(e:KeyboardEvent):void {			var power_mc:MovieClip = this.getChildByName("power_mc") as MovieClip;			if (e.keyCode==49) {				guntype = 0;				power_txt.text = "~";				power_mc.gotoAndStop("normal");			} else if (e.keyCode==50 && power_Machine) {				guntype = 1;				power_txt.text = ""+power_Machine_bullets;				power_mc.gotoAndStop("Machine");			} else if (e.keyCode==51 && power_Multi) {				guntype = 2;				power_txt.text = ""+power_Multi_bullets;				power_mc.gotoAndStop("Multi");			} else if (e.keyCode==52 && power_Lazer) {				guntype = 3;				power_txt.text = ""+power_Lazer_bullets;				power_mc.gotoAndStop("Lazer");			} else if (e.keyCode==53 && power_Fire) {				guntype = 4;				power_txt.text = ""+power_Fire_bullets;			}		}		public function powerRemoved(par){			mcClip.clipAr.splice(mcClip.clipAr.indexOf(par),1);			var power_mc:MovieClip = this.getChildByName("power_mc") as MovieClip;			switch(par.name.toString()){				case"Shield":				power_mc.gotoAndStop("Shield");				activateShield();				break;				case"Health":				power_mc.gotoAndStop("Health");				mcClip.per+=healthPack;				break;				case"Machine":				power_mc.gotoAndStop("Machine");				power_Machine = true;				power_Machine_bullets+=20;				power_txt.text = ""+power_Machine_bullets;				break;				case"Multi":				power_mc.gotoAndStop("Multi");				power_Multi = true;				power_Multi_bullets+=20;				power_txt.text = ""+power_Multi_bullets;				break;				case"Lazer":				power_Lazer = true;				power_Lazer_bullets+=20;				power_txt.text = ""+power_Lazer_bullets;				power_mc.gotoAndStop("Lazer");				break;				case"Fire":				power_Fire = true;				power_Fire_bullets+=20;				power_txt.text = ""+power_Fire_bullets;				break;			}		}		private function activateShield(){			var sheild_mc:MovieClip = this.getChildByName("sheild_mc") as MovieClip;			sheild_mc.gotoAndStop(sheild_mc.totalFrames);			power_Shield = true;			var timer:Timer = new Timer(shieldTimer,1);			timer.addEventListener(TimerEvent.TIMER,deactivateShield);			timer.start();		}		public function deactivateShield(e:TimerEvent){			var sheild_mc:MovieClip = this.getChildByName("sheild_mc") as MovieClip;			var power_mc:MovieClip = this.getChildByName("power_mc") as MovieClip;			sheild_mc.gotoAndStop(1);			power_Shield = false;			power_mc.gotoAndStop("normal");		}		public function Click (event:MouseEvent):void {			if (this.mouseX<stage.stageWidth && this.mouseX>0 && this.mouseY<stage.stageHeight && this.mouseY>0 && !gamePause) {			//var mainClass = (this.root as MovieClip);			bullets_txt.text = ""+bullets;			if (guntype == 0) {				mcClip.shoot = true;				//power_txt.text = "~";				//setTimeout(false_,10);				}else if(guntype == 1){						power_Machine_bullets--;						if (power_Machine_bullets<0) {							power_Machine = false;							power_Machine_bullets = 0;							guntype = 0;							//power_mc.gotoAndStop("normal");						}else{							mcClip.shoot = true;							//power_mc.gotoAndStop("Machine");							//setTimeout(false_,10);						}						power_txt.text = ""+power_Machine_bullets;				}else if(guntype == 2){						power_Multi_bullets--;						if (power_Multi_bullets<0) {							power_Multi = false;							power_Multi_bullets = 0;							guntype = 0;							//power_mc.gotoAndStop("normal");						}else{							mcClip.shoot = true;							//power_mc.gotoAndStop("Multi");							//setTimeout(false_,10);						}						power_txt.text = ""+power_Multi_bullets;				}else if(guntype == 3){						power_Lazer_bullets--;						if (power_Lazer_bullets<0) {							power_Lazer = false;							power_Lazer_bullets = 0;							guntype = 0;							//power_mc.gotoAndStop("normal");						}else{							mcClip.shoot = true;							//power_mc.gotoAndStop("Lazer");							//setTimeout(false_,10);						}						power_txt.text = ""+power_Lazer_bullets;																}else if(guntype == 4){						power_Fire_bullets--;						if (power_Fire_bullets<0) {							power_Fire = false;							power_Fire_bullets = 0;							guntype = 0;							//power_mc.gotoAndStop("normal");						}else{							mcClip.shoot = true;							//setTimeout(false_,10);						}						power_txt.text = ""+power_Fire_bullets;											}else{					mcClip.shoot = true;					//setTimeout(false_,10);				}				//mcClip.shoot = false;			}		}		public function false_(){			mcClip.shoot = false;		}		public function mouseout (event:MouseEvent):void {			mcClip.shoot = false;		}		public function movieClipToArray (mc) {			var return_ar:Array=new Array;			if (mc.numChildren != 0) {				var k:int=mc.numChildren;				while (k--) {					if (mc.getChildAt(k).hasOwnProperty("endPoint")) {						return_ar.push (mc.getChildAt(k));					}				}			}			return return_ar;		}		public function arrayedInsertionSort (a:Array):Array {			var k:Number=a.length;			var j:int;			var mc:MovieClip;			var val:MovieClip;			for (var i:int=1; i < k; i++) {				val=a[i];				j=i;				mc=a[int(j - 1)];				while (j > 0 && mc.y > val.y) {					a[j]=a[int(j - 1)];					j--;				}				a[j]=val;			}			return a;		}		public function short (ar,holder) {			for (var i:Number=0; i < ar.length; i++) {				holder.swapChildrenAt (holder.getChildIndex(ar[i]),i);				//trace (ar[i] + " : " + i + " : " + ar[i].y + " : holder: " + holder.name + " : " + top_mc.y + " top:down " + down_mc.y);			}		}		public function roundDecimalToPlace (num:Number, place:Number):Number {			var p:Number = Math.pow(10, Math.round(place));			return Math.round(num * p) / p;		}	}}