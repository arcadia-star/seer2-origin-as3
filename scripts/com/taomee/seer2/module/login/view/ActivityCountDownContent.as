package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.config.ActivityCountDownConfig;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class ActivityCountDownContent
   {
      
      private static var _txt:TextField;
       
      
      public function ActivityCountDownContent()
      {
         super();
      }
      
      public static function setup(param1:MovieClip) : void
      {
         var _loc7_:Date = null;
         _txt = param1["txt"];
         if(ActivityCountDownConfig.getIsOpen())
         {
            param1.visible = true;
            var _loc2_:Array = ActivityCountDownConfig.getActivityDate();
            var _loc3_:Date = new Date(_loc2_[0],_loc2_[1] - 1,_loc2_[2]);
            var _loc4_:uint = 0;
            var _loc5_:Date = new Date();
            var _loc6_:uint = 0;
            var _loc8_:int = 0;
            while(_loc8_ < _loc3_.month)
            {
               _loc7_ = new Date(_loc2_[0],_loc8_);
               _loc4_ += _loc7_.dateUTC;
               _loc8_++;
            }
            _loc4_ += _loc3_.date;
            var _loc9_:int = 0;
            while(_loc9_ < _loc5_.month)
            {
               _loc7_ = new Date(_loc5_.fullYear,_loc9_);
               _loc6_ += _loc7_.dateUTC;
               _loc9_++;
            }
            if((_loc6_ += _loc5_.date) >= _loc4_)
            {
               _txt.text = "0";
            }
            else
            {
               _txt.text = (_loc4_ - _loc6_).toString();
            }
            return;
         }
         param1.visible = false;
      }
   }
}
