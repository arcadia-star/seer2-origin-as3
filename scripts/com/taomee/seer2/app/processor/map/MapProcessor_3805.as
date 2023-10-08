package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_3805 extends TitleMapProcessor
   {
       
      
      private var _582:MovieClip;
      
      public function MapProcessor_3805(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._582 = _map.content["shixiang"];
         this._582.addEventListener(MouseEvent.CLICK,this.on582Click);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(QuestManager.isStepComplete(10190,1) && !QuestManager.isComplete(10190))
         {
            this.handleStep();
         }
      }
      
      private function on582Click(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(QuestManager.isAccepted(10190) && !QuestManager.isStepComplete(10190,1))
         {
            NpcDialog.show(582,"月灵兽石像",[[0,"移动8块石板，将它组合成一个完整的图形就可以解开机关的秘密。"]],["让我们开始吧！","再研究一下"],[function():void
            {
               ModuleManager.showModule(URLUtil.getAppModule("JigsawGame"),"");
            }]);
         }
      }
      
      private function onStepComplete(param1:QuestEvent = null) : void
      {
         if(param1.questId == 10190 && param1.stepId == 1)
         {
            this.handleStep();
         }
      }
      
      private function handleStep() : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10190_1"),function():void
         {
            NpcDialog.show(400,"小赛尔",[[4,"哇！原来你就是地月氏族的守护兽“月灵兽”啊~"]],["太好了。"],[function():void
            {
               NpcDialog.show(582,"月灵兽",[[0,"是的，你把沉睡已久的我再次唤醒了。"]],["唤醒了？你睡了多久？"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10190_2"),function():void
                  {
                     NpcDialog.show(400,"小赛尔",[[2,"原来氏族间的争斗，使得你长眠不醒啊？"]],["是的"],[function():void
                     {
                        NpcDialog.show(582,"月灵兽",[[0,"既然我已经从沉睡中醒来，就必须要想办法使得两个民族从归于好，小赛尔，你愿意帮助我吗？"]],["当然愿意啦"],[function():void
                        {
                           NpcDialog.show(582,"月灵兽",[[0,"但是在这之前，我还必须对你进行考验，只有强大的赛尔，才能够和我一起去挽回两个氏族之间的和平。"]],["我愿意接受你的考验"],[function():void
                           {
                              NpcDialog.show(582,"月灵兽",[[0,"那你先去准备下吧，我会等待你的挑战。"]],["好的"],[function():void
                              {
                                 QuestManager.completeStep(10190,2);
                              }]);
                           }]);
                        }]);
                     }]);
                  },true,false);
               }]);
            }]);
         },true,false);
      }
      
      override public function dispose() : void
      {
         this._582.removeEventListener(MouseEvent.CLICK,this.on582Click);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         super.dispose();
      }
   }
}
