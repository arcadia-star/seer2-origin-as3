package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.controls.MinorToolBar;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.constant.QuestType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import org.taomee.bean.BaseBean;
   
   public class QuestCompleteBean extends BaseBean
   {
       
      
      private var _qiLinQuests:Array;
      
      public function QuestCompleteBean()
      {
         this._qiLinQuests = [10146,10171,10172,10152,10153,10154,10155,10156,10157,10173,10174];
         super();
         QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         finish();
      }
      
      public static function getRecommendQuestVec() : Vector.<Quest>
      {
         var resultVec:Vector.<Quest>;
         var tmpVec:Vector.<Quest> = null;
         var questVec:Vector.<Quest> = null;
         tmpVec = new Vector.<Quest>();
         questVec = QuestManager.getQuestListByType(QuestType.CHAPTER).concat(QuestManager.getQuestListByType(QuestType.STORY));
         questVec.forEach(function(param1:Quest, param2:int, param3:Vector.<Quest>):void
         {
            if(param1.status == QuestStatus.IN_PROGRESS)
            {
               tmpVec.push(param1);
            }
         });
         questVec.forEach(function(param1:Quest, param2:int, param3:Vector.<Quest>):void
         {
            if(!param1.isNewOnline && param1.status == QuestStatus.ACCEPTABLE)
            {
               tmpVec.push(param1);
            }
         });
         questVec = QuestManager.getQuestList();
         questVec.forEach(function(param1:Quest, param2:int, param3:Vector.<Quest>):void
         {
            if(Boolean(param1.isNewOnline) && param1.status == QuestStatus.ACCEPTABLE)
            {
               tmpVec.push(param1);
            }
         });
         resultVec = new Vector.<Quest>();
         if(tmpVec.length > 0)
         {
            resultVec.push(tmpVec[length - 1]);
         }
         return resultVec;
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         if(getRecommendQuestVec().length > 0)
         {
            MinorToolBar.showShine();
         }
         this.startQiLin(param1.questId);
      }
      
      private function startQiLin(param1:uint) : void
      {
         if(this._qiLinQuests.indexOf(param1) != -1)
         {
            SwapManager.swapItem(3286);
         }
      }
   }
}
