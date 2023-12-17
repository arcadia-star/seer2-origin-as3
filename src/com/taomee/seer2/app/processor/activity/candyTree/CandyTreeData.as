package com.taomee.seer2.app.processor.activity.candyTree
{
   import com.taomee.seer2.core.manager.TimeManager;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class CandyTreeData
   {
      
      public static var isCanWater:uint;
      
      public static var upCount:uint;
      
      public static var startTime:uint;
      
      public static var timeMC:MovieClip;
      
      public static var currStatus:uint;
      
      private static var timeList:Vector.<uint> = Vector.<uint>([1,60,240,900,1800,1800,1800,1800,1800,1800]);
       
      
      public function CandyTreeData()
      {
         super();
      }
      
      public static function getOverTime(param1:uint, param2:uint) : uint
      {
         var _loc4_:uint = 0;
         var _loc3_:uint = TimeManager.getPrecisionServerTime() - param2;
         if(_loc3_ >= timeList[param1])
         {
            _loc4_ = 10000;
         }
         else
         {
            _loc4_ = uint(timeList[param1] - _loc3_);
         }
         return _loc4_;
      }
      
      public static function updateTime(param1:uint, param2:uint) : void
      {
         var _loc3_:TextField = timeMC["txt"];
         var _loc4_:MovieClip = timeMC["content"];
         var _loc5_:TextField = timeMC["txt2"];
         var _loc6_:uint = timeList[param1];
         var _loc7_:* = "";
         _loc7_ = (_loc7_ = (_loc7_ = String(uint(param2 / 60))) + ":") + String(param2 % 60);
         _loc3_.text = _loc7_;
         _loc5_.text = "离成熟还有0小时" + (uint(param2 / 60) + 1) + "分";
         _loc4_.scaleX = param2 / _loc6_;
      }
   }
}
