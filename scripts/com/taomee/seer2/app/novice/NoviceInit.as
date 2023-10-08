package com.taomee.seer2.app.novice
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   
   public class NoviceInit
   {
       
      
      public function NoviceInit()
      {
         super();
      }
      
      public static function exec() : Boolean
      {
         var _loc1_:Quest = QuestManager.getQuest(1);
         if(_loc1_.status == QuestStatus.IN_PROGRESS)
         {
            StatisticsManager.newSendNovice("_newtrans_","fInterGameSucc","前端进入游戏主界面");
            if(_loc1_.isStepCompletable(1))
            {
               StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","传送至教官室（开始加载）");
               SceneManager.changeScene(SceneType.NOVICE,6);
            }
            else if(_loc1_.isStepCompletable(2))
            {
               SceneManager.changeScene(SceneType.NOVICE,6);
            }
            else if(_loc1_.isStepCompletable(3))
            {
               SceneManager.changeScene(SceneType.NOVICE,4);
            }
            else if(_loc1_.isStepCompletable(4))
            {
               SceneManager.changeScene(SceneType.NOVICE,5);
            }
            return true;
         }
         return false;
      }
   }
}
