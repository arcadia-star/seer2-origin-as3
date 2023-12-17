package com.taomee.seer2.app.processor.quest.handler.activity.quest30023
{
   import com.taomee.seer2.app.actor.attach.PetKingTeamAttach;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.constant.FunctionalityType;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.CustomUnit;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.events.Event;
   
   public class QuestMapHandler_30023_10 extends QuestMapHandler
   {
      
      public static var whichTeam:Number = -1;
      
      public static const SIGN:String = "i_am_commissary_30023_10";
       
      
      private var _unit:BaseUnit;
      
      public function QuestMapHandler_30023_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.joinWhichTeam();
         }
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onClickDialog);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
      }
      
      private function onDialogShow(param1:Event) : void
      {
         var _loc2_:BaseUnit = new CustomUnit(FunctionalityType.QUEST,"我是宣传委员",SIGN);
         if(QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id,1))
         {
            this.joinWhichTeam();
            DialogPanel.functionalityBox.addUnit(_loc2_);
         }
      }
      
      private function requestItem() : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.requestItemSuccess);
         ItemManager.requestSpecialItemList();
      }
      
      private function requestItemSuccess(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.requestItemSuccess);
         this.joinWhichTeam();
      }
      
      private function joinWhichTeam() : void
      {
         if(QuestManager.isAccepted(_quest.id))
         {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onClickDialog);
         }
      }
      
      private function onClickDialog(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(PetKingTeamAttach.myTeamIndex == 1)
         {
            NpcDialog.show(1,"船长辛迪",[[0,"恩！不愧是热辣小队的宣传委员！活力四射啊！这次队伍的宣传活动就要靠你了，分别是布置场景、拉取队员，我想你一定能够胜任！"]],["是的！船长！"],[function():void
            {
               NpcDialog.show(1,"船长辛迪",[[0,"快去游戏室找伊娃博士商量一下吧，加油！我希望在颁奖的时候可以再次看到你！"]],["（我这就去游戏室）"],[function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,80);
               }]);
            }]);
         }
         else if(PetKingTeamAttach.myTeamIndex == 2)
         {
            NpcDialog.show(1,"船长辛迪",[[0,"恩！不愧是冰沁小队的宣传委员！稳重下蕴藏了一颗炙热的心！这次队伍的宣传活动就要靠你了，分别是布置场景、拉取队员，我想你一定能够胜任！"]],["是的！船长！"],[function():void
            {
               NpcDialog.show(1,"船长辛迪",[[0,"快去动力室找上尉商量一下吧，加油！我希望在颁奖的时候可以再次看到你！"]],["（我这就去动力室）"],[function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,40);
               }]);
            }]);
         }
         else if(PetKingTeamAttach.myTeamIndex == 3)
         {
            NpcDialog.show(1,"船长辛迪",[[0,"恩！不愧是丛林小队的宣传委员！活力四射啊！这次队伍的宣传活动就要靠你了，分别是布置场景、拉取队员，我想你一定能够胜任！"]],["是的！船长！"],[function():void
            {
               NpcDialog.show(1,"船长辛迪",[[0,"快去机械室找多罗商量一下吧，加油！我希望在颁奖的时候可以再次看到你！"]],["（我这就去机械室）"],[function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,50);
               }]);
            }]);
         }
         else
         {
            NpcDialog.show(1,"船长辛迪",[[0,"赶快去选队伍吧！"]],["（知道了）"],[function():void
            {
            }]);
         }
      }
      
      private function noTeamHandler(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(event.content.params == SIGN)
         {
            NpcDialog.show(1,"船长辛迪",[[0,"赶快去选队伍吧！"]],["（知道了）"],[function():void
            {
            }]);
         }
      }
      
      private function startCaptainTalk_GreenTeam(param1:DialogPanelEvent) : void
      {
         if(param1.content.params == SIGN)
         {
            DialogPanel.removeCloseEventListener(this.startCaptainTalk_GreenTeam);
         }
      }
      
      private function startCaptainTalk_RedTeam(param1:DialogPanelEvent) : void
      {
         if(param1.content.params == SIGN)
         {
            DialogPanel.removeCloseEventListener(this.startCaptainTalk_GreenTeam);
         }
      }
      
      private function startCaptainTalk_BlueTeam(param1:DialogPanelEvent) : void
      {
         if(param1.content.params == SIGN)
         {
            DialogPanel.removeCloseEventListener(this.startCaptainTalk_GreenTeam);
         }
      }
   }
}
