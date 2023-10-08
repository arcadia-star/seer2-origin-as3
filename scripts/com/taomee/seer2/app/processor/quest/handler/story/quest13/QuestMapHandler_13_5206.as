package com.taomee.seer2.app.processor.quest.handler.story.quest13
{
   import com.taomee.seer2.app.animationInteractive.Interactive_13;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandler_13_5206 extends QuestMapHandler
   {
      
      public static var fightIndex:int = 0;
       
      
      private var _mc_6:MovieClip;
      
      private var _mc_7:MovieClip;
      
      private var _interactive_13:Interactive_13;
      
      public function QuestMapHandler_13_5206(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id,2) == false && fightIndex == 1)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT && fightIndex == 1)
            {
               this.win();
            }
            else
            {
               fightIndex = 0;
               this.noWin();
            }
            return;
         }
         this.addMouseClickHint();
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initAnimation();
         }
      }
      
      private function initAnimation() : void
      {
         this._mc_6 = _processor.resLib.getMovieClip("mc_6");
         this._mc_6.buttonMode = true;
         this._mc_6.x = 160;
         this._mc_6.y = 200;
         _map.front.addChild(this._mc_6);
         this._mc_6.gotoAndStop(1);
         this._mc_6.addEventListener(MouseEvent.CLICK,this.showYiteDialog);
      }
      
      private function showYiteDialog(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_6.removeEventListener(MouseEvent.CLICK,this.showYiteDialog);
         NpcDialog.show(429,"伊特",[[0,"就是这个屎肥猪抢走我的金灿灿奶嘴！矮冬瓜！快帮我抢回来！"]],["自己才这么点还说我矮冬瓜！（点击皮格）"],[function():void
         {
            _mc_6.gotoAndStop(2);
            _processor.showMouseHintAt(30,132);
            _mc_6.addEventListener(MouseEvent.CLICK,onClickInteractive);
         }]);
      }
      
      private function onClickInteractive(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._interactive_13 = new Interactive_13();
         this._interactive_13.setup("interactive_13",function(param1:Boolean):void
         {
            if(param1)
            {
               fightIndex = 1;
               FightManager.startFightWithWild(28);
            }
            else
            {
               _processor.showMouseHintAt(150,30);
               _mc_6.addEventListener(MouseEvent.CLICK,onClickInteractive);
            }
         });
      }
      
      private function win() : void
      {
         this._mc_6 = _processor.resLib.getMovieClip("mc_6");
         this._mc_6.x = 160;
         this._mc_6.y = 200;
         _map.front.addChild(this._mc_6);
         MovieClipUtil.playMc(this._mc_6,2,this._mc_6.totalFrames,function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[3,"可恶啊！竟然博取我们同情心！！！！来抢皮格的金灿灿奶嘴！！！"]],["你！你给我站住！！！"],[function():void
            {
               _map.front.removeChild(_mc_6);
               _mc_6 = null;
               _mc_7 = _processor.resLib.getMovieClip("mc_7");
               _mc_7.x = 160;
               _mc_7.y = 200;
               _map.front.addChild(_mc_7);
               MovieClipUtil.playMc(_mc_7,1,_mc_7.totalFrames,function():void
               {
                  if(_mc_7.parent)
                  {
                     _map.front.removeChild(_mc_7);
                  }
                  _mc_7 = null;
                  fightIndex = 0;
                  QuestManager.completeStep(_quest.id,2);
                  if(!QuestManager.isCompletable(_quest.id))
                  {
                     _processor.showMouseHintAt(-4,429);
                  }
               },true);
            }]);
         },true);
      }
      
      private function addMouseClickHint() : void
      {
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isCompletable(_quest.id))
         {
            _processor.showMouseHintAt(-4,429);
         }
      }
      
      private function noWin() : void
      {
         this._mc_6 = _processor.resLib.getMovieClip("mc_6");
         _map.front.addChild(this._mc_6);
         this._mc_6.buttonMode = true;
         this._mc_6.gotoAndStop(1);
         this._mc_6.x = 160;
         this._mc_6.y = 200;
         _processor.showMouseHintAt(150,30);
         this._mc_6.addEventListener(MouseEvent.CLICK,this.onMC6Click);
      }
      
      private function onMC6Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(PetInfoManager.getFirstPetInfo().hp <= 1)
         {
            AlertManager.showAlert("您的首发精灵体力不够");
            return;
         }
         this._mc_6.removeEventListener(MouseEvent.CLICK,this.onMC6Click);
         _processor.hideMouseClickHint();
         NpcDialog.show(430,"皮格",[[3,"还给俺！！俺的！这是俺娘给俺的！俺娘看到金灿灿奶嘴没了会暴走的！"]],["继续对战！血拼到底！"],[function():void
         {
            fightIndex = 1;
            FightManager.startFightWithWild(28);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         if(this._interactive_13)
         {
            this._interactive_13.dispose();
            this._interactive_13 = null;
         }
         if(this._mc_6)
         {
            this._mc_6.removeEventListener(MouseEvent.CLICK,this.onClickInteractive);
            if(this._mc_6.parent)
            {
               _map.front.removeChild(this._mc_6);
            }
         }
         if(this._mc_7)
         {
            if(this._mc_7.parent)
            {
               _map.front.removeChild(this._mc_7);
            }
         }
      }
   }
}
