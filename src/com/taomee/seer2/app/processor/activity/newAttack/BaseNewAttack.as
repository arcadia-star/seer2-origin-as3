package com.taomee.seer2.app.processor.activity.newAttack
{
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class BaseNewAttack
   {
      
      private static var _resourceLoader:ResourceLibraryLoader;
      
      private static var _resLib:ResourceLibrary;
       
      
      public function BaseNewAttack()
      {
         super();
      }
      
      protected function get checkTime() : Boolean
      {
         return false;
      }
      
      protected function playLoad(param1:Function) : void
      {
         var url:String = null;
         var loadComplete:Function = param1;
         if(_resourceLoader)
         {
            loadComplete();
         }
         else
         {
            url = String(URLUtil.getActivityAnimation("newAttack/newAttack"));
            _resourceLoader = new ResourceLibraryLoader(url);
            _resourceLoader.getLib(function(param1:ResourceLibrary):void
            {
               _resLib = param1;
               loadComplete();
            });
         }
      }
      
      protected function getMC(param1:String) : MovieClip
      {
         if(_resLib)
         {
            return _resLib.getMovieClip(param1);
         }
         return null;
      }
      
      protected function dispose() : void
      {
         _resourceLoader.dispose();
         _resourceLoader = null;
         _resLib.dispose();
         _resLib = null;
      }
   }
}
