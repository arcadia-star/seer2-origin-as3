package com.taomee.seer2.app.processor.activity.christmas
{
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.scene.SceneManager;
   import flash.net.SharedObject;
   
   public class ChristmasInfoManager
   {
       
      
      public function ChristmasInfoManager()
      {
         super();
      }
      
      public static function getQuestStatus() : int
      {
         if(QuestManager.isComplete(10024) == false || QuestManager.isComplete(10025) == false || QuestManager.isComplete(10026) == false)
         {
            return 1;
         }
         if(QuestManager.getQuest(10027).status == QuestStatus.IN_PROGRESS)
         {
            return 4;
         }
         if(QuestManager.isComplete(10028) == false || QuestManager.isComplete(10029) == false || QuestManager.isComplete(10030) == false || QuestManager.isComplete(10031) == false)
         {
            return 2;
         }
         if(QuestManager.getQuest(10032).status == QuestStatus.IN_PROGRESS)
         {
            return 4;
         }
         if(QuestManager.isComplete(10033) == false || QuestManager.isComplete(10034) == false || QuestManager.isComplete(10035) == false || QuestManager.isComplete(10036) == false || QuestManager.isComplete(10037) == false)
         {
            return 3;
         }
         if(QuestManager.getQuest(10038).status == QuestStatus.IN_PROGRESS)
         {
            return 4;
         }
         if(QuestManager.getQuest(10038).status == QuestStatus.COMPLETE)
         {
            return 5;
         }
         return 5;
      }
      
      public static function addActivitySo() : void
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.CHRISTMAS_PANEL_CLICK);
         var _loc2_:String = generateDateKey();
         resetSharedObject(_loc1_,_loc2_);
      }
      
      public static function isActivitySo() : Boolean
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.CHRISTMAS_PANEL_CLICK);
         var _loc2_:String = generateDateKey();
         if(_loc1_.data[_loc2_] == null)
         {
            return false;
         }
         return true;
      }
      
      private static function resetSharedObject(param1:SharedObject, param2:String) : void
      {
         param1.clear();
         param1.data[param2] = new Object();
         SharedObjectManager.flush(param1);
      }
      
      private static function generateDateKey() : String
      {
         return SceneManager.active.mapModel.id.toString();
      }
   }
}
