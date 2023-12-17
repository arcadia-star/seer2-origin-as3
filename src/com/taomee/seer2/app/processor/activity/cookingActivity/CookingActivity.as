package com.taomee.seer2.app.processor.activity.cookingActivity
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.app.dialog.functionality.CookingUnit;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class CookingActivity
   {
       
      
      private const cookingDayList:Vector.<uint> = Vector.<uint>([200502,200502,200505,200508,200511,200514,200518,200564,200567,200570,200502,200505]);
      
      private var _map:MapModel;
      
      private var _npc:MovieClip;
      
      private var _pot:MovieClip;
      
      private var _suer:Mobile;
      
      private var _cookingComplete:MovieClip;
      
      public function CookingActivity(param1:MapModel)
      {
         super();
         this._map = param1;
         this.init();
         this.initPot();
         this.initSuer();
         this.initTime();
      }
      
      private function init() : void
      {
         if(CookingActivityLoad.instance.isTimerLater())
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.COOKING_ACTIVITY,0,0);
         }
         CookingActivityLoad.instance.playLoad(function():void
         {
            _npc = CookingActivityLoad.instance.getMC("npc");
            _map.content.addChild(_npc);
            setNpcStatus();
         });
      }
      
      private function initSuer() : void
      {
         this._suer = MobileManager.getMobile(314,MobileType.NPC);
         DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
      }
      
      private function initTime() : void
      {
         if(CookingActivityLoad.instance.isTimerLater() == false)
         {
            TimeManager.addEventListener(TimeManager.TIME_UPDATE,this.onTimeUpdate);
         }
      }
      
      private function onTimeUpdate(param1:Event) : void
      {
         if(CookingActivityLoad.instance.checkTime)
         {
            if(this._npc.currentFrame == 1)
            {
               this._npc.gotoAndStop(2);
               this._npc.buttonMode = true;
               this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
            }
         }
         else if(this._npc.currentFrame == 2)
         {
            this._npc.buttonMode = false;
            this._npc.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      private function onDialogShow(param1:DialogPanelEvent) : void
      {
         var _loc2_:CookingUnit = null;
         if(param1.content == 314)
         {
            _loc2_ = new CookingUnit();
            _loc2_.addEventListener(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,this.onUnitClick);
            DialogPanel.functionalityBox.addUnit(_loc2_);
         }
      }
      
      private function onUnitClick(param1:FunctionalityBoxEvent) : void
      {
         if(param1.content == "cooking")
         {
            ServerBufferManager.getServerBuffer(ServerBufferType.COOKING_ACTIVITY,this.onGetSer,false);
            StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_73);
         }
      }
      
      private function initPot() : void
      {
         this._pot = this._map.content["con"].pot;
         this._pot.buttonMode = true;
         TooltipManager.addCommonTip(this._pot,"烹饪食物");
         this._pot.addEventListener(MouseEvent.CLICK,this.onPot);
      }
      
      private function onPot(param1:MouseEvent) : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.COOKING_ACTIVITY,this.onGetSer,false);
         StatisticsManager.sendNoviceAccountHttpd(StatisticsManager.ui_interact_74);
      }
      
      private function onGetSer(param1:ServerBuffer) : void
      {
         var _loc2_:Date = null;
         var _loc3_:Object = null;
         SeatTipsManager.removeSeat(new Point(695,200),125);
         if(param1.readDataAtPostion(0) != 0 && CookingActivityLoad.instance.checkTime)
         {
            _loc2_ = new Date(TimeManager.getServerTime() * 1000);
            _loc3_ = new Object();
            _loc3_.id = this.cookingDayList[param1.readDataAtPostion(0)];
            _loc3_.onComplete = this.onComplete;
            ModuleManager.toggleModule(URLUtil.getAppModule("NewCookingPanel"),"正在打开烹饪面板...",_loc3_);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("NewCookingPanel"),"正在打开烹饪面板...");
         }
      }
      
      private function setNpcStatus() : void
      {
         if(CookingActivityLoad.instance.checkTime)
         {
            this._npc.gotoAndStop(2);
            this._npc.buttonMode = true;
            this._npc.addEventListener(MouseEvent.CLICK,this.onClick);
         }
         else
         {
            this._npc.gotoAndStop(1);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
         ServerBufferManager.getServerBuffer(ServerBufferType.COOKING_ACTIVITY,this.onGetSerLeiNa);
      }
      
      private function onGetSerLeiNa(param1:ServerBuffer) : void
      {
         var data:Object = null;
         var server:ServerBuffer = param1;
         var ran:uint = uint(uint(Math.random() * 9) + 1);
         data = new Object();
         data.onComplete = this.onComplete;
         if(server.readDataAtPostion(0) == 0)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.COOKING_ACTIVITY,0,ran);
            data.id = this.cookingDayList[ran];
         }
         else
         {
            data.id = this.cookingDayList[server.readDataAtPostion(0)];
         }
         NpcDialog.show(491,"诺基",[[0,"饿……饿……雷纳要吃饭饭……你给我做好不好？我今天要吃" + ItemConfig.getItemName(this.cookingDayList[ran])]],["乖宝宝不哭！（去做料理）","我一会再来哄你"],[function():void
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("NewCookingPanel"),"正在打开烹饪面板...",data);
         }]);
      }
      
      private function onComplete(param1:uint) : void
      {
         var cookingID:uint = param1;
         MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("cookingActivity/cookingComplete2"),function():void
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.COOKING_ACTIVITY,0,0);
            _cookingComplete = CookingActivityLoad.instance.getMC("cookingComplete");
            _cookingComplete.stop();
            SwapManager.swapItem(364,1,function(param1:IDataInput):void
            {
               var data:IDataInput = param1;
               _map.front.addChild(_cookingComplete);
               ModuleManager.closeForName("NewCookingPanel");
               MovieClipUtil.playMc(_cookingComplete,2,75,function():void
               {
                  DisplayUtil.removeForParent(_cookingComplete);
                  new SwapInfo(data);
               },true);
            },null,new SpecialInfo(1,cookingID));
         },true,false,2);
      }
      
      public function dispose() : void
      {
         TimeManager.removeEventListener(TimeManager.TIME_UPDATE,this.onTimeUpdate);
         DialogPanel.functionalityBox.removeEventListener(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,this.onUnitClick);
         DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
         DisplayUtil.removeForParent(this._npc);
         DisplayUtil.removeForParent(this._cookingComplete);
         this._npc = null;
         this._cookingComplete = null;
         this._map = null;
      }
   }
}
