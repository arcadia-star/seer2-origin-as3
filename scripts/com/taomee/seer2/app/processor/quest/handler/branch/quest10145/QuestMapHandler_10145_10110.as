package com.taomee.seer2.app.processor.quest.handler.branch.quest10145
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10145_10110 extends QuestMapHandler
   {
       
      
      private var _npcBadi:MovieClip;
      
      private var _npcDuoluo:MovieClip;
      
      private var _house:MovieClip;
      
      private var _npcOldMan:MovieClip;
      
      private var _npcBear:MovieClip;
      
      private const POS:Array = [[264,342],[335,342],[227,205],[522,181]];
      
      public function QuestMapHandler_10145_10110(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.desolveRes();
            this.addRes1();
         }
      }
      
      private function addRes1() : void
      {
         this._npcBadi = _processor.resLib.getMovieClip("npc_4");
         this._npcDuoluo = _processor.resLib.getMovieClip("npc_5");
         this._npcBadi.x = this.POS[0][0];
         this._npcBadi.y = this.POS[0][1];
         this._npcDuoluo.x = this.POS[1][0];
         this._npcDuoluo.y = this.POS[1][1];
         this._npcBadi["mark"].visible = true;
         this._npcDuoluo["mark"].visible = false;
         _map.content.addChild(this._npcBadi);
         _map.content.addChild(this._npcDuoluo);
         this._npcBadi.buttonMode = true;
         this._npcBadi.addEventListener(MouseEvent.CLICK,this.onBadiClick);
      }
      
      private function onBadiClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcBadi["mark"].visible = false;
         this._npcBadi.removeEventListener(MouseEvent.CLICK,this.onBadiClick);
         NpcDialog.show(10,"巴蒂",[[0,"切！多罗还说会有熊怪呢，这都大半夜了我看到的只是洁白的雪花和漂亮的雪人，哪有什么熊怪！"]],["就是就是！多罗真胆小！"],[function():void
         {
            var sceneMc:* = undefined;
            sceneMc = _processor.resLib.getMovieClip("scene_2");
            _map.front.addChild(sceneMc);
            sceneMc.x = -49;
            sceneMc.y = -89;
            MovieClipUtil.playMc(sceneMc,2,sceneMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(sceneMc);
               _house = _processor.resLib.getMovieClip("ClickTip");
               _map.content.addChild(_house);
               _house.x = 578;
               _house.y = 128;
               _house.buttonMode = true;
               _house.addEventListener(MouseEvent.CLICK,onHouseClick);
            },true);
         }]);
      }
      
      private function onHouseClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._house.removeEventListener(MouseEvent.CLICK,this.onHouseClick);
         DisplayUtil.removeForParent(this._house);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10145_2"),function():void
         {
            desolveRes();
            addRes2();
         },true,false,2);
      }
      
      private function addRes2() : void
      {
         this._npcOldMan = _processor.resLib.getMovieClip("npc_1");
         this._npcBear = _processor.resLib.getMovieClip("npc_6");
         this._npcBadi = _processor.resLib.getMovieClip("npc_4");
         this._npcDuoluo = _processor.resLib.getMovieClip("npc_5");
         this._npcOldMan.x = this.POS[2][0];
         this._npcOldMan.y = this.POS[2][1];
         this._npcBear.x = this.POS[3][0];
         this._npcBear.y = this.POS[3][1];
         this._npcBadi.x = this.POS[0][0];
         this._npcBadi.y = this.POS[0][1];
         this._npcDuoluo.x = this.POS[1][0];
         this._npcDuoluo.y = this.POS[1][1];
         _map.content.addChild(this._npcOldMan);
         _map.content.addChild(this._npcBear);
         _map.content.addChild(this._npcBadi);
         _map.content.addChild(this._npcDuoluo);
         this._npcBadi["mark"].visible = this._npcDuoluo["mark"].visible = this._npcBear["mark"].visible = false;
         this._npcOldMan["mark"].visible = true;
         this._npcOldMan.buttonMode = true;
         this._npcOldMan.addEventListener(MouseEvent.CLICK,this.onOldManClick);
      }
      
      private function onOldManClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick);
         NpcDialog.show(180,"圣诞老人",[[4,"这么晚你们怎么还在？危险！康特的杀戮之心觉醒了！"]],["它真的是康特？！"],[function():void
         {
            NpcDialog.show(180,"圣诞老人",[[4,"一定是康特的水晶球又坏了！一会儿再跟你们解释吧，现在快去收集一些材料制作一个装满星星的水晶球吧！"]],["都什么时候了还做水晶球？！"],[function():void
            {
               NpcDialog.show(180,"圣诞老人",[[4,"快！这是唯一让康特安静下来的办法！去找一个安迷亚的头罩，再去找一些荧光蝶的亮粉，最后再去找一些蓝喵的硬壳。"]],["找这些做什么？"],[function():void
               {
                  NpcDialog.show(180,"圣诞老人",[[4,"这些可以制作一个装满星星的水晶球，快去吧！康特的杀戮之心就要发作了！"]],["好！我们现在就去！"],[function():void
                  {
                     _npcOldMan["mark"].visible = false;
                     _npcOldMan.buttonMode = false;
                     _npcBadi["mark"].visible = true;
                     _npcBadi["mark"].buttonMode = true;
                     _npcBadi["mark"].addEventListener(MouseEvent.CLICK,onBadiClick1);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onBadiClick1(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(10,"巴蒂",[[0,"我们分头行动！我去找荧光蝶的亮粉，你们去水脉氏族找蓝喵的硬壳和安迷亚的头罩吧！"]],["多罗！我们先去找安迷亚的头罩吧！"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStepTwoComplete);
            QuestManager.completeStep(_quest.id,2);
         }]);
      }
      
      private function onStepTwoComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoComplete);
         SceneManager.changeScene(SceneType.LOBBY,202);
      }
      
      private function desolveRes() : void
      {
         if(Boolean(this._npcBadi) && Boolean(this._npcBadi.parent))
         {
            DisplayUtil.removeForParent(this._npcBadi);
            this._npcBadi.removeEventListener(MouseEvent.CLICK,this.onBadiClick);
            this._npcBadi.removeEventListener(MouseEvent.CLICK,this.onBadiClick1);
            this._npcBadi = null;
         }
         if(Boolean(this._npcDuoluo) && Boolean(this._npcDuoluo.parent))
         {
            DisplayUtil.removeForParent(this._npcDuoluo);
            this._npcDuoluo = null;
         }
         if(Boolean(this._house) && Boolean(this._house.parent))
         {
            this._house.removeEventListener(MouseEvent.CLICK,this.onHouseClick);
         }
         if(Boolean(this._npcOldMan) && Boolean(this._npcOldMan.parent))
         {
            DisplayUtil.removeForParent(this._npcOldMan);
            this._npcOldMan.removeEventListener(MouseEvent.CLICK,this.onOldManClick);
            this._npcOldMan = null;
         }
         if(Boolean(this._npcBear) && Boolean(this._npcBear.parent))
         {
            DisplayUtil.removeForParent(this._npcBear);
            this._npcBear = null;
         }
      }
      
      override public function processMapDispose() : void
      {
         this.desolveRes();
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepTwoComplete);
      }
   }
}
