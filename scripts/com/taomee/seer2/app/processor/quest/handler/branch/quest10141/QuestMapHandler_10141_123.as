package com.taomee.seer2.app.processor.quest.handler.branch.quest10141
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10141_123 extends QuestMapHandler
   {
       
      
      private var _myself:Actor;
      
      private var _npc_mc:MovieClip;
      
      public function QuestMapHandler_10141_123(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            MonsterManager.hideAllMonster();
            MobileManager.getMobile(20,MobileType.NPC).visible = false;
            this.addNpcFirst();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            MonsterManager.hideAllMonster();
            MobileManager.getMobile(20,MobileType.NPC).visible = false;
            this.addNpcAgain();
         }
      }
      
      private function hideMyself() : void
      {
         this._myself = ActorManager.getActor();
         this._myself.hide();
      }
      
      private function addNpcFirst() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_1");
         _map.content.addChild(this._npc_mc);
         var _loc1_:MovieClip = this._npc_mc["suer"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSuerTalkFirstHandler);
      }
      
      private function onSuerTalkFirstHandler(param1:MouseEvent) : void
      {
         this.addMC();
      }
      
      private function addMC() : void
      {
         this.hideMyself();
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._npc_mc);
         MovieClipUtil.playMc(this._npc_mc,1,this._npc_mc.totalFrames,function():void
         {
            _myself.show();
            addNPC();
         },true);
      }
      
      private function addNPC() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_1");
         _map.content.addChild(this._npc_mc);
         var _loc1_:MovieClip = this._npc_mc["suer"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSuerTalkHandler);
      }
      
      private function onSuerTalkHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(20,"舒尔",[[2,"呜呜呜…我们的礼物被别人拿走了…圣诞节就要到了，这可怎么办呀！呜呜呜呜……"]],["先别急，发生什么事啦？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10141_0"),4,[[1,0]],function():void
            {
               QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptComplete);
               QuestManager.accept(_quest.id);
            });
         }]);
      }
      
      private function onAcceptComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         this.addNpcAgain();
      }
      
      private function addNpcAgain() : void
      {
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         this._npc_mc = _processor.resLib.getMovieClip("mc_1");
         _map.content.addChild(this._npc_mc);
         var _loc1_:MovieClip = this._npc_mc["suer"];
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onSuerTalkAgainHandler);
      }
      
      private function onSuerTalkAgainHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(20,"舒尔",[[2,"事情就是这样的。今年圣诞节我们肯定是最不受欢迎的小孩儿了…"]],["放心！星际使者肯定为你们伸张正义！"],[function():void
         {
            NpcDialog.show(20,"舒尔",[[4,"真的吗？我想如果我们在这里再放上一份礼物的话肯定能把他们吸引过来！"]],["恩！对！可是哪找礼物去呢？"],[function():void
            {
               NpcDialog.show(20,"舒尔",[[4,"这个…好心的星际使者…你应该也有准备圣诞节的礼物吧"]],["啊…这个嘛"],[function():void
               {
                  NpcDialog.show(20,"舒尔",[[4,"星际使者最好了！你一定会帮我们的是不是？你们是全宇宙最善良的机器人了…"]],["唉…好好好！那就用我的礼物吧。"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10141_0"),function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Complete);
                        QuestManager.completeStep(_quest.id,1);
                     },true,false,2);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onStep1Complete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
         SceneManager.changeScene(SceneType.LOBBY,10107);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.getMobile(20,MobileType.NPC).visible = true;
         MonsterManager.showAllMonster();
         if(this._npc_mc)
         {
            DisplayUtil.removeForParent(this._npc_mc);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptComplete);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Complete);
      }
   }
}
