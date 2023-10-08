package com.greensock.easing
{
   import com.greensock.TweenLite;
   
   public class FastEase
   {
       
      
      public function FastEase()
      {
         super();
      }
      
      public static function activateEase(param1:Function, param2:int, param3:uint) : void
      {
         TweenLite.fastEaseLookup[param1] = [param2,param3];
      }
      
      public static function activate(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = int(param1.length);
         while(_loc2_--)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_.hasOwnProperty("power"))
            {
               activateEase(_loc3_.easeIn,1,_loc3_.power);
               activateEase(_loc3_.easeOut,2,_loc3_.power);
               activateEase(_loc3_.easeInOut,3,_loc3_.power);
               if(_loc3_.hasOwnProperty("easeNone"))
               {
                  activateEase(_loc3_.easeNone,1,0);
               }
            }
         }
      }
   }
}
