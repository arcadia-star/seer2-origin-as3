package com.taomee.seer2.app.processor.quest.handler.activity.quest30025
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.MeshBeastReviveManager;
   import com.taomee.seer2.app.npc.NpcEvent;
   import com.taomee.seer2.app.npc.NpcManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootGridPanel;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class QuestMapHandler_30025_100 extends QuestMapHandler
   {
       
      
      private var pretendPetVec:Vector.<MovieClip>;
      
      private var standPet:MovieClip;
      
      private var appearsPet:MovieClip;
      
      private var escapePet:MovieClip;
      
      private var preTimeArr:Array;
      
      private var shootIndex:int;
      
      public function QuestMapHandler_30025_100(param1:QuestProcessor)
      {
         this.pretendPetVec = new Vector.<MovieClip>(3);
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         if(Boolean(DateUtil.isInHourScope(13,14,30,30)) && !DateUtil.isDay(2012,8,17))
         {
            super.processMapComplete();
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               this.shootIndex = MeshBeastReviveManager.instance.shootIndex;
               MeshBeastReviveManager.instance.preTimeArr[this.shootIndex] = TimeManager.getServerTime();
            }
            this.initQuest();
         }
      }
      
      private function initQuest() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.pretendPetVec.length)
         {
            this.pretendPetVec[_loc1_] = _processor.resLib.getMovieClip("PretendPet");
            this.pretendPetVec[_loc1_].addEventListener(MouseEvent.CLICK,this.onTips);
            this.pretendPetVec[_loc1_].buttonMode = true;
            _loc1_++;
         }
         this.pretendPetVec[0].x = 200;
         this.pretendPetVec[0].y = 200;
         this.pretendPetVec[1].x = 255;
         this.pretendPetVec[1].y = 430;
         this.pretendPetVec[2].x = 820;
         this.pretendPetVec[2].y = 400;
         this.standPet = _processor.resLib.getMovieClip("StandPet");
         this.escapePet = _processor.resLib.getMovieClip("EscapePet");
         this.appearsPet = _processor.resLib.getMovieClip("AppearsPet");
         this.standPet.addEventListener(MouseEvent.CLICK,this.onStartBattle);
         this.standPet.buttonMode = true;
         NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE,this.onQuestDia);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.chekTarget);
         this.checkShowPet();
      }
      
      protected function onTips(param1:MouseEvent) : void
      {
         NpcDialog.show(18,"斯力普",[[0,"打开头部射击功能，用深海漩涡射击它试试看。（到我这里可以领取深海漩涡道具哦”）"]],["知道了"]);
      }
      
      private function checkShowPet() : void
      {
         var _loc3_:int = 0;
         var _loc1_:uint = uint(TimeManager.getServerTime());
         this.preTimeArr = MeshBeastReviveManager.instance.preTimeArr;
         var _loc2_:int = 0;
         for(; _loc2_ < 3; _loc2_++)
         {
            _loc3_ = _loc1_ - this.preTimeArr[_loc2_];
            if(_loc3_ > 60)
            {
               this.pretendPetVec[_loc2_].gotoAndPlay(int(Math.random() * 100));
               _map.content.addChild(this.pretendPetVec[_loc2_]);
               continue;
            }
            _loc3_ = 60 - _loc3_;
            switch(this.shootIndex)
            {
               case 0:
                  Tick.instance.addRender(this.checkTime0,_loc3_ * 1000);
                  break;
               case 1:
                  Tick.instance.addRender(this.checkTime1,_loc3_ * 1000);
                  break;
               case 2:
                  Tick.instance.addRender(this.checkTime2,_loc3_ * 1000);
                  break;
            }
         }
      }
      
      private function checkTime0(param1:int) : void
      {
         this.pretendPetVec[0].gotoAndPlay(int(Math.random() * 100));
         _map.content.addChild(this.pretendPetVec[0]);
         Tick.instance.removeRender(this.checkTime0);
      }
      
      private function checkTime1(param1:int) : void
      {
         this.pretendPetVec[1].gotoAndPlay(int(Math.random() * 100));
         _map.content.addChild(this.pretendPetVec[1]);
         Tick.instance.removeRender(this.checkTime1);
      }
      
      private function checkTime2(param1:int) : void
      {
         this.pretendPetVec[2].gotoAndPlay(int(Math.random() * 100));
         _map.content.addChild(this.pretendPetVec[2]);
         Tick.instance.removeRender(this.checkTime2);
      }
      
      private function onStartBattle(param1:MouseEvent) : void
      {
         MeshBeastReviveManager.instance.shootIndex = this.shootIndex;
         FightManager.startFightWithWild(149);
      }
      
      private function onQuestDia(param1:NpcEvent) : void
      {
         var _loc2_:XML = null;
         if(param1.npcDefinition.id == 18)
         {
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE,this.onQuestDia);
            _loc2_ = <node type="quest" name="领取道具（会伪装的歌者）" params="getBullet"/>;
            param1.npcDefinition.resetFunctionalityData();
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_,0);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
         }
      }
      
      private function onUnit(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(event.content.params == "getBullet")
         {
            NpcDialog.show(18,"斯力普",[[0,"这是伊娃博士交给我的新发明深海漩涡，带上它用头部射击可疑的东西，能够让一切伪装还原。"]],["领取20颗","骗人的吧"],[function():void
            {
               ItemManager.requestItemList(getNum);
            }]);
         }
      }
      
      private function getNum() : void
      {
         var _loc1_:int = ItemManager.getItemQuantityByReferenceId(400227);
         if(_loc1_ > 10)
         {
            AlertManager.showAlert("背包最多容纳30颗,容量不足，使用后再来找我吧！");
         }
         else
         {
            SwapManager.swapItem(534,1,this.onSwapSuccess);
         }
      }
      
      private function onSwapSuccess(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         NpcDialog.show(18,"斯力普",[[0,"放在你的射击工具栏啦，对着场景中可疑的东西射击，就有机会找到神秘草系精灵。"]],["好的我去试试看吧！"]);
      }
      
      private function chekTarget(param1:ShootEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ShootInfo = param1.info;
         if(_loc2_.userID == ActorManager.actorInfo.id && _loc2_.id == 8)
         {
            _loc3_ = 0;
            while(_loc3_ < this.pretendPetVec.length)
            {
               if(this.pretendPetVec[_loc3_].hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
               {
                  ShootController.close();
                  ShootGridPanel.instance.hide();
                  DisplayUtil.removeForParent(this.pretendPetVec[_loc3_]);
                  this.appearsPet.x = this.pretendPetVec[_loc3_].x;
                  this.appearsPet.y = this.pretendPetVec[_loc3_].y;
                  _map.content.addChild(this.appearsPet);
                  MovieClipUtil.playMc(this.appearsPet,1,this.appearsPet.totalFrames,this.playResult,true);
                  this.shootIndex = _loc3_;
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function playResult() : void
      {
         var resultNum:int;
         DisplayUtil.removeForParent(this.appearsPet);
         resultNum = Math.random() * 2;
         if(resultNum == 0)
         {
            this.standPet.x = this.appearsPet.x;
            this.standPet.y = this.appearsPet.y;
            _map.content.addChild(this.standPet);
         }
         else
         {
            this.escapePet.x = this.appearsPet.x;
            this.escapePet.y = this.appearsPet.y;
            _map.content.addChild(this.escapePet);
            MovieClipUtil.playMc(this.escapePet,1,this.escapePet.totalFrames,function():void
            {
               DisplayUtil.removeForParent(escapePet);
               MeshBeastReviveManager.instance.preTimeArr[shootIndex] = TimeManager.getServerTime();
               switch(shootIndex)
               {
                  case 0:
                     Tick.instance.addRender(checkTime0,60000);
                     break;
                  case 1:
                     Tick.instance.addRender(checkTime1,60000);
                     break;
                  case 2:
                     Tick.instance.addRender(checkTime2,60000);
               }
            });
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         Tick.instance.removeRender(this.checkTime0);
         Tick.instance.removeRender(this.checkTime1);
         Tick.instance.removeRender(this.checkTime2);
         if(this.standPet)
         {
            this.standPet.removeEventListener(MouseEvent.CLICK,this.onStartBattle);
         }
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.chekTarget);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
      }
   }
}
