package com.taomee.seer2.module.login.view
{
   import com.adobe.crypto.MD5;
   import com.taomee.seer2.module.login.agent.CookieAgent;
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.config.LoginConfig;
   import com.taomee.seer2.module.login.data.CookieInfo;
   import com.taomee.seer2.module.login.data.LoginUserInfo;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.net.Connection;
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.EquipUtil;
   import com.taomee.seer2.module.login.util.HttpURLUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.StringUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.setTimeout;
   import org.taomee.register.util.WeakPasswordUtil;
   
   public class MainLoginPanel extends Sprite
   {
       
      
      private const SELECTED_FRAME:uint = 1;
      
      private const UN_SELELTECD_FRAME:uint = 2;
      
      private var _loginAgent:LoginAgent;
      
      private var _loginMc:MovieClip;
      
      private var _verifyInputPanel:com.taomee.seer2.module.login.view.VerifyCodeInputPanel;
      
      private var _accountInputTxt:TextField;
      
      private var _passwordInputTxt:TextField;
      
      private var _saveAccountCheckBox:MovieClip;
      
      private var _savePasswordCheckBox:MovieClip;
      
      private var _telecomLoginBtn:SimpleButton;
      
      private var _netcomLoginBtn:SimpleButton;
      
      private var _recordAccountMc:MovieClip;
      
      private var _recordPasswordMc:MovieClip;
      
      private var _findPasswordBtn:SimpleButton;
      
      private var _modifyPasswordBtn:SimpleButton;
      
      private var _protectPasswordBtn:SimpleButton;
      
      private var _useOtherBtn:SimpleButton;
      
      private var _applyBtn:SimpleButton;
      
      private var _promoteFlag:MovieClip;
      
      private var _account:String;
      
      private var _password:String;
      
      private var _savedPassword:String;
      
      private var _isBlank:Boolean;
      
      private var _userId:uint;
      
      private var _isSaveAccount:Boolean = true;
      
      private var _isSavePassword:Boolean = true;
      
      private var _domain:ApplicationDomain;
      
      private var _callBack:Function;
      
      public function MainLoginPanel(param1:LoginAgent, param2:Boolean, param3:Function = null)
      {
         super();
         this._loginAgent = param1;
         this._isBlank = param2;
         this._callBack = param3;
         LoaderAgent.addEventListener("mainPage",this.onLoadMainPage);
         LoaderAgent.loadDomain("mainPage");
      }
      
      private function onLoadMainPage(param1:Event) : void
      {
         LoaderAgent.removeEventListner("mainPage",this.onLoadMainPage);
         this._domain = LoaderAgent.getDomain("mainPage");
         this.initialize();
         if(this._callBack != null)
         {
            this._callBack();
            this._callBack = null;
         }
      }
      
      private function initialize() : void
      {
         DisplayObjectUtil.disableSprite(this);
         this.createChidren();
         this.initEventListener();
         this.initInputText();
         if(CookieAgent.cookieLen == 0)
         {
            DisplayObjectUtil.disableButton(this._useOtherBtn);
         }
         else
         {
            DisplayObjectUtil.enableButton(this._useOtherBtn);
         }
         if(this._loginAgent.isLoadIpConfig == false)
         {
            WaitLoadingBar.show(this);
            this._loginAgent.addEventListener(LoginEvent.LOAD_IP_CONFIG_COMPLETE,this.onIpConfigLoaded);
         }
         else
         {
            this.padpromoteFlag();
         }
      }
      
      private function createChidren() : void
      {
         this._loginMc = DomainUtil.getMovieClip("MainLoginUI",this._domain);
         this._accountInputTxt = this._loginMc["txtIdInput"];
         this._accountInputTxt.text = "";
         this._accountInputTxt.tabEnabled = true;
         this._accountInputTxt.tabIndex = 0;
         this._passwordInputTxt = this._loginMc["txtPwdInput"];
         this._passwordInputTxt.text = "";
         this._passwordInputTxt.tabEnabled = true;
         this._passwordInputTxt.tabIndex = 1;
         this._passwordInputTxt.displayAsPassword = true;
         this._saveAccountCheckBox = this._loginMc["saveIdBox"];
         this._saveAccountCheckBox.gotoAndStop(this.SELECTED_FRAME);
         this._savePasswordCheckBox = this._loginMc["savePwdBox"];
         this._savePasswordCheckBox.gotoAndStop(this.SELECTED_FRAME);
         this._saveAccountCheckBox.buttonMode = true;
         this._savePasswordCheckBox.buttonMode = true;
         this._recordAccountMc = this._loginMc["recordAccountMc"];
         this._recordPasswordMc = this._loginMc["recordPasswordMc"];
         this._telecomLoginBtn = this._loginMc["telecomBtn"];
         this._netcomLoginBtn = this._loginMc["netcomBtn"];
         this._findPasswordBtn = this._loginMc["findPasswordBtn"];
         this._modifyPasswordBtn = this._loginMc["modifyPasswordBtn"];
         this._protectPasswordBtn = this._loginMc["protectPasswordBtn"];
         this._useOtherBtn = this._loginMc["useOtherBtn"];
         this._applyBtn = this._loginMc["applyBtn"];
         this._promoteFlag = this._loginMc["premoteFlag"];
         addChild(this._loginMc);
         this._verifyInputPanel = new com.taomee.seer2.module.login.view.VerifyCodeInputPanel(this._loginAgent,this._domain);
         this._verifyInputPanel.visible = false;
         this._verifyInputPanel.x = 482;
         this._verifyInputPanel.y = 231;
         addChild(this._verifyInputPanel);
      }
      
      private function initInputText() : void
      {
         if(LoginModule.userId != "" && LoginModule.userId != null)
         {
            this.setAccountPassword(LoginModule.userId,"");
            return;
         }
      }
      
      private function initEventListener() : void
      {
         this._accountInputTxt.addEventListener(Event.CHANGE,this.onTextChange);
         this._loginAgent.addEventListener(LoginEvent.LOGIN_FAIL,this.onGetVerifyCode);
         this._loginAgent.addEventListener(LoginEvent.NO_VERITY_CODE,this.noVerityCode);
         this._loginAgent.addEventListener(LoginEvent.LOGIN_ERROR,this.onLoginError);
         this._loginAgent.addEventListener(LoginEvent.LOAD_CNC_TEL_COMPLETE,this.onLoadCncTelComplete);
         this._passwordInputTxt.addEventListener(Event.CHANGE,this.onPasswordChanged);
         this._passwordInputTxt.addEventListener(FocusEvent.FOCUS_IN,this.onCheckVerify);
         this._telecomLoginBtn.addEventListener(MouseEvent.CLICK,this.onTelecomLogin);
         this._netcomLoginBtn.addEventListener(MouseEvent.CLICK,this.onNetcomLogin);
         this._findPasswordBtn.addEventListener(MouseEvent.CLICK,this.onFindPassword);
         this._modifyPasswordBtn.addEventListener(MouseEvent.CLICK,this.onModifyPassword);
         this._protectPasswordBtn.addEventListener(MouseEvent.CLICK,this.onProtectPassword);
         this._saveAccountCheckBox.addEventListener(MouseEvent.CLICK,this.onSaveAccountCheckBoxClick);
         this._savePasswordCheckBox.addEventListener(MouseEvent.CLICK,this.onSavePasswordCheckBoxClick);
         this._applyBtn.addEventListener(MouseEvent.CLICK,this.onApplyAccount);
         this._useOtherBtn.addEventListener(MouseEvent.CLICK,this.onOherUserLogin);
         this.addEventListener(KeyboardEvent.KEY_DOWN,this.onEnterLogin);
      }
      
      private function onEnterLogin(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            if(this._loginAgent.isTel == true)
            {
               this.onTelecomLogin(null);
            }
            else
            {
               this.onNetcomLogin(null);
            }
         }
      }
      
      private function onTextChange(param1:Event) : void
      {
         this._loginAgent.isSidLogin = false;
         this._passwordInputTxt.text = "";
      }
      
      private function closeEventListener() : void
      {
         this._accountInputTxt.removeEventListener(Event.CHANGE,this.onTextChange);
         this._loginAgent.removeEventListener(LoginEvent.LOAD_IP_CONFIG_COMPLETE,this.onIpConfigLoaded);
         this._loginAgent.removeEventListener(LoginEvent.LOGIN_FAIL,this.onGetVerifyCode);
         this._loginAgent.removeEventListener(LoginEvent.NO_VERITY_CODE,this.noVerityCode);
         this._loginAgent.removeEventListener(LoginEvent.LOGIN_ERROR,this.onLoginError);
         this._loginAgent.removeEventListener(LoginEvent.LOAD_CNC_TEL_COMPLETE,this.onLoadCncTelComplete);
         this._passwordInputTxt.removeEventListener(Event.CHANGE,this.onPasswordChanged);
         this._passwordInputTxt.removeEventListener(FocusEvent.FOCUS_IN,this.onCheckVerify);
         this._telecomLoginBtn.removeEventListener(MouseEvent.CLICK,this.onTelecomLogin);
         this._netcomLoginBtn.removeEventListener(MouseEvent.CLICK,this.onNetcomLogin);
         this._findPasswordBtn.removeEventListener(MouseEvent.CLICK,this.onFindPassword);
         this._modifyPasswordBtn.removeEventListener(MouseEvent.CLICK,this.onModifyPassword);
         this._protectPasswordBtn.removeEventListener(MouseEvent.CLICK,this.onProtectPassword);
         this._saveAccountCheckBox.removeEventListener(MouseEvent.CLICK,this.onSaveAccountCheckBoxClick);
         this._savePasswordCheckBox.removeEventListener(MouseEvent.CLICK,this.onSavePasswordCheckBoxClick);
         this._applyBtn.removeEventListener(MouseEvent.CLICK,this.onApplyAccount);
         this._useOtherBtn.removeEventListener(MouseEvent.CLICK,this.onOherUserLogin);
         this.removeEventListener(KeyboardEvent.KEY_DOWN,this.onEnterLogin);
      }
      
      private function onLoadCncTelComplete(param1:LoginEvent) : void
      {
         WaitLoadingBar.hide();
      }
      
      private function onPasswordChanged(param1:Event) : void
      {
         this._savedPassword = null;
      }
      
      private function onCheckVerify(param1:FocusEvent) : void
      {
         var _loc2_:uint = 0;
         if(this._verifyInputPanel.visible == false)
         {
            _loc2_ = uint(StringUtil.trim(this._accountInputTxt.text));
            Connection.setUserId(_loc2_);
         }
      }
      
      private function onIpConfigLoaded(param1:Event) : void
      {
         this._loginAgent.removeEventListener(LoginEvent.LOAD_IP_CONFIG_COMPLETE,this.onIpConfigLoaded);
         WaitLoadingBar.hide();
         this.padpromoteFlag();
      }
      
      private function padpromoteFlag() : void
      {
         DisplayObjectUtil.enableSprite(this);
         if(this._loginAgent.isTel == true)
         {
            this.setChildPostion(this._promoteFlag,478,390);
         }
         else
         {
            this.setChildPostion(this._promoteFlag,600,390);
         }
      }
      
      private function onGetVerifyCode(param1:LoginEvent) : void
      {
         this._verifyInputPanel.x = 482;
         this._verifyInputPanel.y = 231;
         addChild(this._verifyInputPanel);
         this.adjustPosition();
         switch(this._loginAgent.mainServerLoginInfo.resultFlag)
         {
            case 1:
               this._passwordInputTxt.text = "";
               AlarmPanel.show(this,"\n密码输入不正确");
               break;
            case 2:
               if(this._verifyInputPanel.visible)
               {
                  AlarmPanel.show(this,"\n验证码输入不正确");
               }
               break;
            case 3:
               this._accountInputTxt.text = "";
               this._passwordInputTxt.text = "";
               AlarmPanel.show(this,"\n帐号错误");
               break;
            case 4:
               this._accountInputTxt.text = "";
               this._passwordInputTxt.text = "";
               AlarmPanel.show(this,"\n帐号被封停");
               break;
            case 5:
               AlarmPanel.show(this,"\n系统错误");
         }
         this._verifyInputPanel.visible = true;
         DisplayObjectUtil.enableButton(this._telecomLoginBtn);
         DisplayObjectUtil.enableButton(this._netcomLoginBtn);
      }
      
      private function noVerityCode(param1:LoginEvent) : void
      {
         this._verifyInputPanel.visible = false;
         this.adjustPosition(-30);
      }
      
      private function adjustPosition(param1:int = 0) : void
      {
         this.setChildPostion(this._recordAccountMc,484,265 + param1);
         this.setChildPostion(this._recordPasswordMc,648,265 + param1);
         this.setChildPostion(this._saveAccountCheckBox,486,269 + param1);
         this.setChildPostion(this._savePasswordCheckBox,650,269 + param1);
         this.setChildPostion(this._findPasswordBtn,565,321 + param1);
         this.setChildPostion(this._modifyPasswordBtn,649,321 + param1);
         this.setChildPostion(this._protectPasswordBtn,733,321 + param1);
         this.setChildPostion(this._telecomLoginBtn,604,383 + param1);
         this.setChildPostion(this._promoteFlag,this._promoteFlag.x,327 + param1);
         this.setChildPostion(this._netcomLoginBtn,753,383 + param1);
         this.setChildPostion(this._useOtherBtn,615,412 + param1);
         this.setChildPostion(this._applyBtn,715,412 + param1);
      }
      
      private function setChildPostion(param1:DisplayObject, param2:int, param3:int) : void
      {
         param1.x = param2;
         param1.y = param3;
      }
      
      private function onLoginError(param1:LoginEvent) : void
      {
         this._passwordInputTxt.text = "";
         AlarmPanel.show(this,param1.info);
         DisplayObjectUtil.enableButton(this._telecomLoginBtn);
         DisplayObjectUtil.enableButton(this._netcomLoginBtn);
      }
      
      private function verifyAccountAndPassword() : Boolean
      {
         if(StringUtil.trim(this._accountInputTxt.text) == "" || StringUtil.trim(this._passwordInputTxt.text) == "")
         {
            AlarmPanel.show(this,"\n帐号和密码不能为空");
            return false;
         }
         if(this.getAccountState(this._accountInputTxt.text) == 0)
         {
            AlarmPanel.show(this,"\n帐号错误");
            return false;
         }
         if(this._verifyInputPanel.visible == true && this._verifyInputPanel.isCodeEmpty == true)
         {
            AlarmPanel.show(this,"\n请输入验证码");
            return false;
         }
         return true;
      }
      
      private function getAccountState(param1:String) : uint
      {
         var _loc2_:RegExp = /^[0-9]{5,10}$/;
         var _loc3_:RegExp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
         var _loc4_:RegExp = /^[a-zA-Z0-9_]{6,20}$/;
         var _loc5_:RegExp = /^[0-9]{11}$/;
         if(_loc2_.test(param1) == true)
         {
            return 1;
         }
         if(_loc3_.test(param1) == true || _loc4_.test(param1) == true || _loc5_.test(param1) == true)
         {
            return 2;
         }
         return 0;
      }
      
      private function onTelecomLogin(param1:MouseEvent) : void
      {
         this.login("Telecom");
      }
      
      private function login(param1:String) : void
      {
         var loginPanel:MainLoginPanel = null;
         var onConfirm:Function = null;
         var actualLogin:Function = null;
         var net:String = param1;
         var checkPassword:Function = function(param1:String):Boolean
         {
            if(param1 == null || param1 == "")
            {
               return false;
            }
            if(param1.length < 6)
            {
               return false;
            }
            if(WeakPasswordUtil.isContainIllegalChar(param1))
            {
               return false;
            }
            if(WeakPasswordUtil.isWeakPassword(param1))
            {
               return false;
            }
            return true;
         };
         onConfirm = function():void
         {
            AlarmPwdPanel.hide();
            navigateToURL(new URLRequest("http://account.61.com/change"),"_blank");
         };
         actualLogin = function():void
         {
            AlarmPwdPanel.hide();
            _loginAgent.verifyCodeInfo.setVerifyCodeData(_verifyInputPanel.getVerifyCodeData());
            _account = StringUtil.trim(_accountInputTxt.text);
            if(_savedPassword != null)
            {
               _password = _savedPassword;
            }
            else
            {
               _password = MD5.hash(MD5.hash(_passwordInputTxt.text));
            }
            if(net == "Telecom")
            {
               _loginAgent.telLogin(_account,_password);
            }
            else
            {
               _loginAgent.cncLogin(_account,_password);
            }
            WaitLoadingBar.show(loginPanel);
            DisplayObjectUtil.disableButton(_telecomLoginBtn);
            DisplayObjectUtil.disableButton(_netcomLoginBtn);
            setTimeout(enableButtons,8000);
         };
         loginPanel = this;
         if(this.verifyAccountAndPassword() == false)
         {
            return;
         }
         if(checkPassword(this._passwordInputTxt.text) == false)
         {
            AlarmPwdPanel.show(this,"你的密码太简单啦！英文+数字更加安全哦！",onConfirm,actualLogin);
            return;
         }
         actualLogin();
      }
      
      private function enableButtons() : void
      {
         if(Boolean(this._telecomLoginBtn) && Boolean(this._netcomLoginBtn))
         {
            DisplayObjectUtil.enableButton(this._telecomLoginBtn);
            DisplayObjectUtil.enableButton(this._netcomLoginBtn);
         }
      }
      
      private function onNetcomLogin(param1:MouseEvent) : void
      {
         this.login("CNC");
      }
      
      private function onSaveAccountCheckBoxClick(param1:MouseEvent) : void
      {
         if(this._isSaveAccount == false)
         {
            this._isSaveAccount = true;
            this._saveAccountCheckBox.gotoAndStop(this.SELECTED_FRAME);
         }
         else
         {
            this._isSaveAccount = false;
            this._isSavePassword = false;
            this._saveAccountCheckBox.gotoAndStop(this.UN_SELELTECD_FRAME);
            this._savePasswordCheckBox.gotoAndStop(this.UN_SELELTECD_FRAME);
         }
      }
      
      private function onSavePasswordCheckBoxClick(param1:MouseEvent) : void
      {
         if(this._isSavePassword == false)
         {
            this._isSavePassword = true;
            this._savePasswordCheckBox.gotoAndStop(this.SELECTED_FRAME);
         }
         else
         {
            this._isSavePassword = false;
            this._savePasswordCheckBox.gotoAndStop(this.UN_SELELTECD_FRAME);
         }
      }
      
      public function saveAccountAndPassword() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._isSaveAccount)
         {
            _loc1_ = StringUtil.trim(this._accountInputTxt.text);
            _loc2_ = MD5.hash(MD5.hash(this._passwordInputTxt.text));
            if(this._savedPassword != null)
            {
               _loc2_ = this._savedPassword;
            }
            if(this._isSavePassword == false)
            {
               _loc2_ = "";
            }
         }
         else
         {
            _loc1_ = "";
            _loc2_ = "";
         }
         if(!this._loginAgent.isSidLogin)
         {
            CookieAgent.save(_loc1_,Connection.uid,_loc2_);
         }
      }
      
      private function onFindPassword(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(HttpURLUtil.forgetURL),"_blank");
      }
      
      private function onModifyPassword(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(HttpURLUtil.changeURL),"_blank");
      }
      
      private function onProtectPassword(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(HttpURLUtil.protectURL),"_blank");
      }
      
      private function onOherUserLogin(param1:MouseEvent) : void
      {
         this.setAccountPassword("","");
         this.showActorPreview();
         dispatchEvent(new LoginEvent(LoginEvent.OTHER_USER_LOGIN));
      }
      
      private function onApplyAccount(param1:MouseEvent) : void
      {
         if(LoginModule.tmcid == LoginModule.TMCID_FROM_360)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("showLayer",LoginConfig.productID);
            }
         }
         else
         {
            dispatchEvent(new LoginEvent(LoginEvent.APPLY_MIMI,this._verifyInputPanel));
         }
         LoginStatistics.sendAccountNovice(LoginStatistics.clickRegister2,"0");
      }
      
      public function showActorPreview() : void
      {
         if(this._accountInputTxt == null)
         {
            return;
         }
         var _loc1_:CookieInfo = CookieAgent.getCookieInfo(this._accountInputTxt.text);
         var _loc2_:LoginUserInfo = new LoginUserInfo();
         _loc2_.equipVec = new Vector.<int>();
         if(_loc1_ != null)
         {
            _loc2_.equipVec = Vector.<int>(_loc1_.equipReferenceIdArr);
         }
         EquipUtil.mergeDefaultEquip(0,_loc2_.equipVec);
      }
      
      public function setAccountPassword(param1:String, param2:String) : void
      {
         if(this._accountInputTxt == null)
         {
            return;
         }
         this._accountInputTxt.text = param1;
         this._savedPassword = param2;
         this._passwordInputTxt.text = this._savedPassword.substr(0,10);
      }
      
      public function dispose() : void
      {
         this.closeEventListener();
         removeChild(this._loginMc);
         this._verifyInputPanel.dispose();
         this._loginMc = null;
         this._loginAgent = null;
         this._verifyInputPanel = null;
         this._accountInputTxt = null;
         this._passwordInputTxt = null;
         this._saveAccountCheckBox = null;
         this._savePasswordCheckBox = null;
         this._telecomLoginBtn = null;
         this._netcomLoginBtn = null;
         this._domain = null;
      }
   }
}
