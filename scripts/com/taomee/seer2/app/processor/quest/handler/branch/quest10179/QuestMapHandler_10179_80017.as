package com.taomee.seer2.app.processor.quest.handler.branch.quest10179
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10179_80017 extends QuestMapHandler
   {
       
      
      private var _npc2:MovieClip;
      
      private var _npc3:MovieClip;
      
      private var _npc4:MovieClip;
      
      private var _npc5:MovieClip;
      
      private const POS:Array = [[509,285],[370,290],[333,328],[190,245]];
      
      public function QuestMapHandler_10179_80017(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,2) && !QuestManager.isStepComplete(_quest.id,3))
         {
            this.handle1();
         }
      }
      
      private function handle1() : void
      {
         this._npc2 = _processor.resLib.getMovieClip("npc_2");
         this._npc2.x = this.POS[0][0];
         this._npc2.y = this.POS[0][1];
         this._npc2["mark"].visible = true;
         this._npc2.buttonMode = true;
         _map.content.addChild(this._npc2);
         this._npc2.addEventListener(MouseEvent.CLICK,this.onNpc2Click);
         this._npc3 = _processor.resLib.getMovieClip("npc_6");
         this._npc3.x = this.POS[1][0];
         this._npc3.y = this.POS[1][1];
         this._npc3["mark"].visible = false;
         _map.content.addChild(this._npc3);
         this._npc5 = _processor.resLib.getMovieClip("npc_5");
         this._npc5.x = this.POS[3][0];
         this._npc5.y = this.POS[3][1];
         _map.content.addChild(this._npc5);
      }
      
      private function onNpc2Click(param1:MouseEvent) : void
      {
         var _scenMc:MovieClip = null;
         var evt:MouseEvent = param1;
         this._npc2.removeEventListener(MouseEvent.CLICK,this.onNpc2Click);
         _scenMc = _processor.resLib.getMovieClip("sceneTalk_2");
         _map.front.addChild(_scenMc);
         MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_scenMc);
            _scenMc = null;
            DisplayUtil.removeForParent(_npc2,false);
            DisplayUtil.removeForParent(_npc5,false);
            _scenMc = _processor.resLib.getMovieClip("scene_2");
            _map.front.addChild(_scenMc);
            _scenMc.x = 57;
            _scenMc.y = 112;
            MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_scenMc);
               _scenMc = null;
               _map.content.addChild(_npc2);
               _map.content.addChild(_npc5);
               _npc4 = _processor.resLib.getMovieClip("npc_4");
               _npc4.x = POS[2][0];
               _npc4.y = POS[2][1];
               _map.content.addChild(_npc4);
               _npc2["mark"].visible = false;
               _npc2.buttonMode = false;
               _npc4["mark"].visible = true;
               _npc4.buttonMode = true;
               _npc4.addEventListener(MouseEvent.CLICK,onNpc4Click);
            },true);
         },true);
      }
      
      private function onNpc4Click(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(566,"月神",[[0,"月之光芒，赐予力量！你们好啊各位朋友，大家必须要准备一场恶战了！暗月之能已被撒旦吞噬，我将会保护大家——"]],[" 地面忽然晃动，出什么事了？"],[function():void
         {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10179_4"),function():void
            {
               _npc4["mark"].visible = false;
               _npc4.buttonMode = false;
               _npc4.removeEventListener(MouseEvent.CLICK,onNpc4Click);
               NpcDialog.show(400,"小赛尔",[[3,"乌鸦？！你这个撒旦的傀儡！亏我还救了你的命！ "]],["噗噗噗！呱啊！"],[function():void
               {
                  NpcDialog.show(565,"渡鸦之首",[[4,"噗噗噗！呱啊！只能说你们太笨！我的演技太好！闪一边去！这三只鸟是我的！ "]],["不准动它们！我在 黑羽之战 等你！我会战胜你！"],[function():void
                  {
                     QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                     QuestManager.completeStep(_quest.id,3);
                  }]);
               }]);
            },true,true,2);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         ModuleManager.showModule(URLUtil.getAppModule("MedicineShopMainPanel"),"正在打开黑羽之战面板...");
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._npc2)
         {
            this._npc2.removeEventListener(MouseEvent.CLICK,this.onNpc2Click);
            DisplayUtil.removeForParent(this._npc2);
         }
         if(this._npc4)
         {
            this._npc4.removeEventListener(MouseEvent.CLICK,this.onNpc4Click);
            DisplayUtil.removeForParent(this._npc4);
         }
         if(this._npc3)
         {
            DisplayUtil.removeForParent(this._npc3);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
   }
}
