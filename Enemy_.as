﻿package {	import flash.display.MovieClip;	import flash.events.*;	import bar_mc;	import GameClass;	import flash.utils.getDefinitionByName;	import Comman;	class Enemy_ extends Comman{		public var speed:Number;		var numDoors:Number;		var color:String;		public var bar:bar_mc;		public var press:Boolean;		public var per:Number;		public var _type:Number;		private var _b:Number;		public var removed:Boolean;		public function Enemy_() {			speed = 1;			_b = 0;			removed = false;			_type = 0;			per = 100;			bar = new bar_mc();			bar.name = "bar_mc";			var holder_mc:MovieClip = this.getChildByName("holder_mc") as MovieClip;			bar.x = holder_mc.x;			bar.y = holder_mc.y;			this.addChild(bar);			this.mouseChildren = false;			this.press  = false;					}		override public function loopUntilRemoved(e:Event):void{			var mainClass = (this.root as MovieClip);			if (!mainClass.main_mc.gamePause) {				var bar_mc:MovieClip = e.target.getChildByName("bar_mc") as MovieClip;				bar_mc.gotoAndStop(Math.floor ((bar_mc.totalFrames * per) / 100));				if (per<=1 && !removed) {					per = 1;					removed = true;					mainClass.main_mc.power_mc.calculate_Power();					mainClass.main_mc.doit(this);				}			}		}	}}