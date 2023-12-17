package com.taomee.seer2.app.popup.alert
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.popup.AlertInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   
   public class PiggyBankAlert extends Sprite implements IAlert
   {
       
      
      private var _popPanel:MovieClip;
      
      private var _cancelBtn:SimpleButton;
      
      private var _putMoneyBtn:SimpleButton;
      
      private var _contentTxt:TextField;
      
      private var _closeHandler:Function;
      
      private var _count:int;
      
      private const PUTMONEY:int = 40;
      
      private const EMPTYSTR:String = "        ";
      
      public function PiggyBankAlert()
      {
         super();
         this.initialize();
      }
      
      public function show(param1:AlertInfo) : void
      {
         this.updateContent();
         this._count = param1.initInfo.quantity;
         this._closeHandler = param1.initInfo.closeHandler;
         AlertManager.addPopUp(param1,this);
      }
      
      public function dispose() : void
      {
         this._closeHandler = null;
         this._cancelBtn.removeEventListener(MouseEvent.CLICK,this.onCancel);
         this._putMoneyBtn.removeEventListener(MouseEvent.CLICK,this.onPutMoney);
         this._contentTxt = null;
         this._putMoneyBtn = null;
         this._cancelBtn = null;
         this._popPanel = null;
         AlertManager.removePopUp(this);
         this.dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function initialize() : void
      {
         this._popPanel = UIManager.getMovieClip("UI_piggyBank");
         this._popPanel.scaleX = this._popPanel.scaleY = 0.1;
         TweenLite.to(this._popPanel,0.2,{
            "scaleX":1,
            "scaleY":1
         });
         addChild(this._popPanel);
         this._contentTxt = this._popPanel["contentTxt"];
         this._putMoneyBtn = this._popPanel["putMoneyBtn"];
         this._cancelBtn = this._popPanel["cancelBtn"];
         this._cancelBtn.addEventListener(MouseEvent.CLICK,this.onCancel);
         this._putMoneyBtn.addEventListener(MouseEvent.CLICK,this.onPutMoney);
      }
      
      private function updateContent() : void
      {
         var _loc1_:String = "<font color=\'#FFFF99\' size=\'14\'>1个赛尔豆</font>";
         switch(this._count)
         {
            case 0:
               this._contentTxt.htmlText = this.EMPTYSTR + "部落的人说，有一种谜一样的小精灵。清脆的铃声能把它引出来哦。要扔" + _loc1_ + "试试吗？";
               break;
            case 1:
               this._contentTxt.htmlText = this.EMPTYSTR + "要满足小精灵的要求吗？再扔" + _loc1_ + "把它引出来？";
               break;
            case 2:
               this._contentTxt.htmlText = this.EMPTYSTR + "再扔" + _loc1_ + "把它引下来吧？部落的人说这种小精灵会带来财运哦！";
         }
      }
      
      private function onCancel(param1:MouseEvent) : void
      {
         this.dispose();
      }
      
      private function onPutMoney(param1:MouseEvent) : void
      {
         if(ActorManager.actorInfo.coins < 1)
         {
            AlertManager.showAlert("赛尔豆不够哟");
            return;
         }
         SwapManager.swapItem(this.PUTMONEY,1,this.onReduceMoney);
      }
      
      private function onReduceMoney(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         if(this._closeHandler != null)
         {
            this._closeHandler();
            this._closeHandler = null;
         }
         this.dispose();
      }
   }
}
