package com.taomee.seer2.app.controls
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.TimeLimitConfig;
   import com.taomee.seer2.app.config.giftRemind.VipGiftInfo;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class GiftRemind
   {
      
      private static var _instance:com.taomee.seer2.app.controls.GiftRemind;
       
      
      private var _mc:MovieClip;
      
      private var _info:VipGiftInfo;
      
      private var _state:Vector.<int>;
      
      private const VIP_GET:int = 202258;
      
      private var rechargeBtn:MovieClip;
      
      public function GiftRemind()
      {
         super();
         if(ActorManager.actorInfo.vipInfo.isVip() == false)
         {
            this._state = new Vector.<int>([0,0]);
         }
         else
         {
            this._state = new Vector.<int>([0,0,0]);
         }
      }
      
      public static function get instance() : com.taomee.seer2.app.controls.GiftRemind
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.app.controls.GiftRemind();
         }
         return _instance;
      }
      
      public function stateHandle() : void
      {
      }
      
      public function closeMouse(param1:Boolean) : void
      {
      }
      
      private function updateGiftStatus(param1:Parser_1142) : void
      {
         var par:Parser_1142 = param1;
         this._state[0] = par.infoVec[0];
         this._state[1] = par.infoVec[1];
         if(this._state.length > 2)
         {
            if(!TimeLimitConfig.InLimitTime(245))
            {
               this._state[2] = 1;
               this.funHandle();
               return;
            }
            ActiveCountManager.requestActiveCount(this.VIP_GET,function(param1:int, param2:int):void
            {
               _state[1] = param2;
               funHandle();
            });
         }
         else
         {
            this.funHandle();
         }
      }
      
      private function funHandle() : void
      {
         if(this._state[0] == 0 || this._state[1] == 0 || this._state.length > 2 && this._state[2] == 0)
         {
            this.show();
         }
      }
      
      private function addEvent() : void
      {
         this._mc.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.hide();
         if(this._state[0] == 0 || this._state[1] == 0)
         {
            ModuleManager.showModule(URLUtil.getAppModule("VipGiftBagPanel"),"正在打开周月礼包面板...");
         }
         if(this._state.length > 2)
         {
            if(this._state[0] == 1 && this._state[1] == 1 && this._state[2] == 0)
            {
               ModuleManager.showModule(URLUtil.getAppModule("VipChristmasPanel"),"正在打开vip礼包面板...");
            }
         }
      }
      
      public function setVisible(param1:Boolean) : void
      {
      }
      
      public function setAllBtnsVisible(param1:Boolean) : void
      {
      }
      
      private function show() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function startFirstRecharge() : void
      {
      }
      
      private function updateRechargePosition() : void
      {
         if(Boolean(this.rechargeBtn) && this.rechargeBtn.visible == true)
         {
            if(Boolean(this._mc) && this._mc.visible == true)
            {
               this.rechargeBtn.y = this._mc.y - 5 - this.rechargeBtn.height;
            }
            else
            {
               this.rechargeBtn.y = 445;
            }
         }
      }
      
      private function onRechargeClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("VipRechargeBtnPanel"));
      }
      
      public function removeRecharge() : void
      {
         if(this.rechargeBtn)
         {
            DisplayObjectUtil.removeFromParent(this.rechargeBtn);
            this.rechargeBtn.removeEventListener(MouseEvent.CLICK,this.onRechargeClick);
            this.rechargeBtn = null;
         }
      }
      
      public function hideRecharge() : void
      {
         if(this.rechargeBtn)
         {
            this.rechargeBtn.visible = false;
         }
      }
      
      public function showRecharge() : void
      {
      }
   }
}
