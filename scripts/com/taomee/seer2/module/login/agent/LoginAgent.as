package com.taomee.seer2.module.login.agent
{
   import com.taomee.seer2.module.login.config.LoginConfig;
   import com.taomee.seer2.module.login.data.ConfirmActiveCodeInfo;
   import com.taomee.seer2.module.login.data.MainServerLoginInfo;
   import com.taomee.seer2.module.login.data.OnlineServerListInfo;
   import com.taomee.seer2.module.login.data.ServerInfo;
   import com.taomee.seer2.module.login.data.VerifyCodeInfo;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.net.Connection;
   import com.taomee.seer2.module.login.net.LittleEndianByteArray;
   import com.taomee.seer2.module.login.net.MessageEvent;
   import com.taomee.seer2.module.login.util.ErrorCodeMap;
   import com.taomee.seer2.module.login.util.InputCheckUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class LoginAgent extends EventDispatcher
   {
      
      public static const CHANNEL:uint = 65;
      
      private static const TEL_ID:String = "123";
      
      public static var isNewPlayer:int;
       
      
      public var isSidLogin:Boolean;
      
      private var _mainServerLoginInfo:MainServerLoginInfo;
      
      private var _serverListInfo:OnlineServerListInfo;
      
      private var _activeCodeInfo:ConfirmActiveCodeInfo;
      
      private var _verifyCodeInfo:VerifyCodeInfo;
      
      private var _loginServerInfo:ServerInfo;
      
      private var _ip:String;
      
      private var _port:int;
      
      private var _isTimeout:Boolean = false;
      
      private var _isNeedVerify:Boolean = false;
      
      private var _account:String;
      
      private var _password:String;
      
      private var _connectSuccessHandler:Function;
      
      private var _getServerListHandler:Function;
      
      private var _registerNickName:String;
      
      private var _registerColorIndex:uint;
      
      private var _registerSex:uint;
      
      private var _isActived:uint;
      
      private var _sidSession:String;
      
      private var _serverTotalCount:uint;
      
      private var _telIpStr:String;
      
      private var _cncIpStr:String;
      
      private var _ipLoader:URLLoader;
      
      private var _isTel:Boolean;
      
      public var isLoadIpConfig:Boolean;
      
      private var _loginType:uint = 0;
      
      private var _startServerId:uint;
      
      private var _endServerId:uint;
      
      public function LoginAgent()
      {
         super();
         this.isLoadIpConfig = false;
         this.loadIpConfig();
         this.addConnectionErrorListener();
         this.addConnectionEventListener();
      }
      
      public function get isTel() : Boolean
      {
         return this._isTel;
      }
      
      private function loadIpConfig() : void
      {
         this._ipLoader = new URLLoader();
         this._ipLoader.addEventListener(Event.COMPLETE,this.onComLoaded);
         this._ipLoader.load(new URLRequest(this.getRandomVersionURL(LoginConfig.comURL)));
      }
      
      private function onComLoaded(param1:Event) : void
      {
         this.isLoadIpConfig = true;
         this._ipLoader.removeEventListener(Event.COMPLETE,this.onComLoaded);
         var _loc2_:String = String(param1.target.data);
         this._isTel = _loc2_.substring(0,3) == TEL_ID;
         this.parseIpConfig(_loc2_,true);
         dispatchEvent(new LoginEvent(LoginEvent.LOAD_IP_CONFIG_COMPLETE));
      }
      
      private function onCncLoaded_1(param1:Event) : void
      {
         this._ipLoader.removeEventListener(Event.COMPLETE,this.onCncLoaded_1);
         this._cncIpStr = param1.target.data;
         this._ipLoader.addEventListener(Event.COMPLETE,this.onTelLoaded_1);
         this._ipLoader.load(new URLRequest(this.getRandomVersionURL(LoginConfig.telURL)));
      }
      
      private function onTelLoaded_1(param1:Event) : void
      {
         this._ipLoader.removeEventListener(Event.COMPLETE,this.onTelLoaded_1);
         this._telIpStr = param1.target.data;
         dispatchEvent(new LoginEvent(LoginEvent.LOAD_IP_CONFIG_COMPLETE));
      }
      
      private function parseIpConfig(param1:String, param2:Boolean) : void
      {
         this._ip = param1.split(":")[0];
         this._port = parseInt(param1.split(":")[1]);
      }
      
      private function addConnectionErrorListener() : void
      {
         Connection.addErrorHandler(103,this.onLoginError);
         Connection.addErrorHandler(101,this.onGetVerifyCodeError);
         Connection.addErrorHandler(104,this.onConfirmActiveError);
      }
      
      private function removeConnectionErrorListener() : void
      {
         Connection.removeErrorHandler(103,this.onLoginError);
         Connection.removeErrorHandler(101,this.onGetVerifyCodeError);
         Connection.removeErrorHandler(104,this.onConfirmActiveError);
      }
      
      private function addConnectionEventListener() : void
      {
         Connection.addEventListener(Event.CONNECT,this.onServerConnect);
         Connection.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         Connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         Connection.addEventListener(Event.CLOSE,this.onSocketClose);
      }
      
      private function removeConnectionEventListener() : void
      {
         Connection.removeEventListener(Event.CONNECT,this.onServerConnect);
         Connection.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         Connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         Connection.removeEventListener(Event.CLOSE,this.onSocketClose);
      }
      
      private function connectServer(param1:String, param2:int, param3:Function) : void
      {
         this._connectSuccessHandler = param3;
         Connection.connect(param1,param2);
      }
      
      private function onServerConnect(param1:Event) : void
      {
         if(this._connectSuccessHandler != null)
         {
            this._connectSuccessHandler();
            this._connectSuccessHandler = null;
         }
      }
      
      public function telLogin(param1:String, param2:String) : void
      {
         this._account = param1;
         this._password = param2;
         if(this._telIpStr == null || this._telIpStr == "")
         {
            this._ipLoader.addEventListener(Event.COMPLETE,this.onTelLoaded);
            this._ipLoader.load(new URLRequest(this.getRandomVersionURL(LoginConfig.telURL)));
         }
         else
         {
            this.enterTel();
         }
      }
      
      private function onTelLoaded(param1:Event) : void
      {
         this._ipLoader.removeEventListener(Event.COMPLETE,this.onTelLoaded);
         this._telIpStr = param1.target.data;
         this.enterTel();
      }
      
      private function enterTel() : void
      {
         this.parseIpConfig(this._telIpStr,true);
         this.connectServer(this._ip,this._port,this.checkLoginMethod);
         Connection.netType = Connection.TEL;
         LoginStatistics.sendAccountNovice(LoginStatistics.clickTelBtn,"0");
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_10,"0");
      }
      
      public function cncLogin(param1:String, param2:String) : void
      {
         this._account = param1;
         this._password = param2;
         if(this._cncIpStr == null || this._cncIpStr == "")
         {
            this._ipLoader.addEventListener(Event.COMPLETE,this.onCncLoaded);
            this._ipLoader.load(new URLRequest(this.getRandomVersionURL(LoginConfig.cncURL)));
         }
         else
         {
            this.enterCnc();
         }
      }
      
      private function onCncLoaded(param1:Event) : void
      {
         this._ipLoader.removeEventListener(Event.COMPLETE,this.onCncLoaded);
         this._cncIpStr = param1.target.data;
         this.enterCnc();
      }
      
      private function enterCnc() : void
      {
         this.parseIpConfig(this._cncIpStr,false);
         this.connectServer(this._ip,this._port,this.checkLoginMethod);
         Connection.netType = Connection.CNC;
         LoginStatistics.sendAccountNovice(LoginStatistics.clickCnsBtn,"0");
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_12,"0");
      }
      
      public function getVerifyCode() : void
      {
         this.connectServer(this._ip,this._port,this.requestVerifyCode);
      }
      
      private function requestVerifyCode() : void
      {
         Connection.addCommandListener(101,this.onReceiveVerifyCode);
         Connection.send(101);
      }
      
      private function onReceiveVerifyCode(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(101,this.onReceiveVerifyCode);
         this._verifyCodeInfo = new VerifyCodeInfo(param1.message.getRawDataCopy());
         if(this._verifyCodeInfo.isNeedVerify)
         {
            dispatchEvent(new LoginEvent(LoginEvent.GET_VERIFY_CODE));
         }
         else
         {
            dispatchEvent(new LoginEvent(LoginEvent.NO_VERITY_CODE));
         }
         this.close();
      }
      
      private function onGetVerifyCodeError(param1:MessageEvent) : void
      {
         this.close();
      }
      
      private function checkLoginMethod() : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.LOAD_CNC_TEL_COMPLETE));
         if(this.isSidLogin == true)
         {
            this.checkCreatedRole();
            return;
         }
         if(InputCheckUtil.isDigital(this._account))
         {
            this.digitalAccountLogin();
         }
         else
         {
            this.mailAccountLogin();
         }
      }
      
      private function checkCreatedRole() : void
      {
         this._mainServerLoginInfo = new MainServerLoginInfo(null);
         this._mainServerLoginInfo.resultFlag = 0;
         this._mainServerLoginInfo.session = this.convertSessionStrToByteArray(this._sidSession);
         this._mainServerLoginInfo.account = this._account;
         this._mainServerLoginInfo.password = this._password;
         Connection.setUserId(int(this._account));
         this.checkHasRole(this._mainServerLoginInfo.session);
      }
      
      private function convertSessionStrToByteArray(param1:String) : LittleEndianByteArray
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.substr(_loc4_,2);
            _loc6_ = parseInt(_loc5_,16);
            _loc2_.writeByte(_loc6_);
            _loc4_ += 2;
         }
         return _loc2_;
      }
      
      private function digitalAccountLogin() : void
      {
         var _loc1_:int = parseInt(this._account);
         Connection.setUserId(_loc1_);
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUTFBytes(this._password);
         _loc2_.length = 32;
         Connection.addCommandListener(103,this.onLoginCommandResponse);
         Connection.send(103,_loc2_,this.getReviseTmcid(),LoginConfig.productID,0,this.verifyCodeInfo.getVerifyImgIdData(),this.verifyCodeInfo.getVerifyCodeData(),this.getTopLeftTmcid());
         this._loginType = 1;
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_1,this._account);
      }
      
      private function mailAccountLogin() : void
      {
         Connection.setUserId(0);
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeUTFBytes(this._account);
         _loc1_.length = 64;
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc2_.writeUTFBytes(this._password);
         _loc2_.length = 32;
         Connection.addCommandListener(103,this.onLoginCommandResponse);
         Connection.send(103,_loc1_,_loc2_,this.getReviseTmcid(),LoginConfig.productID,0,this.verifyCodeInfo.getVerifyImgIdData(),this.verifyCodeInfo.getVerifyCodeData(),this.getTopLeftTmcid());
         this._loginType = 2;
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_2,this._account);
      }
      
      private function getReviseTmcid() : int
      {
         if(LoginModule.tmcid > 0)
         {
            return LoginModule.tmcid;
         }
         return CHANNEL;
      }
      
      private function getTopLeftTmcid() : LittleEndianByteArray
      {
         var _loc2_:String = null;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         if(LoginModule.topLeftTmcid != null && LoginModule.topLeftTmcid != "none" && LoginModule.topLeftTmcid != "")
         {
            _loc1_.writeUTFBytes(LoginModule.topLeftTmcid);
         }
         else
         {
            _loc1_.writeUTFBytes("0");
         }
         _loc1_.length = 64;
         return _loc1_;
      }
      
      private function onLoginCommandResponse(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(103,this.onLoginCommandResponse);
         this._mainServerLoginInfo = new MainServerLoginInfo(param1.message.getRawData());
         if(this._mainServerLoginInfo.resultFlag > 0 && this._mainServerLoginInfo.resultFlag < 6)
         {
            this.verifyCodeInfo.setVerifyImgIdData(this._mainServerLoginInfo.verifyImgId);
            this.verifyCodeInfo.setVerifyImgData(this._mainServerLoginInfo.verifyImgData);
            this.verifyCodeInfo.isNeedVerify = true;
            dispatchEvent(new LoginEvent(LoginEvent.LOGIN_FAIL));
            dispatchEvent(new LoginEvent(LoginEvent.GET_VERIFY_CODE));
            this.close();
            if(Connection.netType == Connection.TEL)
            {
               LoginStatistics.sendAccountNovice(LoginStatistics.Tel_Pwd_Error,param1.message.uid.toString());
            }
            else if(Connection.netType == Connection.CNC)
            {
               LoginStatistics.sendAccountNovice(LoginStatistics.Cnc_Pwd_Error,param1.message.uid.toString());
            }
         }
         else
         {
            this._mainServerLoginInfo.account = param1.message.uid.toString();
            this._mainServerLoginInfo.password = this._password;
            Connection.setUserId(param1.message.uid);
            this.checkHasRole(this._mainServerLoginInfo.session);
         }
         if(this._loginType == 1)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_3,this._account);
         }
         else if(this._loginType == 2)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_4,this._account);
         }
         LoginStatistics.newSendNovice("_newtrans_",this._account,"fGetLoginSucc","前端收到验证密码成功");
      }
      
      private function checkHasRole(param1:LittleEndianByteArray) : void
      {
         Connection.addCommandListener(111,this.onCheckHasRole);
         Connection.send(111,param1);
      }
      
      private function onCheckHasRole(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(111,this.onCheckHasRole);
         var _loc2_:LittleEndianByteArray = param1.message.getRawData();
         var _loc3_:* = _loc2_.readUnsignedInt() == 1;
         this._mainServerLoginInfo.hasRole = _loc3_;
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_SUCCESS));
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_6,this._account);
      }
      
      public function getPromotedServerList() : void
      {
         this.requestServerList();
      }
      
      private function requestServerList() : void
      {
         Connection.addErrorHandler(105,this.onGetServerListError);
         Connection.addCommandListener(105,this.onGetServerList);
         Connection.send(105,this._mainServerLoginInfo.session,this.getReviseTmcid());
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_7,this._account);
      }
      
      private function onGetServerList(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(105,this.onGetServerListError);
         Connection.removeCommandListener(105,this.onGetServerList);
         this._serverTotalCount = param1.message.getRawData().readUnsignedInt();
         this._serverListInfo = new OnlineServerListInfo(param1.message.getRawData());
         isNewPlayer = this._serverListInfo.isNewPlayer;
         this.close();
         dispatchEvent(new LoginEvent(LoginEvent.GET_SERVER_LIST));
         LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_8,this._account);
      }
      
      private function onGetServerListError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(105,this.onGetServerListError);
         Connection.removeCommandListener(105,this.onGetServerList);
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_ERROR,ErrorCodeMap.getInfoByCode(param1.message.statusCode)));
      }
      
      public function createRole(param1:String, param2:uint, param3:uint) : void
      {
         this._registerNickName = param1;
         this._registerColorIndex = param2;
         this._registerSex = param3;
         this.connectServer(this._ip,this._port,this.requestCreateRole);
      }
      
      private function requestCreateRole() : void
      {
         Connection.addCommandListener(107,this.onCreateRoleSuccess);
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeUTFBytes(this._registerNickName);
         _loc1_.length = 16;
         Connection.send(107,this._mainServerLoginInfo.session,this.getReviseTmcid(),_loc1_,this._registerColorIndex,LittleEndianByteArray.writeIntergerAsUnsignedByte(this._registerSex),this.getTopLeftTmcid());
         LoginStatistics.newSendNovice("新手",this._account,"点击注册");
      }
      
      private function onCreateRoleSuccess(param1:MessageEvent) : void
      {
         this.close();
         Connection.removeCommandListener(107,this.onCreateRoleSuccess);
         dispatchEvent(new LoginEvent(LoginEvent.CREATE_ROLE_SUCCESS));
         LoginStatistics.newSendNovice("新手",this._account,"注册成功");
      }
      
      public function getRangedServerList(param1:uint, param2:uint, param3:Function) : void
      {
         this._startServerId = param1;
         this._endServerId = param2;
         this._getServerListHandler = param3;
         this.connectServer(this._ip,this._port,this.requestRangedServerList);
      }
      
      public function requestRangedServerList() : void
      {
         Connection.addCommandListener(106,this.onGetRangedServerList);
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeShort(this._startServerId);
         _loc1_.writeShort(this._endServerId);
         Connection.send(106,_loc1_);
      }
      
      private function onGetRangedServerList(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(106,this.onGetRangedServerList);
         this._serverListInfo = new OnlineServerListInfo(param1.message.getRawDataCopy());
         this.close();
         if(this._getServerListHandler != null)
         {
            this._getServerListHandler();
            this._getServerListHandler = null;
         }
      }
      
      public function reconnectServer(param1:Function) : void
      {
         this.connectServer(this._ip,this._port,param1);
      }
      
      public function close() : void
      {
         Connection.close();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         LoginStatistics.sendError(LoginStatistics.loginFailed);
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_ERROR,"\n服务器没有开启"));
      }
      
      private function onSocketClose(param1:Event) : void
      {
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_ERROR,"\n连接已关闭"));
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         LoginStatistics.sendError(LoginStatistics.loginSandbox);
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_ERROR,"此次连接错误，请稍后重试"));
      }
      
      private function onLoginError(param1:MessageEvent) : void
      {
         if(Connection.netType == Connection.TEL)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.Tel_Net_Fail,param1.message.uid.toString());
         }
         else if(Connection.netType == Connection.CNC)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.Cnc_Net_Fail,param1.message.uid.toString());
         }
         this.close();
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_ERROR,ErrorCodeMap.getInfoByCode(param1.message.statusCode)));
      }
      
      private function onConfirmActiveError(param1:MessageEvent) : void
      {
         this.close();
         dispatchEvent(new LoginEvent(LoginEvent.ACTIVECODE_FAIL,param1.message.statusCode.toString()));
      }
      
      public function setAccountAndSession(param1:String, param2:String) : void
      {
         this._account = param1;
         this._sidSession = param2;
         this.isSidLogin = true;
      }
      
      public function get verifyCodeInfo() : VerifyCodeInfo
      {
         if(this._verifyCodeInfo == null)
         {
            this._verifyCodeInfo = new VerifyCodeInfo(null);
         }
         return this._verifyCodeInfo;
      }
      
      public function set loginServerInfo(param1:ServerInfo) : void
      {
         this._loginServerInfo = param1;
      }
      
      public function get loginServerInfo() : ServerInfo
      {
         return this._loginServerInfo;
      }
      
      public function get mainServerLoginInfo() : MainServerLoginInfo
      {
         return this._mainServerLoginInfo;
      }
      
      public function get serverListInfo() : OnlineServerListInfo
      {
         return this._serverListInfo;
      }
      
      public function get isActived() : Boolean
      {
         return this._isActived == 1;
      }
      
      public function get serverTotalCount() : uint
      {
         return this._serverTotalCount;
      }
      
      public function dispose() : void
      {
         this.removeConnectionErrorListener();
         this.removeConnectionEventListener();
         this._mainServerLoginInfo = null;
         this._serverListInfo = null;
         this._verifyCodeInfo = null;
         this._connectSuccessHandler = null;
         this._getServerListHandler = null;
         this._ipLoader = null;
      }
      
      private function getRandomVersionURL(param1:String) : String
      {
         return param1 + "?v=" + Math.random().toString();
      }
   }
}
