package com.taomee.seer2.app.processor.quest.handler.activity.quest30011
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.QuestProcessor_30011;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30011_90 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _setTimeout:uint;
      
      public function QuestMapHandler_30011_90(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3) && QuestProcessor_30011.QUEST_30011_STATUS == 0)
         {
            this.processor3();
         }
      }
      
      private function processor3() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"把机器安装在哪里呢？咦，放在高处效果肯定会更好！"]],["（点击鼠标提示）"],[function():void
         {
            _mc_0 = _processor.resLib.getMovieClip("mc_0");
            _mc_0.buttonMode = true;
            _mc_0.gotoAndStop(1);
            _mc_0.addEventListener(MouseEvent.CLICK,onClickMC);
            _map.front.addChild(_mc_0);
         }]);
      }
      
      private function onClickMC(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onClickMC);
         MovieClipUtil.playMc(this._mc_0,2,this._mc_0.totalFrames,function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"机器的位置已经固定，现在点击启动吧！"]],["（点击生命监测仪）"],[function():void
            {
               _mc_0.addEventListener(MouseEvent.CLICK,onClickMC2);
            }]);
         },true);
      }
      
      private function onClickMC2(param1:MouseEvent) : void
      {
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onClickMC2);
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         _map.front.addChild(this._mc_1);
         this._mc_1.x = _map.front.width / 2 - this._mc_1.width / 2 + 150;
         this._mc_1.y = _map.front.height / 2 - this._mc_1.height / 2;
         this._setTimeout = setTimeout(this.onBtn,2000);
      }
      
      private function onBtn() : void
      {
         DisplayUtil.removeForParent(this._mc_1);
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哈哈，这边搞定咯，转移阵地！"]],["（去水脉氏族主城）"],[function():void
         {
            QuestProcessor_30011.QUEST_30011_STATUS = 1;
            SceneManager.changeScene(SceneType.LOBBY,160);
         }]);
      }
      
      override public function processMapDispose() : void
      {
         DisplayUtil.removeForParent(this._mc_0);
         DisplayUtil.removeForParent(this._mc_1);
         this._mc_0 = null;
         this._mc_1 = null;
         if(this._setTimeout != 0)
         {
            clearTimeout(this._setTimeout);
         }
         this._setTimeout = 0;
         super.processMapDispose();
      }
   }
}
