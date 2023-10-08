package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.StringUtil;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.sendToURL;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import org.taomee.register.util.WeakPasswordUtil;
   
   public class MainRegPanel extends Sprite
   {
      
      private static const REGISTER_URL:String = "http://account-httpd.61.com/index.php";
      
      private static const REGISTER_REAL_URL:String = "http://account-co.61.com/gameRegister/registerReal";
      
      private static const REGISTER_REAL_CODE_URL:String = "http://account-co.61.com/vericode/generate";
      
      public static const GET_CODE:uint = 1101;
      
      public static const REGSITE:uint = 1102;
      
      public static const GAME_ID:uint = 10;
       
      
      private var _regMc:MovieClip;
      
      private var _pwdTxtInput:TextField;
      
      private var _pwdTxtInput2:TextField;
      
      private var _verTxtInput:TextField;
      
      private var _changeVerifyImgBtn:SimpleButton;
      
      private var _applyBtn:SimpleButton;
      
      private var _backBtn:SimpleButton;
      
      private var _captchaComp:Loader;
      
      private var _txt_0:TextField;
      
      private var _txt_1:TextField;
      
      private var _txt_2:TextField;
      
      private var _optionMC_1:MovieClip;
      
      private var _optionMC_2:MovieClip;
      
      private var _checkId:Boolean = true;
      
      private var regLoader:URLLoader;
      
      private var _erroDict:Dictionary;
      
      private var _uid:uint;
      
      private var _isInSeerHtml:Boolean;
      
      public function MainRegPanel()
      {
         var _loc3_:String = null;
         super();
         this._erroDict = new Dictionary();
         this._erroDict[1] = "密码是由6-16个字符组成哦！";
         this._erroDict[2] = "密码不能为空哦！";
         this._erroDict[3] = "两次输入的密码要保持一致哦！";
         this._erroDict[4] = "你输入的密码中含有特殊字符哦！";
         this._erroDict[5] = "密码太简单，请尝试数字，字母和下划线的组合吧！";
         this._erroDict[6] = "请输入2-4个汉字，即可通过验证!";
         this._erroDict[7] = "请输入正确的身份证号!";
         this._erroDict[4001] = "网络错误！";
         this._erroDict[4002] = "缺少命令号！";
         this._erroDict[4003] = "命令号不存在！";
         this._erroDict[4005] = "controller不存在！";
         this._erroDict[4006] = "account不存在！";
         this._erroDict[4007] = "缺少参数！";
         this._erroDict[4008] = "参数错误！";
         this._erroDict[4009] = "非法请求！";
         this._erroDict[4010] = "两次密码不相等！";
         this._erroDict[4011] = "密码不符合规范！";
         this._erroDict[4012] = "验证码不足四位或不全是数字！";
         this._erroDict[4013] = "落入统计项失败！";
         this._erroDict[10006] = "获取米米号失败！";
         this._erroDict[10007] = "添加邮箱映射失败！";
         this._erroDict[10008] = "添加用户信息失败！";
         this._erroDict[10009] = "注册验证码有误！";
         this._erroDict[1009] = "身份证格式不正确!";
         var _loc1_:Date = new Date();
         if(ExternalInterface.available)
         {
            _loc3_ = ExternalInterface.call("window.location.href.toString");
            if(_loc3_.indexOf("61.com") != -1)
            {
               this._isInSeerHtml = true;
            }
            if(_loc3_.indexOf("play") != -1)
            {
               this._isInSeerHtml = false;
            }
         }
         this._checkId = this._isInSeerHtml;
         var _loc2_:uint = 10;
         try
         {
            LoginModule.topLeftTmcid = ExternalInterface.call("getAd");
         }
         catch(e:*)
         {
         }
         this.regLoader = new URLLoader();
         this.regLoader.addEventListener(Event.COMPLETE,this.onRegisterReturn);
         this.regLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onRegisterFail);
         this.initialize();
         this.initEventListeners();
      }
      
      private function initialize() : void
      {
         var _loc1_:ApplicationDomain = LoaderAgent.getDomain("mainPage");
         this._regMc = DomainUtil.getMovieClip("MainRegUI",_loc1_);
         if(this._checkId)
         {
            this._regMc.gotoAndStop(2);
         }
         this._pwdTxtInput = this._regMc["pwdTxtInput"];
         this._pwdTxtInput2 = this._regMc["pwdTxtInput2"];
         this._pwdTxtInput.displayAsPassword = true;
         this._pwdTxtInput2.displayAsPassword = true;
         this._verTxtInput = this._regMc["verTxtInput"];
         this._changeVerifyImgBtn = this._regMc["changeVerifyImgBtn"];
         this._applyBtn = this._regMc["applyBtn"];
         this._backBtn = this._regMc["backBtn"];
         addChild(this._regMc);
         this._txt_0 = this._regMc["txt_0"];
         this._txt_1 = this._regMc["txt_1"];
         this._txt_2 = this._regMc["txt_2"];
         this._optionMC_1 = this._regMc["optionMC_0"];
         this._optionMC_2 = this._regMc["optionMC_1"];
         this._optionMC_1.visible = false;
         this._optionMC_2.visible = false;
         if(this._regMc["idTip"])
         {
            this._regMc["idTip"].visible = false;
            this._regMc["optionMC_3"].visible = false;
         }
         if(this._regMc["nameTip"])
         {
            this._regMc["optionMC_2"].visible = false;
            this._regMc["nameTip"].visible = false;
         }
         this._captchaComp = new Loader();
         this._captchaComp.y = 355;
         this._captchaComp.x = 670;
         if(this._checkId)
         {
            this._captchaComp.scaleX = this._captchaComp.scaleY = 0.65;
            this._captchaComp.y = 375;
            this._captchaComp.x = 670;
         }
         addChild(this._captchaComp);
      }
      
      private function initEventListeners() : void
      {
         this._pwdTxtInput.addEventListener(Event.CHANGE,this.onPwdInput);
         if(this._regMc["nameInput"])
         {
            this._regMc["nameInput"].addEventListener(Event.CHANGE,this.onNameInput);
            this._regMc["nameInput"].addEventListener(FocusEvent.FOCUS_IN,this.onTxtFocusIn);
         }
         if(this._regMc["idInput"])
         {
            this._regMc["idInput"].addEventListener(Event.CHANGE,this.onIdInput);
            this._regMc["idInput"].addEventListener(FocusEvent.FOCUS_IN,this.onTxtFocusIn);
         }
         this._pwdTxtInput2.addEventListener(Event.CHANGE,this.onPwdRepeatInput);
         this._verTxtInput.addEventListener(Event.CHANGE,this.onInputVerCode);
         this._changeVerifyImgBtn.addEventListener(MouseEvent.CLICK,this.onChangeVerifyImg);
         this._applyBtn.addEventListener(MouseEvent.CLICK,this.onApplyMM);
         this._backBtn.addEventListener(MouseEvent.CLICK,this.onBackMM);
      }
      
      private function dispose() : void
      {
         this._captchaComp = null;
         if(this.regLoader)
         {
            this.regLoader.removeEventListener(Event.COMPLETE,this.onRegisterReturn);
            this.regLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onRegisterFail);
            this.regLoader = null;
         }
         if(this._regMc["nameInput"])
         {
            this._regMc["nameInput"].removeEventListener(Event.CHANGE,this.onNameInput);
            this._regMc["nameInput"].removeEventListener(FocusEvent.FOCUS_IN,this.onTxtFocusIn);
         }
         if(this._regMc["idInput"])
         {
            this._regMc["idInput"].removeEventListener(Event.CHANGE,this.onIdInput);
            this._regMc["idInput"].removeEventListener(FocusEvent.FOCUS_IN,this.onTxtFocusIn);
         }
         this._pwdTxtInput.removeEventListener(Event.CHANGE,this.onPwdInput);
         this._pwdTxtInput2.removeEventListener(Event.CHANGE,this.onPwdRepeatInput);
         this._verTxtInput.removeEventListener(Event.CHANGE,this.onInputVerCode);
         this._changeVerifyImgBtn.removeEventListener(MouseEvent.CLICK,this.onChangeVerifyImg);
         this._applyBtn.removeEventListener(MouseEvent.CLICK,this.onApplyMM);
         this._backBtn.removeEventListener(MouseEvent.CLICK,this.onBackMM);
         this._verTxtInput = null;
         this._pwdTxtInput = null;
         this._pwdTxtInput2 = null;
         this._changeVerifyImgBtn = null;
         this._applyBtn = null;
         this._backBtn = null;
         this._regMc = null;
      }
      
      private function onBackMM(param1:MouseEvent) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.REG_BACK_LOGIN));
      }
      
      public function init() : void
      {
         this._pwdTxtInput.text = "";
         this._pwdTxtInput2.text = "";
         this._verTxtInput.text = "";
         this._txt_0.htmlText = "";
         this._txt_1.htmlText = "";
         this._txt_2.htmlText = "";
         this._optionMC_1.visible = false;
         this._optionMC_2.visible = false;
         this._captchaComp.load(this.codeGetUrlRequest);
         sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=game_visit_account&mm=10"));
         if(LoginModule.tmcid > 0)
         {
            sendToURL(new URLRequest("http://misc.taomee.com/seer2/seer2.php?type=channel_visit_account&mm=" + LoginModule.tmcid));
         }
         this.recoverBtn();
      }
      
      private function onChangeVerifyImg(param1:MouseEvent) : void
      {
         this._captchaComp.load(this.codeGetUrlRequest);
      }
      
      private function onApplyMM(param1:MouseEvent) : void
      {
         var _loc6_:URLRequest = null;
         var _loc7_:URLVariables = null;
         var _loc2_:Boolean = false;
         this.onNameInput();
         this.onIdInput();
         _loc2_ = this.checkPassword(this._pwdTxtInput.text) && this.check() && this.checkPwdRepeat() && this.checkVerCode() && this.checkName() && this.checkId();
         if(_loc2_ == false)
         {
            return;
         }
         var _loc3_:String = this._pwdTxtInput.text;
         var _loc4_:String = this._verTxtInput.text;
         var _loc5_:MainRegPanel = this;
         if(!this._checkId)
         {
            (_loc6_ = new URLRequest("http://account-httpd.61.com/")).method = URLRequestMethod.POST;
            (_loc7_ = new URLVariables()).cmd = REGSITE;
            _loc7_.pwd = _loc3_;
            _loc7_.cfmpwd = this._pwdTxtInput2.text;
            _loc7_.seccode = this._verTxtInput.text;
            _loc7_.gid = 2;
         }
         else
         {
            (_loc6_ = new URLRequest(REGISTER_REAL_URL)).method = URLRequestMethod.POST;
            (_loc7_ = new URLVariables()).real_name = this._regMc["nameInput"].text;
            _loc7_.identification = this._regMc["idInput"].text;
            _loc7_.passwd = _loc3_;
            _loc7_.sec_passwd = this._pwdTxtInput2.text;
            _loc7_.vericode = parseInt(this._verTxtInput.text);
            _loc7_.game = GAME_ID;
            _loc7_.ret_type = 2;
         }
         _loc6_.data = _loc7_;
         this.regLoader.load(_loc6_);
         this._applyBtn.mouseEnabled = false;
         this._applyBtn.alpha = 0.4;
      }
      
      private function onRegisterFail(param1:Event) : void
      {
         this._txt_2.text = "请求出错";
         this._verTxtInput.text = "";
         this._captchaComp.load(this.codeGetUrlRequest);
         this.recoverBtn();
      }
      
      private function onRegisterReturn(param1:Event) : void
      {
         var json:Object = null;
         var info:String = null;
         var msgStr:String = null;
         var event:Event = param1;
         try
         {
            json = JSON.parse(event.target.data);
            if(this._checkId)
            {
               if(Boolean(json["data"]) && Boolean(json["data"].uid))
               {
                  this._uid = uint(json["data"].uid);
               }
            }
            else
            {
               this._uid = parseInt(json["userid"]);
            }
         }
         catch(e:Error)
         {
            json = {"result":1001};
         }
         if(json["result"] == 0)
         {
            info = this._uid + "#" + this._pwdTxtInput.text;
            dispatchEvent(new LoginEvent(LoginEvent.REG_SUCCESS_LOGIN,info));
            this.recoverBtn();
            LoginStatistics.newSendNovice("_newtrans_",this._uid.toString(),"fLoadRegSucc","前端成功加载注册成功界面");
            LoginStatistics.newSendNovice("_newtrans_",this._uid.toString(),"fGetRegSucc","前端收到注册米米号成功消息");
         }
         else
         {
            msgStr = String(this._erroDict[uint(json["result"])]);
            this._txt_2.text = json["result"];
            if(msgStr)
            {
               this._txt_2.text = msgStr;
            }
            this._verTxtInput.text = "";
            this._captchaComp.load(this.codeGetUrlRequest);
         }
         this.recoverBtn();
      }
      
      private function recoverBtn() : void
      {
         if(this._applyBtn)
         {
            this._applyBtn.mouseEnabled = true;
            this._applyBtn.alpha = 1;
         }
      }
      
      private function onInputVerCode(param1:Event) : void
      {
         var _loc2_:String = null;
         _loc2_ = this._verTxtInput.text;
         if(_loc2_ == null || _loc2_ == "")
         {
            this._txt_2.text = "请输入验证码";
         }
         else if(_loc2_.length != 4)
         {
            this._txt_2.text = "请输入四位数验证码";
         }
         else
         {
            this._txt_2.text = "";
         }
      }
      
      private function checkVerCode() : Boolean
      {
         if(this._verTxtInput.text == null || this._verTxtInput.text == "")
         {
            this._txt_2.text = "请输入验证码";
            return false;
         }
         return true;
      }
      
      private function check() : Boolean
      {
         if(StringUtil.trim(this._pwdTxtInput.text) == "")
         {
            return false;
         }
         return true;
      }
      
      private function checkPwdRepeat() : Boolean
      {
         if(StringUtil.trim(this._pwdTxtInput2.text) == "")
         {
            return false;
         }
         if(StringUtil.trim(this._pwdTxtInput.text) != StringUtil.trim(this._pwdTxtInput2.text))
         {
            return false;
         }
         return true;
      }
      
      private function checkName() : Boolean
      {
         var _loc1_:RegExp = null;
         var _loc2_:String = null;
         if(this._checkId)
         {
            _loc1_ = /^[一-龥]{2,4}$/;
            _loc2_ = String(this._regMc["nameInput"].text);
            if(!_loc1_.exec(_loc2_))
            {
               return false;
            }
         }
         return true;
      }
      
      private function checkId() : Boolean
      {
         var _loc1_:RegExp = null;
         var _loc2_:String = null;
         if(this._checkId)
         {
            _loc1_ = /(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            _loc2_ = String(this._regMc["idInput"].text);
            return _loc1_.exec(_loc2_) && this.checkIdentification(_loc2_);
         }
         return true;
      }
      
      private function checkIdBirthDay(param1:String) : Boolean
      {
         var _loc2_:int = int(param1.substr(6,4));
         var _loc3_:int = int(param1.substr(10,2));
         var _loc4_:int = int(param1.substr(12,2));
         if(_loc2_ < 1930 || _loc2_ > 2017)
         {
            return false;
         }
         if(_loc3_ > 12 || _loc3_ < 1)
         {
            return false;
         }
         if(_loc4_ > 31 || _loc4_ < 1)
         {
            return false;
         }
         return true;
      }
      
      private function checkPassword(param1:String) : Boolean
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
      }
      
      private function warnTipString(param1:String) : String
      {
         var _loc2_:* = null;
         if(param1 == null || param1 == "")
         {
            _loc2_ = "<font color=\'#FF0000\'>请输入密码</font>";
         }
         else if(StringUtil.trim(param1) == "")
         {
            _loc2_ = "<font color=\'#FF0000\'>密码不能全是空格</font>";
         }
         else if(param1.length < 6)
         {
            _loc2_ = "密码过短,请输入<font color=\'#FF0000\'>" + "6到16个字符" + "</font>的密码";
         }
         else if(WeakPasswordUtil.isContainIllegalChar(param1))
         {
            _loc2_ = "<font color=\'#FF0000\'>你输入的密码中含有特殊字符,请重新输入</font>";
         }
         else if(WeakPasswordUtil.isWeakPassword(param1))
         {
            _loc2_ = "<font color=\'#FF0000\'>密码太简单,请尝试数字,字母和下划线的组合</font>";
         }
         else
         {
            _loc2_ = "";
         }
         return _loc2_;
      }
      
      private function onPwdInput(param1:Event) : void
      {
         this._txt_0.htmlText = this.warnTipString(this._pwdTxtInput.text);
         this._optionMC_1.visible = true;
         if(this._txt_0.htmlText == "")
         {
            this._optionMC_1.gotoAndStop(1);
         }
         else
         {
            this._optionMC_1.gotoAndStop(2);
         }
      }
      
      private function onTxtFocusIn(param1:FocusEvent = null) : void
      {
         if((param1.currentTarget as TextField).textColor != 16777215)
         {
            (param1.currentTarget as TextField).textColor = 16777215;
            (param1.currentTarget as TextField).text = "";
         }
      }
      
      private function onNameInput(param1:Event = null) : void
      {
         if(!this._regMc["nameTip"])
         {
            return;
         }
         this._regMc["optionMC_2"].visible = true;
         if(!this.checkName())
         {
            this._regMc["nameTip"].visible = true;
            this._regMc["optionMC_2"].gotoAndStop(2);
         }
         else
         {
            this._regMc["nameTip"].visible = false;
            this._regMc["optionMC_2"].gotoAndStop(1);
         }
      }
      
      private function onIdInput(param1:Event = null) : void
      {
         if(!this._regMc["idTip"])
         {
            return;
         }
         this._regMc["optionMC_3"].visible = true;
         if(!this.checkId())
         {
            this._regMc["optionMC_3"].gotoAndStop(2);
            this._regMc["idTip"].visible = true;
         }
         else
         {
            this._regMc["optionMC_3"].gotoAndStop(1);
            this._regMc["idTip"].visible = false;
         }
      }
      
      private function onPwdRepeatInput(param1:Event) : void
      {
         this._txt_1.htmlText = this.warnTipString(this._pwdTxtInput2.text);
         if(this._txt_1.htmlText == "")
         {
            if(StringUtil.trim(this._pwdTxtInput.text) != StringUtil.trim(this._pwdTxtInput2.text))
            {
               this._txt_1.text = "两次密码不一致";
            }
            else
            {
               this._txt_1.text = "";
            }
         }
         this._optionMC_2.visible = true;
         if(this._txt_1.text == "")
         {
            this._optionMC_2.gotoAndStop(1);
         }
         else
         {
            this._optionMC_2.gotoAndStop(2);
         }
      }
      
      private function get codeGetUrlRequest() : URLRequest
      {
         var _loc1_:URLRequest = null;
         var _loc2_:URLVariables = null;
         if(!this._checkId)
         {
            _loc2_ = new URLVariables();
            _loc2_.cmd = GET_CODE;
            _loc2_.type = 0;
            _loc2_.rnd = Math.random();
            _loc1_ = new URLRequest("http://account-httpd.61.com/");
            _loc1_.method = URLRequestMethod.GET;
         }
         else
         {
            _loc2_ = new URLVariables();
            _loc2_.game = GAME_ID;
            _loc2_.s = int(Math.random() * 1000000);
            _loc1_ = new URLRequest(REGISTER_REAL_CODE_URL);
            _loc1_.method = URLRequestMethod.POST;
         }
         _loc1_.data = _loc2_;
         return _loc1_;
      }
      
      public function checkIdentification(param1:String) : Boolean
      {
         var _loc2_:int = new Date().fullYear;
         if(_loc2_ <= 2017)
         {
            _loc2_ = 2017;
         }
         var _loc3_:int = int(param1.substr(16,1)) % 2 == 0 ? 0 : 2;
         var _loc4_:int = int(param1.substr(6,4));
         var _loc5_:int = int(param1.substr(10,2));
         var _loc6_:int = int(param1.substr(12,2));
         if(_loc4_ > _loc2_ || _loc4_ < 1900)
         {
            return false;
         }
         if(_loc5_ > 12 || _loc5_ < 1)
         {
            return false;
         }
         if(_loc6_ > 31 || _loc6_ < 1)
         {
            return false;
         }
         var _loc7_:Array = [7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1];
         var _loc8_:Array = ["1","0","X","9","8","7","6","5","4","3","2"];
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         while(_loc10_ < 17)
         {
            _loc9_ += parseInt(param1.charAt(_loc10_)) * _loc7_[_loc10_];
            _loc10_++;
         }
         var _loc11_:String = String(_loc8_[_loc9_ % 11]);
         if(param1.charAt(17).toLocaleLowerCase() != _loc11_.toLocaleLowerCase())
         {
            return false;
         }
         return true;
      }
   }
}
