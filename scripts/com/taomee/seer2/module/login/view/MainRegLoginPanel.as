package com.taomee.seer2.module.login.view
{
   import com.adobe.crypto.MD5;
   import com.taomee.seer2.module.login.agent.CookieAgent;
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.net.Connection;
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.StringUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.sendToURL;
   import flash.text.TextField;
   
   public class MainRegLoginPanel extends Sprite
   {
       
      
      private var _loginAgent:LoginAgent;
      
      private var _regLoginMc:MovieClip;
      
      private var _telecomBtn:SimpleButton;
      
      private var _netcomBtn:SimpleButton;
      
      private var _saveBtn:SimpleButton;
      
      private var _mimiInput:TextField;
      
      private var _pwdInput:TextField;
      
      private var _verifyInputPanel:com.taomee.seer2.module.login.view.VerifyCodeInputPanel;
      
      public function MainRegLoginPanel(param1:LoginAgent)
      {
         super();
         this._loginAgent = param1;
         this.initialize();
         this.initEventListeners();
      }
      
      private function initialize() : void
      {
         this._regLoginMc = DomainUtil.getMovieClip("MainRegLoginUI",LoaderAgent.getDomain("mainPage"));
         this._telecomBtn = this._regLoginMc["telecomBtn"];
         this._netcomBtn = this._regLoginMc["netcomBtn"];
         this._saveBtn = this._regLoginMc["saveBtn"];
         this._mimiInput = this._regLoginMc["mmGroup"]["mimiInput"];
         this._pwdInput = this._regLoginMc["mmGroup"]["pwdInput"];
         this._mimiInput.selectable = false;
         this._pwdInput.selectable = false;
         addChild(this._regLoginMc);
      }
      
      private function initEventListeners() : void
      {
         this._telecomBtn.addEventListener(MouseEvent.CLICK,this.onTelecomLogin);
         this._netcomBtn.addEventListener(MouseEvent.CLICK,this.onNetcomLogin);
         this._saveBtn.addEventListener(MouseEvent.CLICK,this.onSave);
         this._loginAgent.addEventListener(LoginEvent.LOGIN_FAIL,this.onGetVerifyCode);
      }
      
      private function onGetVerifyCode(param1:LoginEvent) : void
      {
         if(this._verifyInputPanel)
         {
            this._verifyInputPanel.x = 327;
            this._verifyInputPanel.y = 303;
            this._regLoginMc.addChild(this._verifyInputPanel);
            DisplayObjectUtil.enableButton(this._telecomBtn);
            DisplayObjectUtil.enableButton(this._netcomBtn);
         }
         switch(this._loginAgent.mainServerLoginInfo.resultFlag)
         {
            case 1:
               AlarmPanel.show(this,"\n密码输入不正确");
               break;
            case 2:
               if(this._verifyInputPanel.visible)
               {
                  AlarmPanel.show(this,"\n验证码输入不正确");
               }
               break;
            case 3:
               AlarmPanel.show(this,"\n帐号错误");
               break;
            case 4:
               AlarmPanel.show(this,"\n帐号被封停");
               break;
            case 5:
               AlarmPanel.show(this,"\n系统错误");
         }
         if(this._verifyInputPanel)
         {
            this._verifyInputPanel.visible = true;
         }
      }
      
      public function init(param1:uint, param2:String, param3:com.taomee.seer2.module.login.view.VerifyCodeInputPanel = null) : void
      {
         if(param3)
         {
            this._verifyInputPanel = param3;
            if(this._verifyInputPanel.visible == true)
            {
               this._verifyInputPanel.x = 327;
               this._verifyInputPanel.y = 303;
               this._regLoginMc.addChild(this._verifyInputPanel);
            }
            else
            {
               DisplayObjectUtil.removeFromParent(this._verifyInputPanel);
            }
         }
         this._mimiInput.text = String(param1);
         this._pwdInput.text = param2;
      }
      
      private function onSave(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = DomainUtil.getMovieClip("passportUI",LoaderAgent.getDomain("mainPage"));
         TextField(_loc2_["mimiTxt"]).text = this._mimiInput.text;
         TextField(_loc2_["pwdTxt"]).text = this._pwdInput.text;
         ResControl.instance.savePasswordByDisplayObject(uint(this._mimiInput.text),_loc2_);
         sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=bonus_2&mm=" + this._mimiInput.text));
      }
      
      private function onTelecomLogin(param1:MouseEvent) : void
      {
         if(this.verifyAccountAndPassword() == false)
         {
            return;
         }
         if(this._verifyInputPanel)
         {
            if(this._verifyInputPanel.visible == true && this._verifyInputPanel.isCodeEmpty == true)
            {
               AlarmPanel.show(this,"\n请输入验证码");
               return;
            }
            this._loginAgent.verifyCodeInfo.setVerifyCodeData(this._verifyInputPanel.getVerifyCodeData());
         }
         var _loc2_:String = StringUtil.trim(this._mimiInput.text);
         var _loc3_:String = MD5.hash(MD5.hash(this._pwdInput.text));
         sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=bonus_1&mm=" + _loc2_));
         sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=hp_18&mm=" + _loc2_));
         this._loginAgent.telLogin(_loc2_,_loc3_);
         WaitLoadingBar.show(this);
         DisplayObjectUtil.disableButton(this._telecomBtn);
         DisplayObjectUtil.disableButton(this._netcomBtn);
         LoginStatistics.newSendNovice("_newtrans_",_loc2_,"fSendLoginReq","前端发送登录请求");
      }
      
      private function onNetcomLogin(param1:MouseEvent) : void
      {
         if(this.verifyAccountAndPassword() == false)
         {
            return;
         }
         if(this._verifyInputPanel)
         {
            if(this._verifyInputPanel.visible == true && this._verifyInputPanel.isCodeEmpty == true)
            {
               AlarmPanel.show(this,"\n请输入验证码");
               return;
            }
            this._loginAgent.verifyCodeInfo.setVerifyCodeData(this._verifyInputPanel.getVerifyCodeData());
         }
         var _loc2_:String = StringUtil.trim(this._mimiInput.text);
         var _loc3_:String = MD5.hash(MD5.hash(this._pwdInput.text));
         sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=bonus_1&mm=" + _loc2_));
         sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=hp_18&mm=" + _loc2_));
         this._loginAgent.cncLogin(_loc2_,_loc3_);
         WaitLoadingBar.show(this);
         DisplayObjectUtil.disableButton(this._telecomBtn);
         DisplayObjectUtil.disableButton(this._netcomBtn);
         LoginStatistics.newSendNovice("_newtrans_",_loc2_,"fSendLoginReq","前端发送登录请求");
      }
      
      private function verifyAccountAndPassword() : Boolean
      {
         if(StringUtil.trim(this._mimiInput.text) == "" || StringUtil.trim(this._pwdInput.text) == "")
         {
            AlarmPanel.show(this,"\n请输入米米号或密码");
            return false;
         }
         return true;
      }
      
      public function saveAccountAndPassword() : void
      {
         var _loc1_:String = StringUtil.trim(this._mimiInput.text);
         var _loc2_:String = MD5.hash(MD5.hash(this._pwdInput.text));
         if(!this._loginAgent.isSidLogin)
         {
            CookieAgent.save(_loc1_,Connection.uid,_loc2_);
         }
      }
   }
}
