package com.taomee.seer2.app.processor.quest.handler.main.quest92
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_92_3830 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _npc1032:Mobile;
      
      private var _npc:Mobile;
      
      private var _npc1:Mobile;
      
      private var NPCID:int = 1018;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _npc1017:Mobile;
      
      public function QuestMapHandler_92_3830(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this._npc1032 = MobileManager.getMobile(1032,MobileType.NPC);
         if(QuestManager.isComplete(questID) == false && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            this._npc1032.visible = false;
            this.createNpc();
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK,this.onCustomReply);
         }
      }
      
      private function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.setPostion(new Point(849,360));
         this._npc.label = "萨伦小兵";
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc1 = new Mobile();
         this._npc1.setPostion(new Point(949,360));
         this._npc1.label = "萨伦小兵";
         this._npc1.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc1.buttonMode = true;
         MobileManager.addMobile(this._npc1,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onDialogShow);
         this._npc1.addEventListener(MouseEvent.CLICK,this.onDialogShow);
      }
      
      private function onDialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(40,"萨伦小兵",[[0,"外族人！走开，别想进入穹顶大厅！"]],["哼，你不也是外族人！"],[function():void
         {
         }]);
      }
      
      private function onCustomReply(param1:DialogPanelEvent) : void
      {
         if(DialogPanelEventData(param1.content).params == "92_2")
         {
            RightToolbarConter.instance.hide();
            ActorManager.getActor().hide();
            ActorManager.getActor().blockFollowingPet = true;
            ActorManager.getActor().blockNoNo = true;
            this.initStep();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep() : void
      {
         this._npc1017 = MobileManager.getMobile(1017,MobileType.NPC);
         NpcDialog.show(1017,"瓦利",[[0,"队长派你们去见族长吗？也只有这个办法了，族长大人现在的脾气见不得我们任何人。我可以帮助你们躲开门口的守卫，进入穹顶大厅。"]],["事不宜迟。"],[function():void
         {
            _npc1017.visible = false;
            if(_npc != null)
            {
               MobileManager.removeMobile(_npc,MobileType.NPC);
            }
            if(_npc1 != null)
            {
               MobileManager.removeMobile(_npc1,MobileType.NPC);
            }
            _mc1 = _processor.resLib.getMovieClip("Mc92_1");
            _map.front.addChild(_mc1);
            _mc1.gotoAndStop(1);
            MovieClipUtil.playMc(_mc1,1,_mc1.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(_mc1);
               _npc1017.visible = true;
               NpcDialog.show(1017,"瓦利",[[0,ActorManager.actorInfo.nick + "，注意不要惹怒族长大人，他的脾气可不太好。"]],["在诺亚方舟上，我就见识过族长的脾气了"],[function():void
               {
                  QuestManager.completeStep(questID,2);
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,initStep2);
               }]);
            },true);
         }]);
      }
      
      private function initStep2(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.initStep2);
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 870;
         this._mouseHint.y = 330;
         _map.content.addChild(this._mouseHint);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         super.processMapDispose();
      }
   }
}
