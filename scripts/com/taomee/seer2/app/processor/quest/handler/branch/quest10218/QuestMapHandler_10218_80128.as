package com.taomee.seer2.app.processor.quest.handler.branch.quest10218
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10218_80128 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _hintList:Vector.<MouseClickHintSprite>;
      
      private var _count:uint;
      
      public function QuestMapHandler_10218_80128(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10218) && QuestManager.isStepComplete(10218,3) == false)
         {
            this.initStep3();
         }
      }
      
      private function initStep3() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("mc1");
         _map.front.addChild(this._mc1);
         ActorManager.getActor().isShow = false;
         MovieClipUtil.playMc(this._mc1,2,this._mc1.totalFrames,function():void
         {
            ActorManager.getActor().isShow = true;
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"可恶！又是你们这群萨伦小兵！看我不打的你们满地找牙！"]],["（快使用头部射击！）"],[function():void
            {
               DisplayUtil.removeForParent(_mc1);
               _mc2 = _processor.resLib.getMovieClip("mc2");
               _map.content.addChild(_mc2);
               _mc2["actor0"].gotoAndStop(1);
               _mc2["actor1"].gotoAndStop(1);
               _mc2["actor2"].gotoAndStop(1);
               _count = 0;
               _hintList = Vector.<MouseClickHintSprite>([new MouseClickHintSprite(),new MouseClickHintSprite(),new MouseClickHintSprite()]);
               _hintList[0].x = 503;
               _hintList[0].y = 284;
               _hintList[1].x = 465;
               _hintList[1].y = 322;
               _hintList[2].x = 495;
               _hintList[2].y = 360;
               _map.content.addChild(_hintList[0]);
               _map.content.addChild(_hintList[1]);
               _map.content.addChild(_hintList[2]);
               ShootController.addEventListener(ShootEvent.PLAY_END,onShootEnd);
            }]);
         },true);
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var mc:MovieClip = null;
         var event:ShootEvent = param1;
         var info:ShootInfo = event.info;
         var i:int = 0;
         while(i < 3)
         {
            if(info.userID == ActorManager.actorInfo.id && this._mc2["actor" + i].hitTestPoint(info.endPos.x,info.endPos.y) && this._mc2["actor" + i].currentFrame == 1)
            {
               mc = this._mc2["actor" + i];
               mc.gotoAndPlay(2);
               DisplayUtil.removeForParent(this._hintList[i]);
               ++this._count;
            }
            i++;
         }
         if(this._count >= 3)
         {
            ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
            DisplayUtil.removeForParent(this._mc2);
            this._mc3 = _processor.resLib.getMovieClip("mc3");
            _map.content.addChild(this._mc3);
            MovieClipUtil.playMc(this._mc3,2,this._mc3.totalFrames,function():void
            {
               _mc4 = _processor.resLib.getMovieClip("mc4");
               LayerManager.topLayer.addChild(_mc4);
               MovieClipUtil.playMc(_mc4,2,_mc4.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_mc4);
                  DisplayUtil.removeForParent(_mc3);
                  NpcDialog.show(49,"冰系酋长",[[0,"好吧，事不宜迟，我马上签署契约！"]],["太好了，这样一来我们又多了一份力量！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10218_2_1"),function():void
                     {
                        NpcDialog.show(49,"冰系酋长",[[0,"接下来，冰系氏族所有族民会全力支持的！"]],["接下来就剩飞翼氏族了。"],[function():void
                        {
                           QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                           QuestManager.completeStep(10218,3);
                        }]);
                     },true,true);
                  }]);
               },true);
            },true);
         }
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.COPY,80129);
      }
      
      override public function processMapDispose() : void
      {
         var _loc1_:MouseClickHintSprite = null;
         super.processMapDispose();
         for each(_loc1_ in this._hintList)
         {
            DisplayUtil.removeForParent(_loc1_);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc1);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._mc3);
         DisplayUtil.removeForParent(this._mc4);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         this._mc1 = null;
         this._mc2 = null;
         this._mc3 = null;
         this._mc4 = null;
      }
   }
}
