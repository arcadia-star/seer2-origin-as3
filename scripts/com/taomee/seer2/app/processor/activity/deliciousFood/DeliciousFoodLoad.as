package com.taomee.seer2.app.processor.activity.deliciousFood
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class DeliciousFoodLoad
   {
      
      private static var _instance:com.taomee.seer2.app.processor.activity.deliciousFood.DeliciousFoodLoad;
       
      
      private var _resourceLoader:ResourceLibraryLoader;
      
      private var _resLib:ResourceLibrary;
      
      public function DeliciousFoodLoad()
      {
         super();
      }
      
      public static function get instance() : com.taomee.seer2.app.processor.activity.deliciousFood.DeliciousFoodLoad
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.processor.activity.deliciousFood.DeliciousFoodLoad();
         }
         return _instance;
      }
      
      public function get checkTime() : Boolean
      {
         if(DateUtil.isInTime(new Date(2013,10,8),new Date(2013,10,10,14,30)))
         {
            if(DateUtil.isInHourScope(13,14,30,30))
            {
               return true;
            }
         }
         return false;
      }
      
      public function playLoad(param1:Function) : void
      {
         var url:String = null;
         var loadComplete:Function = param1;
         if(this._resourceLoader)
         {
            loadComplete();
         }
         else
         {
            url = String(URLUtil.getActivityAnimation("deliciousFood/deliciousFood"));
            this._resourceLoader = new ResourceLibraryLoader(url);
            this._resourceLoader.getLib(function(param1:ResourceLibrary):void
            {
               _resLib = param1;
               loadComplete();
            });
         }
      }
      
      public function getMC(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return this._resLib.getMovieClip(param1);
         }
         return null;
      }
   }
}
