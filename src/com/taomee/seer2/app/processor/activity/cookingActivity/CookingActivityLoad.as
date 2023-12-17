package com.taomee.seer2.app.processor.activity.cookingActivity
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class CookingActivityLoad
   {
      
      private static var _instance:CookingActivityLoad;
      
      private static var _resourceLoader:ResourceLibraryLoader;
      
      private static var _resLib:ResourceLibrary;
       
      
      public function CookingActivityLoad()
      {
         super();
      }
      
      public static function get instance() : CookingActivityLoad
      {
         if(_instance == null)
         {
            _instance = new CookingActivityLoad();
         }
         return _instance;
      }
      
      public function isTimerLater() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:uint = new Date(2012,_loc1_.month,_loc1_.date,16,1).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc2_)
         {
            return false;
         }
         return true;
      }
      
      public function get checkTime() : Boolean
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(DateUtil.inInDateScope(_loc1_.day,13,0,16,1))
         {
            return true;
         }
         return false;
      }
      
      public function playLoad(param1:Function) : void
      {
         var url:String = null;
         var loadComplete:Function = param1;
         if(_resourceLoader)
         {
            loadComplete();
         }
         else
         {
            url = String(URLUtil.getActivityAnimation("cookingActivity/cookingActivity"));
            _resourceLoader = new ResourceLibraryLoader(url);
            _resourceLoader.getLib(function(param1:ResourceLibrary):void
            {
               _resLib = param1;
               loadComplete();
            });
         }
      }
      
      public function getMC(param1:String) : MovieClip
      {
         if(_resLib)
         {
            return _resLib.getMovieClip(param1);
         }
         return null;
      }
   }
}
