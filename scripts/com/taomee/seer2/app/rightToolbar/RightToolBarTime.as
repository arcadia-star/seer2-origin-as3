package com.taomee.seer2.app.rightToolbar
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class RightToolBarTime
   {
       
      
      private var _timeMC:MovieClip;
      
      public function RightToolBarTime()
      {
         super();
      }
      
      public function getTimeMC(param1:Function) : void
      {
         var loadComplete:Function = param1;
         if(this._timeMC)
         {
            loadComplete(this._timeMC);
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("rightToolBarTime"),LoadType.SWF,function(param1:ContentInfo):void
            {
               _timeMC = (param1.content as MovieClip)["time"];
               loadComplete(_timeMC);
            });
         }
      }
   }
}
