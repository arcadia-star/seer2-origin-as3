package com.taomee.seer2.app.processor.quest.handler.branch.quest10125
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_46;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_10125_Peddle extends QuestMapHandler
   {
       
      
      protected var npcid:int;
      
      private var _npc:Mobile;
      
      protected var buffPosition:int;
      
      private var num:int;
      
      private var num1:int;
      
      private var num2:int;
      
      private var num3:int;
      
      private var num4:int;
      
      private var anotherNum:int = 0;
      
      public function QuestMapHandler_10125_Peddle(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         MonsterManager.showAllMonster();
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(10125,5) && !QuestManager.isStepComplete(10125,6))
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.NEWPLAYER_BUFF,this.getBuff);
            MonsterManager.hideAllMonster();
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this.num != 1)
         {
            if(this.npcid == 23)
            {
               NpcDialog.show(this.npcid,"神谕祭司",[[0,"哦！你是在为阿宝筹集环游世界的经费？嗯，这些小东西还挺精致的，好吧，那我就买啦！"]],["谢谢大祭司。"],[function():void
               {
                  num = 1;
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF,buffPosition,1);
                  checkFull();
               }]);
            }
            if(this.npcid == 28)
            {
               NpcDialog.show(this.npcid,"银月兔兔",[[1,"哇，这些小挂件好可爱哦，我喜欢！  "]],["嘿嘿，我的手艺不错吧！"],[function():void
               {
                  num = 1;
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF,buffPosition,1);
                  checkFull();
               }]);
            }
            if(this.npcid == 31)
            {
               NpcDialog.show(this.npcid,"巴尔卡",[[0,"……你觉得这些小东西挂在我身上好看么？我怎么感觉怪怪的……好啦！好啦！看你这么坚持，我就买两个吧。  "]],["巴尔卡大气啊！"],[function():void
               {
                  num = 1;
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF,buffPosition,1);
                  checkFull();
               }]);
            }
            if(this.npcid == 27)
            {
               NpcDialog.show(this.npcid,"占卜婆婆",[[0,"我是如此的青春丽质，这些小可爱饰品我不佩戴，谁还能佩戴呢！哈哈哈！"]],["…………"],[function():void
               {
                  num = 1;
                  ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF,buffPosition,1);
                  checkFull();
               }]);
            }
         }
         event.stopImmediatePropagation();
      }
      
      private function checkFull() : void
      {
         if(this.anotherNum + this.num > 3)
         {
            NpcDialog.show(400,"我",[[0,"大家都太给力啦！哈哈！"]],["返回幽静浅滩！"],[function():void
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF,buffPosition,1);
               SceneManager.changeScene(SceneType.LOBBY,220);
            }]);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("ABaoPeddlePanel"));
         }
      }
      
      private function getBuff(param1:ServerBuffer) : void
      {
         this.num1 = param1.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_23);
         this.num2 = param1.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_28);
         this.num3 = param1.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_31);
         this.num4 = param1.readDataAtPostion(ServerBufferPosition_46.SCALE_STATE_27);
         switch(this.buffPosition)
         {
            case 12:
               this.num = this.num1;
               this.anotherNum = this.num2 + this.num3 + this.num4;
               break;
            case 13:
               this.num = this.num2;
               this.anotherNum = this.num1 + this.num3 + this.num4;
               break;
            case 14:
               this.num = this.num3;
               this.anotherNum = this.num2 + this.num1 + this.num4;
               break;
            case 15:
               this.num = this.num4;
               this.anotherNum = this.num2 + this.num3 + this.num1;
         }
         if(this.num < 1)
         {
            this._npc = MobileManager.getMobile(this.npcid,MobileType.NPC);
            this._npc.removeOverHeadMark();
            this._npc.addOverHeadMark(new AcceptableMark());
            this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick,false,500);
         }
      }
   }
}
