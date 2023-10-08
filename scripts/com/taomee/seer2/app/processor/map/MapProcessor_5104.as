package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   
   public class MapProcessor_5104 extends YueChapter1MapProcessor
   {
       
      
      public function MapProcessor_5104(param1:MapModel)
      {
         super(param1);
         if(param1.front["activityDialogPanel"])
         {
            param1.front["activityDialogPanel"].visible = false;
         }
         if(param1.front["activityVoidPanel"])
         {
            param1.front["activityVoidPanel"].visible = false;
         }
      }
   }
}
