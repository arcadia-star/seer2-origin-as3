package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.net.Connection;
   import com.taomee.seer2.module.login.net.LittleEndianByteArray;
   import com.taomee.seer2.module.login.net.MessageEvent;
   import com.taomee.seer2.module.login.util.StringUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class CreateNamePage extends Sprite
   {
       
      
      private const DEFAULT_NICK_NAME:String = "小赛尔";
      
      private const NICK_LONG_TIPS:String = "昵称太长了!";
      
      private const NICK_DIRTY_TIPS:String = "你输入的昵称不合法，目前昵称只能使用“小赛尔”!";
      
      private const RANDOM_LAST:Array = ["小"];
      
      private const RANDOM_NIKE:Array = ["赛尔"];
      
      private var _mainUI:MovieClip;
      
      private var _nickTxt:TextField;
      
      private var _randomBtn:SimpleButton;
      
      private var _checkGo:Function;
      
      public function CreateNamePage(param1:MovieClip, param2:Function = null)
      {
         super();
         this._mainUI = param1;
         this._checkGo = param2;
         this._nickTxt = this._mainUI["nickTxt"];
         this._nickTxt.maxChars = 8;
         this._nickTxt.addEventListener(FocusEvent.FOCUS_IN,this.onNickTxtFocusIn);
         Connection.addErrorHandler(107,this.onCreateRoleError);
         this._randomBtn = this._mainUI["randomBtn"];
         this._nickTxt.addEventListener(Event.CHANGE,this.onChange);
         this._randomBtn.addEventListener(MouseEvent.CLICK,this.onRandom);
         this.onRandom(null);
      }
      
      private function onCreateRoleError(param1:MessageEvent) : void
      {
         switch(param1.message.statusCode)
         {
            case 6006:
            case 6007:
            case 6008:
               this.showError(this.NICK_DIRTY_TIPS);
         }
      }
      
      private function onChange(param1:Event) : void
      {
         if(this._checkGo != null)
         {
            this._checkGo();
         }
      }
      
      private function onNickTxtFocusIn(param1:FocusEvent) : void
      {
         this._nickTxt.textColor = 16777215;
         this._nickTxt.text = "小赛尔";
      }
      
      private function onRandom(param1:MouseEvent) : void
      {
         var _loc2_:String = String(this.RANDOM_LAST[uint(Math.random() * this.RANDOM_LAST.length)]);
         var _loc3_:String = String(this.RANDOM_NIKE[uint(Math.random() * this.RANDOM_NIKE.length)]);
         this._nickTxt.text = _loc2_ + _loc3_;
         if(this._checkGo != null && Boolean(param1))
         {
            this._checkGo();
         }
      }
      
      public function onNextClick() : Boolean
      {
         if(this.validateNick(this._nickTxt.text))
         {
            return true;
         }
         return false;
      }
      
      private function validateNick(param1:String) : Boolean
      {
         if(param1 == this.NICK_DIRTY_TIPS)
         {
            return false;
         }
         if(StringUtil.trim(param1) == "")
         {
            return false;
         }
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUTFBytes(param1);
         if(_loc2_.length > 16)
         {
            this.showError(this.NICK_LONG_TIPS);
            return false;
         }
         return true;
      }
      
      public function getNick() : String
      {
         this._nickTxt.text = "小赛尔";
         return this._nickTxt.text;
      }
      
      public function showError(param1:String) : void
      {
         this._nickTxt.textColor = 16711680;
         this._nickTxt.text = param1;
      }
      
      public function dispose() : void
      {
         this._mainUI = null;
         this._nickTxt = null;
      }
   }
}
