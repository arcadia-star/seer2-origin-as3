package com.taomee.seer2.app.processor.quest.handler.main.quest90
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class QuestMapHandler_90_80375 extends QuestMapHandler
   {
       
      
      private var _tm:Timer;
      
      private var _curIdx:int = 1;
      
      private var _mouseHint:MouseClickHintSprite;
      
      private var _teleport:Sprite;
      
      private var _npc:Mobile;
      
      private var NPCID:int = 1026;
      
      public function QuestMapHandler_90_80375(param1:QuestProcessor)
      {
         this._tm = new Timer(5000);
         super(param1);
      }
      
      private function pictureMc() : void
      {
         this._tm.addEventListener(TimerEvent.TIMER,this.onChangePicture);
         this._tm.start();
         MovieClip(_map.content["picMc"]).gotoAndStop(1);
         MovieClip(_map.content["picMc"]).buttonMode = true;
         MovieClip(_map.content["picMc"]).addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this._tm.stop();
         this.onChangePicture(null);
         this._tm.reset();
         this._tm.start();
      }
      
      private function onChangePicture(param1:Event) : void
      {
         ++this._curIdx;
         if(this._curIdx >= 5)
         {
            this._curIdx = 1;
         }
         if(_map && _map.content && Boolean(_map.content["picMc"]))
         {
            MovieClip(_map.content["picMc"]).gotoAndStop(this._curIdx);
         }
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         RightToolbarConter.instance.hide();
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         _map.content["teleportMc"].visible = false;
         _map.content["npcMc"].visible = false;
         this.pictureMc();
         this.createNpc();
         if(!QuestManager.isAccepted(questID))
         {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccepted);
         }
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2) && !QuestManager.isComplete(questID))
         {
            this.initStep2(null);
         }
         if(QuestManager.isStepComplete(questID,2) && QuestManager.isComplete(questID))
         {
            this.onComplete(null);
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
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         this.initStep1();
      }
      
      private function initStep1() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("90_0"),function():void
         {
            NpcDialog.show(855,"极梦",[[0,"我感到全身充满了力量！"]],["哇！极梦好帅！"],[function():void
            {
               NpcDialog.show(1026,"伊鲁维塔",[[0,"极梦，护送能量水晶的旅程将无比艰难，你要保护好大家。"]],["没问题。"],[function():void
               {
                  NpcDialog.show(855,"极梦",[[0,"有我在，不管地心兽还是深海巨兽都不在话下。将军请放心!"]],["极梦看起来就好强！"],[function():void
                  {
                     NpcDialog.show(855,"极梦",[[0,"我们出发吧小赛尔！"]],["出发！"],[function():void
                     {
                        QuestManager.completeStep(questID,1);
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,initStep2);
                     }]);
                  }]);
               }]);
            }]);
         });
      }
      
      private function initStep2(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         this._teleport = UIManager.getSprite("UI_Teleport");
         this._teleport.buttonMode = true;
         this._teleport.addEventListener(MouseEvent.CLICK,this.onClickTeleport);
         this._teleport.x = 268;
         this._teleport.y = 526;
         LayerManager.uiLayer.addChild(this._teleport);
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 268;
         this._mouseHint.y = 506;
         _map.front.addChild(this._mouseHint);
      }
      
      private function onClickTeleport(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.COPY,80374);
      }
      
      private function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.setPostion(new Point(668,328));
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1026,"伊鲁维塔将军",[[0,"这里是阿尔达要塞，人类最后的净土。"]],["我们一定会拯救人类！"],[function():void
         {
         }]);
      }
      
      override public function processMapDispose() : void
      {
         RightToolbarConter.instance.show();
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         this._tm.stop();
         this._tm.removeEventListener(TimerEvent.TIMER,this.onChangePicture);
         DisplayObjectUtil.removeFromParent(this._teleport);
         DisplayObjectUtil.removeFromParent(this._mouseHint);
         super.processMapDispose();
      }
   }
}
