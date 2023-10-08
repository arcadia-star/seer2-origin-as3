package com.taomee.seer2.app.processor.activity.mascot
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class Mascot2Animation
   {
      
      private static var _mc:MovieClip;
      
      private static var _isLoad:Boolean;
      
      private static var _fun:Function;
       
      
      public function Mascot2Animation()
      {
         super();
      }
      
      public static function startLoader(param1:Function) : void
      {
         _fun = param1;
         if(_isLoad)
         {
            _fun();
            _fun = null;
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("mascot/mascot2"),LoadType.SWF,onResLoaded);
         }
      }
      
      private static function onResLoaded(param1:ContentInfo) : void
      {
         _mc = param1.content as MovieClip;
         _fun();
         _fun = null;
      }
      
      public static function getMC(param1:String) : MovieClip
      {
         return _mc[param1];
      }
   }
}
