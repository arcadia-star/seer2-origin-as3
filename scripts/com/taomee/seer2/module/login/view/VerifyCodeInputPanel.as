package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.net.LittleEndianByteArray;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   
   public class VerifyCodeInputPanel extends Sprite
   {
       
      
      private var _verifyCodeInputMc:MovieClip;
      
      private var _verifyInput:TextField;
      
      private var _loginAgent:LoginAgent;
      
      private var _verifyImgLoader:Loader;
      
      private var _verifyCodeData:LittleEndianByteArray;
      
      private var _changeBtn:SimpleButton;
      
      private var _domain:ApplicationDomain;
      
      public function VerifyCodeInputPanel(param1:LoginAgent, param2:ApplicationDomain)
      {
         super();
         this._loginAgent = param1;
         this._domain = param2;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.initEventListener();
      }
      
      private function createChildren() : void
      {
         this._verifyCodeInputMc = DomainUtil.getMovieClip("VerifyCodeInputUI",this._domain);
         this._verifyInput = this._verifyCodeInputMc["txtInput"];
         this._changeBtn = this._verifyCodeInputMc["changeVerifyImgBtn"];
         addChild(this._verifyCodeInputMc);
         this._verifyInput.maxChars = 4;
      }
      
      private function initEventListener() : void
      {
         this._changeBtn.addEventListener(MouseEvent.CLICK,this.onChangeVerifyImg);
         this._loginAgent.addEventListener(LoginEvent.GET_VERIFY_CODE,this.onGetVerifyCode);
      }
      
      private function clearEventListener() : void
      {
         this._changeBtn.removeEventListener(MouseEvent.CLICK,this.onChangeVerifyImg);
         this._loginAgent.removeEventListener(LoginEvent.GET_VERIFY_CODE,this.onGetVerifyCode);
      }
      
      private function onChangeVerifyImg(param1:MouseEvent) : void
      {
         this._loginAgent.getVerifyCode();
      }
      
      private function onGetVerifyCode(param1:LoginEvent) : void
      {
         if(Boolean(this._verifyImgLoader) && Boolean(this._verifyImgLoader.parent))
         {
            this._verifyCodeInputMc.verifyImgContainer.removeChild(this._verifyImgLoader);
         }
         this._verifyImgLoader = new Loader();
         this._verifyImgLoader.loadBytes(this._loginAgent.verifyCodeInfo.getVerifyImgData());
         this._verifyCodeInputMc.verifyImgContainer.addChild(this._verifyImgLoader);
         this._verifyInput.text = "";
      }
      
      public function getVerifyCodeData() : LittleEndianByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._verifyInput.text != "")
         {
            _loc1_ = 6;
            this._verifyCodeData = new LittleEndianByteArray();
            _loc2_ = Math.min(this._verifyInput.length,_loc1_);
            _loc3_ = this._verifyInput.text;
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               this._verifyCodeData.writeByte(_loc3_.charCodeAt(_loc4_));
               _loc4_++;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc1_ - _loc2_)
            {
               this._verifyCodeData.writeByte(0);
               _loc5_++;
            }
         }
         return this._verifyCodeData;
      }
      
      public function get isCodeEmpty() : Boolean
      {
         if(this._verifyInput.text != "")
         {
            return false;
         }
         return true;
      }
      
      public function dispose() : void
      {
         this.clearEventListener();
         this._verifyCodeInputMc = null;
         this._verifyInput = null;
         this._loginAgent = null;
         this._verifyImgLoader = null;
         this._verifyCodeData = null;
         this._domain = null;
      }
   }
}
