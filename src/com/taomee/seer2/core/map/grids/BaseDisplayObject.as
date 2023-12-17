package com.taomee.seer2.core.map.grids
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Rectangle;
   
   public class BaseDisplayObject extends Sprite
   {
       
      
      public function BaseDisplayObject()
      {
         super();
         this.addEventListener(Event.REMOVED,this.removedFun);
      }
      
      override public function get alpha() : Number
      {
         return super.alpha;
      }
      
      override public function set alpha(param1:Number) : void
      {
         super.alpha = param1;
      }
      
      public function get baselinePosition() : Number
      {
         return 0;
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
      }
      
      override public function get cacheAsBitmap() : Boolean
      {
         return super.cacheAsBitmap;
      }
      
      override public function set cacheAsBitmap(param1:Boolean) : void
      {
         super.cacheAsBitmap = param1;
      }
      
      override public function get mask() : DisplayObject
      {
         return super.mask;
      }
      
      override public function set mask(param1:DisplayObject) : void
      {
         super.mask = param1;
      }
      
      public function get document() : Object
      {
         return null;
      }
      
      public function set document(param1:Object) : void
      {
      }
      
      public function get enabled() : Boolean
      {
         return false;
      }
      
      public function set enabled(param1:Boolean) : void
      {
      }
      
      public function get measuredHeight() : Number
      {
         return 0;
      }
      
      public function get explicitHeight() : Number
      {
         return 0;
      }
      
      public function set explicitHeight(param1:Number) : void
      {
      }
      
      public function get explicitMaxHeight() : Number
      {
         return 0;
      }
      
      public function get measuredWidth() : Number
      {
         return 0;
      }
      
      public function get explicitMaxWidth() : Number
      {
         return 0;
      }
      
      public function get explicitMinHeight() : Number
      {
         return 0;
      }
      
      public function get explicitMinWidth() : Number
      {
         return 0;
      }
      
      override public function get name() : String
      {
         return super.name;
      }
      
      override public function set name(param1:String) : void
      {
         super.name = param1;
      }
      
      public function get explicitWidth() : Number
      {
         return 0;
      }
      
      public function set explicitWidth(param1:Number) : void
      {
      }
      
      override public function get parent() : DisplayObjectContainer
      {
         return super.parent;
      }
      
      public function get focusPane() : Sprite
      {
         return null;
      }
      
      public function set focusPane(param1:Sprite) : void
      {
      }
      
      override public function get scaleX() : Number
      {
         return super.scaleX;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
      }
      
      public function get includeInLayout() : Boolean
      {
         return false;
      }
      
      public function set includeInLayout(param1:Boolean) : void
      {
      }
      
      public function get isPopUp() : Boolean
      {
         return false;
      }
      
      public function set isPopUp(param1:Boolean) : void
      {
      }
      
      override public function get scaleY() : Number
      {
         return super.scaleY;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get maxHeight() : Number
      {
         return 0;
      }
      
      override public function get x() : Number
      {
         return super.x;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
      }
      
      public function get maxWidth() : Number
      {
         return 0;
      }
      
      override public function get y() : Number
      {
         return super.y;
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
      }
      
      public function get measuredMinHeight() : Number
      {
         return 0;
      }
      
      public function set measuredMinHeight(param1:Number) : void
      {
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      public function get measuredMinWidth() : Number
      {
         return 0;
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
      }
      
      override public function get width() : Number
      {
         return super.width;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
      }
      
      public function set measuredMinWidth(param1:Number) : void
      {
      }
      
      public function get minHeight() : Number
      {
         return 0;
      }
      
      public function move(param1:Number, param2:Number) : void
      {
      }
      
      override public function dispatchEvent(param1:Event) : Boolean
      {
         return super.dispatchEvent(param1);
      }
      
      public function get minWidth() : Number
      {
         return 0;
      }
      
      public function get owner() : DisplayObjectContainer
      {
         return null;
      }
      
      public function set owner(param1:DisplayObjectContainer) : void
      {
      }
      
      public function setActualSize(param1:Number, param2:Number) : void
      {
      }
      
      override public function hasEventListener(param1:String) : Boolean
      {
         return super.hasEventListener(param1);
      }
      
      public function get percentHeight() : Number
      {
         return 0;
      }
      
      public function set percentHeight(param1:Number) : void
      {
      }
      
      public function get percentWidth() : Number
      {
         return 0;
      }
      
      public function set percentWidth(param1:Number) : void
      {
      }
      
      override public function willTrigger(param1:String) : Boolean
      {
         return super.willTrigger(param1);
      }
      
      override public function get opaqueBackground() : Object
      {
         return super.opaqueBackground;
      }
      
      override public function set opaqueBackground(param1:Object) : void
      {
         super.opaqueBackground = param1;
      }
      
      override public function get scrollRect() : Rectangle
      {
         return super.scrollRect;
      }
      
      override public function set scrollRect(param1:Rectangle) : void
      {
         super.scrollRect = param1;
      }
      
      public function get tweeningProperties() : Array
      {
         return null;
      }
      
      public function set tweeningProperties(param1:Array) : void
      {
      }
      
      public function initialize() : void
      {
      }
      
      public function parentChanged(param1:DisplayObjectContainer) : void
      {
      }
      
      public function getExplicitOrMeasuredWidth() : Number
      {
         return 0;
      }
      
      public function getExplicitOrMeasuredHeight() : Number
      {
         return 0;
      }
      
      public function setVisible(param1:Boolean, param2:Boolean = false) : void
      {
      }
      
      public function owns(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      protected function removedFun(param1:Event) : void
      {
         HeptaFishGC.gc();
      }
      
      protected function dispatch(param1:Class, param2:String, param3:Object = null) : void
      {
         var _loc4_:Event = new param1(param2,param3);
         this.dispatchEvent(_loc4_);
      }
      
      protected function loadingHandler(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      protected function ioErrorHandler(param1:IOErrorEvent) : void
      {
         this.dispatchEvent(param1);
      }
   }
}
