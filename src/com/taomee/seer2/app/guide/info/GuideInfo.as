package com.taomee.seer2.app.guide.info
{
   import flash.geom.Rectangle;
   
   public class GuideInfo
   {
       
      
      public var parentIndex:int;
      
      public var targetIndex:int;
      
      public var isNext:Boolean;
      
      public var isAuto:Boolean;
      
      public var rectList:Vector.<Rectangle>;
      
      public var tipInfo:TipInfo;
      
      public var dir:int;
      
      public var pointX:Number;
      
      public var pointY:Number;
      
      public var targetWidth:Number;
      
      public var targetHeight:Number;
      
      public var isLockY:Boolean = false;
      
      public var isModule:Boolean = false;
      
      public var isLockX:Boolean = false;
      
      public var moduleWidth:Number;
      
      public var moduleHight:Number;
      
      public function GuideInfo()
      {
         super();
      }
   }
}
