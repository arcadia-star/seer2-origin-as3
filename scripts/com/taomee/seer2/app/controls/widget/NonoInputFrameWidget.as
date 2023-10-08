package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.config.VipConfig2;
   import com.taomee.seer2.app.config.giftRemind.VipGiftInfo;
   import com.taomee.seer2.app.controls.GiftRemind;
   import com.taomee.seer2.app.controls.ToolbarEvent;
   import com.taomee.seer2.app.controls.ToolbarEventDispatcher;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.app.vip.data.VipInfo;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class NonoInputFrameWidget extends Sprite implements IWidgetable
   {
      
      public static const NONOINPUT:String = "NonoInput";
       
      
      private var _mainUI:MovieClip;
      
      private var _pageMC:MovieClip;
      
      private var _nonoBtn:SimpleButton;
      
      private var _nonoBtn2:MovieClip;
      
      private var _btnList:Vector.<SimpleButton>;
      
      private var _isShow:Boolean;
      
      private var tempBtn:SimpleButton;
      
      private var _info:VipGiftInfo;
      
      private var _giftInfo:VipGiftInfo;
      
      private var EVERY_DAY:int = 1464;
      
      public function NonoInputFrameWidget(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this.initMC();
         this.initEventListener();
      }
      
      private function initMC() : void
      {
         this._nonoBtn2 = this._mainUI["nonoBtn2"];
         this._nonoBtn2.visible = false;
         this._nonoBtn = this._mainUI["nonoBtn"];
         this._pageMC = this._mainUI["pageMC"];
         this._btnList = Vector.<SimpleButton>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            this._btnList.push(this._pageMC["btn" + _loc1_]);
            _loc1_++;
         }
         this.tempBtn = this._pageMC["btn7"];
         this._isShow = false;
         this.updateTooltip();
         this.updateNonoPage();
         this.onVipUpdate(null);
      }
      
      private function updateTooltip() : void
      {
         TooltipManager.addCommonTip(this._nonoBtn,"VIP和星石");
      }
      
      private function initEventListener() : void
      {
         var _loc1_:SimpleButton = null;
         this._nonoBtn.addEventListener(MouseEvent.ROLL_OVER,this.onNono);
         this._nonoBtn2.buttonMode = true;
         this._nonoBtn2.addEventListener(MouseEvent.CLICK,this.onNono2);
         this._nonoBtn2.addEventListener(MouseEvent.ROLL_OVER,this.onNono);
         for each(_loc1_ in this._btnList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onBtn);
         }
         this.tempBtn.addEventListener(MouseEvent.CLICK,this.onTemp);
         this._mainUI.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         ToolbarEventDispatcher.addEventListener(ToolbarEvent.PAGE_CHANGE,this.onChange);
         ToolbarEventDispatcher.addEventListener(ToolbarEvent.TOOLBAR_HIDE,this.onHide);
         VipManager.vipInfo.addEventListener(VipInfo.VIP_UPDATE,this.onVipUpdate);
      }
      
      private function onVipUpdate(param1:Event) : void
      {
         var event:Event = param1;
         this._nonoBtn2.visible = false;
         this.getMonthWeek();
         this.updateGiftLevel();
         DayLimitManager.getDoCount(this.EVERY_DAY,function(param1:int):void
         {
            if(param1 == 0)
            {
               _nonoBtn2.visible = true;
            }
            else if(param1 == 1)
            {
            }
         });
      }
      
      private function updateGiftLevel() : void
      {
         if(VipManager.vipInfo.vipFlag == 0)
         {
            if(Boolean(VipManager.vipInfo.onceVipFlag) && VipManager.vipInfo.vipFlag == 0)
            {
            }
         }
      }
      
      private function getMonthWeek() : void
      {
         var _loc1_:int = int(VipManager.vipInfo.level);
         if(VipManager.vipInfo.vipFlag == 0)
         {
            this._info = VipConfig2.getGiftInfo(0);
         }
         else
         {
            this._info = VipConfig2.getGiftInfo(_loc1_);
         }
         if(this._info != null)
         {
            ActiveCountManager.requestActiveCount(this._info.monthCheck,this.updateGiftStatus);
            ActiveCountManager.requestActiveCount(this._info.weekCheck,this.updateGiftStatus);
         }
      }
      
      private function updateGiftStatus(param1:int, param2:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc3_:int = int(VipManager.vipInfo.level);
         if(VipManager.vipInfo.vipFlag == 0)
         {
            _loc3_ = 0;
         }
         this._giftInfo = VipConfig2.getGiftInfo(_loc3_);
         switch(param1)
         {
            case this._giftInfo.weekCheck:
               if(_loc3_ == 0)
               {
               }
               break;
            case this._giftInfo.monthCheck:
               if(_loc3_ == 0)
               {
               }
         }
         if(param2 == 0)
         {
            this._nonoBtn2.visible = true;
         }
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         this.onHide(null);
         ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE,false,NONOINPUT));
      }
      
      private function onHide(param1:ToolbarEvent) : void
      {
         this._isShow = false;
         this.updateNonoPage();
      }
      
      private function onChange(param1:ToolbarEvent) : void
      {
         if(param1.typeStr != NONOINPUT && param1.status)
         {
            this._isShow = false;
            this.updateNonoPage();
         }
      }
      
      private function updateNonoPage() : void
      {
         this._pageMC.visible = this._isShow;
         if(this._isShow)
         {
            this._pageMC.mouseChildren = true;
            this._pageMC.mouseEnabled = true;
            GiftRemind.instance.closeMouse(true);
         }
         else
         {
            this._pageMC.mouseChildren = false;
            this._pageMC.mouseEnabled = false;
            GiftRemind.instance.closeMouse(false);
         }
      }
      
      private function onNono(param1:MouseEvent) : void
      {
         this._isShow = !this._isShow;
         ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE,this._isShow,NONOINPUT));
         this.updateNonoPage();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_311);
      }
      
      private function onNono2(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.currentTarget)["mc"];
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         ModuleManager.showModule(URLUtil.getAppModule("VipGiftBagPanel"),"");
      }
      
      private function onBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = this._btnList.indexOf(param1.currentTarget as SimpleButton);
         var _loc3_:String = "";
         if(_loc2_ == 6)
         {
            VipManager.entryMi();
            return;
         }
         switch(_loc2_)
         {
            case 0:
               _loc3_ = "VipGiftBagPanel";
               break;
            case 1:
               _loc3_ = "VipStarShouHuPanel";
               break;
            case 2:
               _loc3_ = "VipGiftBagPanel";
               break;
            case 3:
               _loc3_ = "VipStarStone";
               break;
            case 4:
               _loc3_ = "NewVipPanel";
               break;
            case 5:
               _loc3_ = "SuperNonoPanel";
         }
         if(_loc3_ == "NewVipPanel")
         {
            ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE,this._isShow,"NewVipPanel"));
         }
         ModuleManager.toggleModule(URLUtil.getAppModule(_loc3_),"正在vip面板...");
         SoundEffects.playBtnClick();
      }
      
      private function onTemp(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NewYearVipPetPanel");
      }
   }
}
