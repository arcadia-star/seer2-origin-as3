package com.taomee.seer2.app.utils
{
   import com.taomee.seer2.app.vip.VipManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class VIPHelperHandle
   {
       
      
      private var _mcVIPTip:MovieClip;
      
      private var _buyVipBtn:SimpleButton;
      
      public function VIPHelperHandle(param1:MovieClip, param2:int = 1, param3:String = "buyVip")
      {
         super();
         this._mcVIPTip = param1;
         if(VipManager.vipInfo.isVip())
         {
            this._mcVIPTip.gotoAndStop(param2);
         }
         else
         {
            this._mcVIPTip.gotoAndStop(3 - param2);
            this._buyVipBtn = this._mcVIPTip[param3];
            if(this._buyVipBtn)
            {
               this._buyVipBtn.addEventListener(MouseEvent.CLICK,this.onBuyVIP);
            }
         }
      }
      
      protected function onBuyVIP(param1:MouseEvent) : void
      {
         VipManager.navigateToPayPage();
      }
   }
}
