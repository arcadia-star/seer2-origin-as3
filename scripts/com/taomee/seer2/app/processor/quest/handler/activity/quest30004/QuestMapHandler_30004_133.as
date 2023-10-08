package com.taomee.seer2.app.processor.quest.handler.activity.quest30004
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.FightVerifyManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.controls.widget.HeaderShootWidgetClick;
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
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30004_133 extends QuestMapHandler
   {
      
      private static var _fightStatus:uint = 0;
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_0_1:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      private var _mc_4:MovieClip;
      
      public function QuestMapHandler_30004_133(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false && _fightStatus == 1)
         {
            _fightStatus = 0;
            if(FightManager.fightWinnerSide == FightSide.RIGHT)
            {
               this.win();
            }
            return;
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initNpc(1);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initNpc(2);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this.initNpc(3);
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.processor4();
         }
      }
      
      private function initNpc(param1:uint = 1) : void
      {
         if(param1 == 1)
         {
            this._mc_0 = _processor.resLib.getMovieClip("mc_0");
            this._mc_0.buttonMode = true;
            this._mc_0.addEventListener(MouseEvent.CLICK,this.onNpc);
            this._mc_0.x = 182;
            this._mc_0.y = 354;
            _map.content.addChild(this._mc_0);
         }
         else if(param1 == 2)
         {
            if(this._mc_1 == null)
            {
               this._mc_1 = _processor.resLib.getMovieClip("mc_1");
               LayerManager.topLayer.addChild(this._mc_1);
               this._mc_1.gotoAndStop(this._mc_1.totalFrames);
            }
            this._mc_1.buttonMode = true;
            this._mc_1.addEventListener(MouseEvent.CLICK,this.onNpc1);
         }
         else if(param1 == 3)
         {
            this._mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.content.addChild(this._mc_2);
            this._mc_2.gotoAndStop(75);
            this._mc_2.buttonMode = true;
            this._mc_2.addEventListener(MouseEvent.CLICK,this.onNpc2);
         }
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(470,"鼻青眼肿荧光蝶",[[0,"……（……&*%# （鼻青眼肿荧光蝶在回忆刚才的痛苦经历）"]],["事情要从10分钟前说起"],[function():void
         {
            _mc_0.removeEventListener(MouseEvent.CLICK,onNpc);
            _mc_0_1 = _processor.resLib.getMovieClip("mc_0_1");
            LayerManager.topLayer.addChild(_mc_0_1);
            MovieClipUtil.playMc(_mc_0_1,1,_mc_0_1.totalFrames,function():void
            {
               MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30004_0"),4,[[1,0]],function():void
               {
                  _mc_1 = _processor.resLib.getMovieClip("mc_1");
                  LayerManager.topLayer.addChild(_mc_1);
                  MovieClipUtil.playMc(_mc_1,2,_mc_1.totalFrames,function():void
                  {
                     QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                     QuestManager.completeStep(_quest.id,1);
                  });
               });
            },true);
         }]);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._mc_1.buttonMode = true;
            this._mc_1.addEventListener(MouseEvent.CLICK,this.onNpc1);
         }
         if(QuestManager.isStepComplete(_quest.id,2) && QuestManager.isStepComplete(_quest.id,3) == false)
         {
            this._mc_2.gotoAndStop(75);
            this._mc_2.buttonMode = true;
            this._mc_2.addEventListener(MouseEvent.CLICK,this.onNpc2);
         }
         if(QuestManager.isStepComplete(_quest.id,3) && QuestManager.isStepComplete(_quest.id,4) == false)
         {
            this.processor4();
         }
         if(QuestManager.isStepComplete(_quest.id,4) && QuestManager.isStepComplete(_quest.id,5) == false)
         {
            SceneManager.changeScene(SceneType.LOBBY,20);
         }
      }
      
      private function onNpc1(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(471,"小雷伊",[[0,"干嘛！别靠近我！走开！我只跟强者对战！"]],["（这家伙应该不是萨伦帝国的）"],[function():void
         {
            DisplayUtil.removeForParent(_mc_1);
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"切！我很强的好吧！你不出来怎么知道我强不强！强者可不会鬼鬼祟祟！"]],["（……无语）"],[function():void
            {
               _mc_2 = _processor.resLib.getMovieClip("mc_2");
               _map.content.addChild(_mc_2);
               MovieClipUtil.playMc(_mc_2,1,10,function():void
               {
                  var _mcDian:* = undefined;
                  ActorManager.getActor().visible = false;
                  _mcDian = _processor.resLib.getMovieClip("mc_3");
                  LayerManager.topLayer.addChild(_mcDian);
                  _mcDian.x = ActorManager.getActor().x;
                  _mcDian.y = ActorManager.getActor().y;
                  MovieClipUtil.playMc(_mcDian,1,_mcDian.totalFrames,function():void
                  {
                     DisplayUtil.removeForParent(_mcDian);
                     ActorManager.getActor().visible = true;
                     MovieClipUtil.playMc(_mc_2,11,73,function():void
                     {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
                        QuestManager.completeStep(_quest.id,2);
                     },true);
                  },true);
               },true);
            }]);
         }]);
      }
      
      private function onNpc2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_2.removeEventListener(MouseEvent.CLICK,this.onNpc2);
         this._mc_2.mouseChildren = false;
         this._mc_2.mouseEnabled = false;
         MovieClipUtil.playMc(this._mc_2,81,94,function():void
         {
            var _mcDian:MovieClip = null;
            ActorManager.getActor().visible = false;
            _mcDian = _processor.resLib.getMovieClip("mc_3");
            LayerManager.topLayer.addChild(_mcDian);
            _mcDian.x = ActorManager.getActor().x;
            _mcDian.y = ActorManager.getActor().y;
            MovieClipUtil.playMc(_mcDian,1,_mcDian.totalFrames,function():void
            {
               _mc_2.gotoAndStop(95);
               DisplayUtil.removeForParent(_mcDian);
               ActorManager.getActor().visible = true;
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这可不是办法！得让他先停下来！（快用头部射击反击！）"]],["（头部射击在工具条上）"],[function():void
               {
                  _processor.showMouseHintAt(453,498);
                  ToolBar.getBtn(HeaderShootWidgetClick.SHOOT).addEventListener(MouseEvent.CLICK,onBtn);
               }]);
            },true);
         },true);
      }
      
      private function onBtn(param1:MouseEvent) : void
      {
         ToolBar.getBtn(HeaderShootWidgetClick.SHOOT).removeEventListener(MouseEvent.CLICK,this.onBtn);
         _processor.hideMouseClickHint();
         this._mc_2.gotoAndStop(96);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootEnd);
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var event:ShootEvent = param1;
         var info:ShootInfo = event.info;
         if(info.userID == ActorManager.actorInfo.id && this._mc_2.hitTestPoint(info.endPos.x,info.endPos.y))
         {
            ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
            MovieClipUtil.playMc(this._mc_2,97,112,function():void
            {
               ShootController.addEventListener(ShootEvent.PLAY_END,onShootEnd2);
            },true);
         }
      }
      
      private function onShootEnd2(param1:ShootEvent) : void
      {
         var event:ShootEvent = param1;
         var info:ShootInfo = event.info;
         if(info.userID == ActorManager.actorInfo.id && this._mc_2.hitTestPoint(info.endPos.x,info.endPos.y))
         {
            ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd2);
            MovieClipUtil.playMc(this._mc_2,113,130,function():void
            {
               ShootController.addEventListener(ShootEvent.PLAY_END,onShootEnd3);
            },true);
         }
      }
      
      private function onShootEnd3(param1:ShootEvent) : void
      {
         var _loc2_:ShootInfo = param1.info;
         if(_loc2_.userID == ActorManager.actorInfo.id && this._mc_2.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd3);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
            QuestManager.completeStep(_quest.id,3);
         }
      }
      
      private function processor4() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30004_2"),function():void
         {
            onFight(null);
         },true,false,2);
      }
      
      private function onFight(param1:MouseEvent) : void
      {
         if(FightVerifyManager.validateFightStart())
         {
            _fightStatus = 1;
            FightManager.startFightWithWild(80);
         }
         else
         {
            if(this._mc_2 == null)
            {
               this._mc_2 = _processor.resLib.getMovieClip("mc_2");
               _map.content.addChild(this._mc_2);
               this._mc_2.gotoAndStop(130);
            }
            this._mc_2.buttonMode = true;
            this._mc_2.addEventListener(MouseEvent.CLICK,this.onFight);
         }
      }
      
      private function win() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30004_3"),function():void
         {
            _mc_4 = _processor.resLib.getMovieClip("mc_4");
            LayerManager.topLayer.addChild(_mc_4);
            _mc_4.buttonMode = true;
            _mc_4.addEventListener(MouseEvent.CLICK,onClick4);
         },true,false,2);
      }
      
      private function onClick4(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"雷神！分明就是雷神啊！怎么又变小了？它这是怎么了？快去实验室吧！伊娃博士一定有办法？"]],["（前往实验室）"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepComplete);
            QuestManager.completeStep(_quest.id,4);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         ToolBar.getBtn(HeaderShootWidgetClick.SHOOT).removeEventListener(MouseEvent.CLICK,this.onBtn);
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepComplete);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd2);
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.onShootEnd3);
         DisplayUtil.removeForParent(this._mc_0);
         DisplayUtil.removeForParent(this._mc_1);
         DisplayUtil.removeForParent(this._mc_2);
         DisplayUtil.removeForParent(this._mc_4);
         this._mc_0 = null;
         this._mc_1 = null;
         this._mc_2 = null;
         this._mc_4 = null;
         super.processMapDispose();
      }
   }
}
