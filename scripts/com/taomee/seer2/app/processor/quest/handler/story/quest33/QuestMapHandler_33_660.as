package com.taomee.seer2.app.processor.quest.handler.story.quest33
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_33_660 extends QuestMapHandler
   {
      
      private static var _fightStatus:uint = 0;
       
      
      private var _npc:Mobile;
      
      private var _teleport:Teleport;
      
      public function QuestMapHandler_33_660(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isCanAccepted(_quest.id) && _fightStatus == 1)
         {
            _fightStatus = 0;
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.win();
            }
            else
            {
               this.noWin();
            }
            return;
         }
         this._teleport = AnimateElementManager.getElement(2) as Teleport;
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this._teleport.visible = false;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onStep);
         }
         if(QuestManager.isAccepted(_quest.id))
         {
            this._teleport.visible = true;
         }
      }
      
      private function onStep(param1:DialogPanelEvent) : void
      {
         if((param1.content as DialogPanelEventData).params == "33_0")
         {
            this.processStep0();
         }
      }
      
      private function processStep0() : void
      {
         var _loc1_:ButtonPanelData = new ButtonPanelData();
         _loc1_.catchEnabled = false;
         _fightStatus = 1;
         FightManager.startFightBinaryWild(63,null,null,_loc1_);
      }
      
      private function win() : void
      {
         NpcDialog.show(83,"萨伯尔兵团长",[[0,"不愧是星际使者……！就由我带领你去时镜之岛吧！"]],["（时镜之岛？新场景？）"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("33_0"),function():void
            {
               if(_teleport)
               {
                  _teleport.visible = true;
               }
               SceneManager.changeScene(SceneType.LOBBY,700);
            },false);
         }]);
      }
      
      private function noWin() : void
      {
         NpcDialog.show(83,"萨伯尔兵团长",[[0,"星际使者就这点实力？认真和我打一场吧！"]],["等我准备一下！","继续挑战！"],[function():void
         {
            _npc = MobileManager.getMobile(83,MobileType.NPC);
            _npc.buttonMode = true;
            _npc.addEventListener(MouseEvent.CLICK,onClick,true,1);
         },function():void
         {
            processStep0();
         }]);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         this._npc.removeEventListener(MouseEvent.CLICK,this.onClick,true);
         this.noWin();
      }
   }
}
