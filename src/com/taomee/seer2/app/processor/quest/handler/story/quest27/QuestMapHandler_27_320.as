package com.taomee.seer2.app.processor.quest.handler.story.quest27
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_27_320 extends QuestMapHandler
   {
       
      
      private var _sha:MovieClip;
      
      public function QuestMapHandler_27_320(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false)
         {
            this.createAcceptNpc();
            this._sha.addEventListener(MouseEvent.CLICK,this.onAcceptClick);
         }
         else if(QuestManager.isAccepted(_quest.id) && QuestManager.isComplete(_quest.id) == false)
         {
            this.createInprogressNpc();
            this._sha.addEventListener(MouseEvent.CLICK,this.onInterimNpcClick);
         }
      }
      
      private function onAcceptClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(56,"神爪财团老板",[[0,"地月的粗鬼居然要找我决战？真是没有经济头脑的人，当前稳步发展经济才是最重要的……！"]],["稳步发展经济……"],[function():void
         {
            NpcDialog.show(56,"神爪财团老板",[[0,"前几天……我的贴身秘书给我送来一封密函，神月那个粗鬼，居然挑衅我……！"]],["到底说什么呢……"],[function():void
            {
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("27_0"),1,[[1,0]],function():void
               {
                  NpcDialog.show(56,"神爪财团老板",[[0,"所以，我决定到约定的地点好好教教他！这位朋友，看你头脑很清晰，帮我传个口信吧！以后在沙爪消费我给你打折。"]],["（……）"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.ACCEPT,onAccepted);
                     QuestManager.accept(_quest.id);
                  }]);
               });
            }]);
         }]);
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
            this._sha.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this.onInterimNpcClick(null);
         }
      }
      
      private function onInterimNpcClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(56,"神爪财团老板",[[0,"汪总管还在淘米市场统计报表吗？让他通知所有经理，管好自己手头的工作，我不在的时候不许有任何闪失。"]],["（唉，去淘米市场找汪总管。）"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,330);
         }]);
      }
      
      private function createInprogressNpc() : void
      {
         this._sha = _processor.resLib.getMovieClip("npc_0_1");
         this._sha.x = 650;
         this._sha.y = 345;
         _map.content.addChild(this._sha);
         this._sha.buttonMode = true;
      }
      
      private function createAcceptNpc() : void
      {
         this._sha = _processor.resLib.getMovieClip("npc_0_0");
         this._sha.x = 650;
         this._sha.y = 345;
         _map.content.addChild(this._sha);
         this._sha.buttonMode = true;
      }
      
      private function clearNpc() : void
      {
         if(this._sha)
         {
            this._sha.removeEventListener(MouseEvent.CLICK,this.onAcceptClick);
            this._sha.removeEventListener(MouseEvent.CLICK,this.onInterimNpcClick);
            DisplayObjectUtil.removeFromParent(this._sha);
            this._sha = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.clearNpc();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         super.processMapDispose();
      }
   }
}
