package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.quest.QuestManager;
   
   public class HalloweenManager
   {
       
      
      public function HalloweenManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         if(QuestManager.isCanAccepted(10130))
         {
            QuestManager.accept(10130);
         }
      }
   }
}
