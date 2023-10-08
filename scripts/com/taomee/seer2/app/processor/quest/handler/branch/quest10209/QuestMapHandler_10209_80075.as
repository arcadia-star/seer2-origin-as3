package com.taomee.seer2.app.processor.quest.handler.branch.quest10209
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10209_80075 extends QuestMapHandler
   {
      
      private static var _isFight:Boolean = false;
       
      
      private var _mc3:MovieClip;
      
      private var _process:AcceptableMark;
      
      private var _game2:com.taomee.seer2.app.processor.quest.handler.branch.quest10209.Quest10209Game2;
      
      private var _game2MC:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      public function QuestMapHandler_10209_80075(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(10209,2) && QuestManager.isStepComplete(10209,3) == false)
         {
            if(SceneManager.prevSceneType == SceneType.ARENA && _isFight)
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10209_4"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                  QuestManager.completeStep(10209,3);
               },true,true,2);
            }
            else
            {
               this.initQuest3();
            }
         }
      }
      
      private function initQuest3() : void
      {
         this._mc3 = _processor.resLib.getMovieClip("mc3");
         this._process = new AcceptableMark();
         _map.content.addChild(this._mc3);
         _map.front.addChild(this._process);
         this._process.x = 476;
         this._process.y = 295;
         this._mc3.buttonMode = true;
         this._mc3.addEventListener(MouseEvent.CLICK,this.onMC3);
      }
      
      private function onMC3(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(11,"多罗",[[0,"这里是哪里呀？我们穿越时空了吗？"]],["难道这里就是传说中的冰封魔域吗？"],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"快看，小当家被关在那里的铁笼子里。"]],["真的啊，赶快去救它吧！"],[function():void
            {
               _game2MC = _processor.resLib.getMovieClip("game2MC");
               LayerManager.topLayer.addChild(_game2MC);
               _game2 = new com.taomee.seer2.app.processor.quest.handler.branch.quest10209.Quest10209Game2(_game2MC,onComplete);
            }]);
         }]);
      }
      
      private function onComplete() : void
      {
         DisplayUtil.removeForParent(this._process);
         DisplayUtil.removeForParent(this._mc3);
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         _map.content.addChild(this._mc4);
         ActorManager.getActor().visible = false;
         MovieClipUtil.playMc(this._mc4,2,this._mc4.totalFrames,function():void
         {
            ActorManager.getActor().visible = true;
            _map.front.addChild(_process);
            _process.x = 679;
            _process.y = 343;
            _mc4["point"].buttonMode = true;
            _mc4["point"].addEventListener(MouseEvent.CLICK,onMC5);
         },true);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         SceneManager.changeScene(SceneType.LOBBY,3811);
      }
      
      private function onMC5(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(647,"路奇",[[0,"谁谁抢走了我的猎物？拿命来~呀呀呀！！！"]],["我要收了你这妖怪！(可捕捉)","啊~好可怕，我们赶快走吧！"],[function():void
         {
            _isFight = true;
            FightManager.startFightWithWild(693);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         DisplayUtil.removeForParent(this._mc3);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._game2MC);
         DisplayUtil.removeForParent(this._mc3);
         if(this._mc3)
         {
            this._mc3.removeEventListener(MouseEvent.CLICK,this.onMC3);
         }
         if(this._mc4)
         {
            this._mc4["point"].removeEventListener(MouseEvent.CLICK,this.onMC5);
         }
      }
   }
}
