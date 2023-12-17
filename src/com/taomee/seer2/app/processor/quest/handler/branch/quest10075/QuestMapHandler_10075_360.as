package com.taomee.seer2.app.processor.quest.handler.branch.quest10075
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10075_360 extends QuestMapHandler
   {
       
      
      private var shaEets:MovieClip;
      
      private var shaBlood:MovieClip;
      
      private var tips:MovieClip;
      
      public function QuestMapHandler_10075_360(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && !QuestManager.isComplete(_quest.id))
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAsccept);
            QuestManager.accept(_quest.id);
         }
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id))
         {
            this.showShaEets();
         }
      }
      
      private function onAsccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAsccept);
            this.showShaEets();
         }
      }
      
      private function showShaEets() : void
      {
         this.shaEets = _processor.resLib.getMovieClip("ShaEets");
         this.shaEets.gotoAndStop(1);
         this.shaEets.buttonMode = true;
         this.shaEets.addEventListener(MouseEvent.CLICK,this.showDia);
         this.shaBlood = _processor.resLib.getMovieClip("BloodBar");
         this.shaBlood.gotoAndStop(1);
         this.shaBlood.width = 52;
         this.shaBlood.height = 7.5;
         this.shaBlood.x = this.shaEets.x;
         this.shaBlood.y = 40;
         _map.content.addChild(this.shaEets);
         _map.content.addChild(this.shaBlood);
         this.tips = _processor.resLib.getMovieClip("TipsText");
         this.tips.stop();
      }
      
      private function showDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.shaEets.removeEventListener(MouseEvent.CLICK,this.showDia);
         MovieClipUtil.playMc(this.shaEets,1,this.shaEets.totalFrames,function():void
         {
            _map.front.addChild(tips);
            MovieClipUtil.playMc(tips,1,tips.totalFrames,function():void
            {
               _map.front.removeChild(tips);
               ShootController.addEventListener(ShootEvent.PLAY_END,chekTarget);
            },true);
         },true);
      }
      
      private function chekTarget(param1:ShootEvent) : void
      {
         var event:ShootEvent = param1;
         var info:ShootInfo = event.info;
         if(info.userID == ActorManager.actorInfo.id && this.shaEets.hitTestPoint(info.endPos.x,info.endPos.y))
         {
            this.shaBlood.gotoAndStop(2);
            NpcDialog.show(472,"沙伊特",[[3,"哼！我去找别的倒霉鬼！！"]],[" 我会孜孜不倦地阻止你的！"],[function():void
            {
               ShootController.removeEventListener(ShootEvent.PLAY_END,chekTarget);
               QuestManager.addEventListener(QuestEvent.COMPLETE,completeQuest);
               QuestManager.completeStep(_quest.id,1);
            }]);
         }
      }
      
      private function completeQuest(param1:QuestEvent) : void
      {
         if(param1.questId == 10075)
         {
            _map.content.removeChild(this.shaEets);
            _map.content.removeChild(this.shaBlood);
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.completeQuest);
            if(!QuestManager.isComplete(10076) || !QuestManager.isComplete(10077))
            {
               this.showActivePanel();
            }
         }
      }
      
      private function showActivePanel() : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NewTurnBeatPanel"),"正在打开面板...");
      }
      
      override public function processMapDispose() : void
      {
         if(this.shaEets)
         {
            this.shaEets.removeEventListener(MouseEvent.CLICK,this.showDia);
         }
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.chekTarget);
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAsccept);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.completeQuest);
      }
   }
}
