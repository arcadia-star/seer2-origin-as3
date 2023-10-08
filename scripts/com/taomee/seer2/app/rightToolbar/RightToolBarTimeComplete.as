package com.taomee.seer2.app.rightToolbar
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class RightToolBarTimeComplete
   {
       
      
      private var _timeComplete:MovieClip;
      
      public function RightToolBarTimeComplete()
      {
         super();
      }
      
      public function getTimeCompleteMC(param1:Function) : void
      {
         var loadComplete:Function = param1;
         if(this._timeComplete)
         {
            loadComplete(this._timeComplete);
         }
         else
         {
            QueueLoader.load(URLUtil.getActivityAnimation("rightToolbarTimeComplete"),LoadType.SWF,function(param1:ContentInfo):void
            {
               _timeComplete = (param1.content as MovieClip)["timeComplete"];
               loadComplete(_timeComplete);
            });
         }
      }
   }
}
