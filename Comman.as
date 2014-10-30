﻿package {	import flash.display.*;	import flash.events.*;	import flash.utils.getDefinitionByName;	import flash.display.BitmapData;	import flash.geom.ColorTransform;	import flash.geom.Matrix;	import flash.geom.Rectangle;	class Comman extends MovieClip {		public var mainClass:MovieClip;		var PARENT_REMOVED:String="parent_removed";		public function Comman() {			mainClass=this.root  as  MovieClip;			this.addEventListener(Event.ENTER_FRAME,doit);			this.addEventListener(PARENT_REMOVED,removeS);			this.addEventListener(Event.REMOVED_FROM_STAGE,removeS);		}		public function removeS(e:Event):void {			callChildEventRemoved();			this.removeEventListener(Event.ENTER_FRAME,doit);			this.removeEventListener(PARENT_REMOVED,removeS);			this.removeEventListener(Event.ENTER_FRAME,doit);		}		private function callChildEventRemoved():void {			var e:MovieClip=this  as  MovieClip;			var childlength:int=e.numChildren;			for (var i=0; i < childlength; i++) {				var c:MovieClip=e.getChildAt(i)  as  MovieClip;				if(c!=null){					if (c.hasEventListener(PARENT_REMOVED)) {						c.dispatchEvent(new Event(PARENT_REMOVED));					}				}			}		}		public function doit(e:Event):void {			if(stage!=null){				loopUntilRemoved(e);			}		}		public function loopUntilRemoved(e:Event):void {		}		public function getCollisionRect(target1:DisplayObject,target2:DisplayObject,commonParent:DisplayObjectContainer,pixelPrecise:Boolean=false,tolerance:int=255):Rectangle {			var rect1:Rectangle=target1.getBounds(commonParent);			var rect2:Rectangle=target2.getBounds(commonParent);			var intersectionRect:Rectangle=rect1.intersection(rect2);			if (! pixelPrecise) {				return intersectionRect;			}			intersectionRect.x=Math.floor(intersectionRect.x);			intersectionRect.y=Math.floor(intersectionRect.y);			intersectionRect.width=Math.ceil(intersectionRect.width);			intersectionRect.height=Math.ceil(intersectionRect.height);			if (intersectionRect.isEmpty()) {				return intersectionRect;			}			var parentXformInvert:Matrix=commonParent.transform.concatenatedMatrix.clone();			parentXformInvert.invert();			var target1Xform:Matrix=target1.transform.concatenatedMatrix.clone();			target1Xform.concat(parentXformInvert);			var target2Xform:Matrix=target2.transform.concatenatedMatrix.clone();			target2Xform.concat(parentXformInvert);			target1Xform.translate(- intersectionRect.x,- intersectionRect.y);			target2Xform.translate(- intersectionRect.x,- intersectionRect.y);			var bd:BitmapData=new BitmapData(intersectionRect.width,intersectionRect.height,false);			bd.draw(target1,target1Xform,new ColorTransform(1,1,1,1,255,-255,-255,tolerance),BlendMode.NORMAL);			bd.draw(target2,target2Xform,new ColorTransform(1,1,1,1,255,255,255,tolerance),BlendMode.DIFFERENCE);			var overlapRect:Rectangle=bd.getColorBoundsRect(0xffffffff,0xff00ffff);			overlapRect.offset(intersectionRect.x,intersectionRect.y);			return overlapRect;		}		public function point(clip1:MovieClip,clip2:MovieClip) {			if (clip2 == root) {				clip1.point_mc.rotation=Math.atan2(clip1.y - root.mouseY,clip1.x - root.mouseX) * 180 / Math.PI - 90;				return clip1.rotation;			} else {				clip1.rot=Math.atan2(clip1.y - clip2.y,clip1.x - clip2.x) * 180 / Math.PI - 90;				return clip1.rot;			}		}	}}