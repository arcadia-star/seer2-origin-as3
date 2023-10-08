package com.taomee.seer2.app.processor.quest.handler.branch.quest10187
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10187_2 extends QuestMapHandler
   {
       
      
      private var _markMc:MouseClickHintSprite;
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      private var _mc_2:MovieClip;
      
      private var _line1:MovieClip;
      
      private var _line2:MovieClip;
      
      private var _line3:MovieClip;
      
      public function QuestMapHandler_10187_2(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this._mc_0 = _processor.resLib.getMovieClip("mc_2");
            _map.content.addChild(this._mc_0);
            this._mc_0.buttonMode = true;
            this._mc_0.addEventListener(MouseEvent.CLICK,this.onSTalk);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._mc_2 = _processor.resLib.getMovieClip("tina");
            _map.content.addChild(this._mc_2);
            this._mc_2.buttonMode = true;
            this._mc_2.addEventListener(MouseEvent.CLICK,this.onTinaTalk);
            this._mc_0 = _processor.resLib.getMovieClip("mc_2");
            _map.content.addChild(this._mc_0);
         }
      }
      
      private function onSTalk(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         NpcDialog.show(192,"S",[[0,"小赛尔，这里很诡异，快帮我一起找找有什么线索，别放过任何地方！"]],["没问题！看！那里有个扳手！"],[function():void
         {
            _mc_0.buttonMode = false;
            _mc_0.removeEventListener(MouseEvent.CLICK,onSTalk);
            _markMc = new MouseClickHintSprite();
            _map.front.addChild(_markMc);
            _markMc.x = 647;
            _markMc.y = 113;
            _mc_1 = _processor.resLib.getMovieClip("mc_3");
            _map.front.addChild(_mc_1);
            _mc_1.buttonMode = true;
            _mc_1.addEventListener(MouseEvent.CLICK,onOpenPanel);
         }]);
      }
      
      private function onOpenPanel(param1:MouseEvent) : void
      {
         ModuleManager.addEventListener("ElectricWirePanel","ElectricWireSuccess",this.onSucessElectricWire);
         ModuleManager.toggleModule(URLUtil.getAppModule("ElectricWirePanel"),"正在打开面板...");
         this.addElectricWire();
      }
      
      private function addElectricWire() : void
      {
         if(ItemManager.getSpecialItem(603085) == null)
         {
            this._line1 = _processor.resLib.getMovieClip("line1");
            _map.content.addChild(this._line1);
            this._line1.gotoAndStop(1);
            this._line1.buttonMode = true;
            this._line1.addEventListener(MouseEvent.CLICK,this.onPickUpLineOne);
         }
         if(ItemManager.getSpecialItem(603086) == null)
         {
            this._line2 = _processor.resLib.getMovieClip("line2");
            _map.front.addChild(this._line2);
            this._line2.gotoAndStop(1);
            this._line2.buttonMode = true;
            this._line2.addEventListener(MouseEvent.CLICK,this.onPickUpLineTwo);
         }
         if(ItemManager.getSpecialItem(603087) == null)
         {
            this._line3 = _processor.resLib.getMovieClip("line3");
            _map.front.addChild(this._line3);
            this._line3.gotoAndStop(1);
            this._line3.buttonMode = true;
            this._line3.addEventListener(MouseEvent.CLICK,this.onPickUpLineThree);
         }
      }
      
      private function onPickUpLineOne(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._line1.removeEventListener(MouseEvent.CLICK,this.onPickUpLineOne);
         this._line1.gotoAndStop(2);
         SwapManager.swapItem(1420,1,function(param1:IDataInput):void
         {
            DisplayUtil.removeForParent(_line1);
            var _loc2_:SwapInfo = new SwapInfo(param1,false);
            var _loc3_:String = ItemConfig.getItemName(_loc2_.itemID);
            ServerMessager.addMessage("你找到一根" + _loc3_ + "!");
         });
      }
      
      private function onPickUpLineTwo(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._line2.removeEventListener(MouseEvent.CLICK,this.onPickUpLineTwo);
         this._line2.gotoAndStop(2);
         SwapManager.swapItem(1421,1,function(param1:IDataInput):void
         {
            DisplayUtil.removeForParent(_line2);
            var _loc2_:SwapInfo = new SwapInfo(param1,false);
            var _loc3_:String = ItemConfig.getItemName(_loc2_.itemID);
            ServerMessager.addMessage("你找到一根" + _loc3_ + "!");
         });
      }
      
      private function onPickUpLineThree(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         this._line3.removeEventListener(MouseEvent.CLICK,this.onPickUpLineThree);
         this._line3.gotoAndStop(2);
         SwapManager.swapItem(1422,1,function(param1:IDataInput):void
         {
            DisplayUtil.removeForParent(_line3);
            var _loc2_:SwapInfo = new SwapInfo(param1,false);
            var _loc3_:String = ItemConfig.getItemName(_loc2_.itemID);
            ServerMessager.addMessage("你找到一根" + _loc3_ + "!");
         });
      }
      
      private function onSucessElectricWire(param1:ModuleEvent) : void
      {
         var evr:ModuleEvent = param1;
         ModuleManager.removeEventListener("ElectricWirePanel","ElectricWireSuccess",this.onSucessElectricWire);
         DisplayObjectUtil.removeFromParent(this._markMc);
         this._mc_2 = _processor.resLib.getMovieClip("mc_4");
         _map.content.addChild(this._mc_2);
         MovieClipUtil.playMc(this._mc_2,1,this._mc_2.totalFrames,function():void
         {
            if(_mc_2)
            {
               DisplayUtil.removeForParent(_mc_2);
            }
            _mc_2 = _processor.resLib.getMovieClip("tina");
            _map.content.addChild(_mc_2);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteOneHandler);
            QuestManager.completeStep(_quest.id,1);
         },true);
      }
      
      private function onCompleteOneHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         this.tinaTalk();
      }
      
      private function onTinaTalk(param1:MouseEvent) : void
      {
         this.tinaTalk();
      }
      
      private function tinaTalk() : void
      {
         NpcDialog.show(39,"缇娜",[[1,"哦，我说是谁呢？原来是小S！听说你从良了？哈哈哈哈哈！"]],["你这个坏女人！"],[function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"你想怎么样？"]],["你这个小铁皮靠边闪！"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10187_2"),function():void
               {
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleteHandler);
                  QuestManager.completeStep(_quest.id,2);
               },true,false,2);
            }]);
         }]);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
         SceneManager.changeScene(SceneType.LOBBY,70);
         ModuleManager.toggleModule(URLUtil.getAppModule("ShuangshengQuestsPanel"),"正在打开面板...");
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         if(this._mc_2)
         {
            DisplayUtil.removeForParent(this._mc_2);
         }
         if(this._line1)
         {
            DisplayUtil.removeForParent(this._line1);
         }
         if(this._line2)
         {
            DisplayUtil.removeForParent(this._line2);
         }
         if(this._line3)
         {
            DisplayUtil.removeForParent(this._line3);
         }
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         if(this._mc_2)
         {
            DisplayUtil.removeForParent(this._mc_2);
         }
         if(this._line1)
         {
            DisplayUtil.removeForParent(this._line1);
         }
         if(this._line2)
         {
            DisplayUtil.removeForParent(this._line2);
         }
         if(this._line3)
         {
            DisplayUtil.removeForParent(this._line3);
         }
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteOneHandler);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleteHandler);
      }
   }
}
