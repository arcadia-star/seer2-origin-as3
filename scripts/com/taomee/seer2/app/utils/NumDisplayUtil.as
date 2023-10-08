package com.taomee.seer2.app.utils
{
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class NumDisplayUtil
   {
       
      
      public function NumDisplayUtil()
      {
         super();
      }
      
      public static function getNumDisplay(param1:int, param2:String, param3:int) : Sprite
      {
         var _loc7_:MovieClip = null;
         var _loc4_:Sprite = new Sprite();
         var _loc5_:String = param1.toString();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            (_loc7_ = UIManager.getMovieClip(param2 + _loc5_.charAt(_loc6_))).x = _loc6_ * param3;
            _loc4_.addChild(_loc7_);
            _loc6_++;
         }
         return _loc4_;
      }
   }
}
