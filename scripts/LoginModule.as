package
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.module.login.agent.CookieAgent;
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.agent.SoundAgent;
   import com.taomee.seer2.module.login.config.ItemConfig;
   import com.taomee.seer2.module.login.config.LoginConfig;
   import com.taomee.seer2.module.login.data.ServerInfo;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.loader.LoaderPool;
   import com.taomee.seer2.module.login.net.Connection;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.VersionManager;
   import com.taomee.seer2.module.login.view.AlarmPanel;
   import com.taomee.seer2.module.login.view.CreateRolePanel;
   import com.taomee.seer2.module.login.view.FirstPagePanel;
   import com.taomee.seer2.module.login.view.IntroAnimationPanel;
   import com.taomee.seer2.module.login.view.MainLoginPanel;
   import com.taomee.seer2.module.login.view.MainRegLoginPanel;
   import com.taomee.seer2.module.login.view.MainRegPanel;
   import com.taomee.seer2.module.login.view.MoreUserLoginPanel;
   import com.taomee.seer2.module.login.view.SelectServerPanel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.system.ApplicationDomain;
   import org.taomee.stat.StatisticsManager;
   
   public class LoginModule extends Sprite
   {
      
      public static const TMCID_FROM_360:int = 76;
      
      public static var tmcid:int;
      
      public static var topLeftTmcid:String = "";
      
      public static var userId:String;
       
      
      public var success:Function;
      
      public var sessionId:String;
      
      public var fromGameId:int = 10;
      
      public var otherServerType:int;
      
      private var _background:MovieClip;
      
      private var _firstPage:FirstPagePanel;
      
      private var _moreUserPage:MoreUserLoginPanel;
      
      private var _loginPanel:MainLoginPanel;
      
      private var _loginAgent:LoginAgent;
      
      private var _serverListPanel:SelectServerPanel;
      
      private var _createRolePanel:CreateRolePanel;
      
      private var _introAnimation:IntroAnimationPanel;
      
      private var _registerPanel:MainRegPanel;
      
      private var _registerLoginPanel:MainRegLoginPanel;
      
      private var _rootUrl:String;
      
      private var _content:Sprite;
      
      private var _justHasRole:Boolean = false;
      
      private var _isAutoAcc:Boolean = false;
      
      public function LoginModule()
      {
         super();
      }
      
      public static function getLoginSharedObject() : SharedObject
      {
         return SharedObject.getLocal(LoginConfig.productName + "/common/login","/");
      }
      
      public function setXmlInfo(param1:XML) : void
      {
         LoginConfig.setXML(param1);
      }
      
      public function setVersionObj(param1:Object) : void
      {
         VersionManager.setup(param1);
      }
      
      public function init(param1:String) : void
      {
         this._rootUrl = param1;
         this._content = new Sprite();
         this.getJS();
         if(tmcid == 0)
         {
            this.getTmcidFromLoaderInfo();
         }
         this.getParamsFromJs();
         CookieAgent.init(param1,this.callBack);
         StatisticsManager.setup(10);
         addChild(this._content);
      }
      
      private function callBack() : void
      {
         LoaderAgent.setup(this._rootUrl);
         this.showFirstPageView();
         LoginStatistics.sendAccountNovice(LoginStatistics.EnterGame,"0");
      }
      
      private function getJS() : void
      {
         var _loc1_:String = null;
         if(ExternalInterface.available)
         {
            _loc1_ = ExternalInterface.call("getHostname");
            if(_loc1_ != "" && _loc1_ != null)
            {
               tmcid = TmdType.getID(_loc1_.toLocaleLowerCase());
            }
         }
      }
      
      private function getTmcidFromLoaderInfo() : void
      {
         var _loc1_:Object = loaderInfo.parameters;
         if(_loc1_.hasOwnProperty("tmcid"))
         {
            tmcid = _loc1_["tmcid"];
         }
      }
      
      private function getParamsFromJs() : void
      {
         var _loc1_:Object = null;
         if(ExternalInterface.available)
         {
            _loc1_ = ExternalInterface.call("getUrlParams");
            if(_loc1_)
            {
               if(tmcid == 0)
               {
                  tmcid = _loc1_["tmcid"];
               }
               userId = _loc1_["uid"];
               this.sessionId = _loc1_["sid"];
               this.fromGameId = _loc1_["fromGameId"];
               this.fromGameId = this.fromGameId == 0 ? 10 : this.fromGameId;
               this.otherServerType = _loc1_["serviceType"];
            }
         }
      }
      
      private function createBackground() : void
      {
         LoaderAgent.addEventListener("backGround",this.onLoadBackGround);
         LoaderAgent.loadDomain("backGround");
      }
      
      private function onLoadBackGround(param1:Event) : void
      {
         LoaderAgent.removeEventListner("backGround",this.onLoadBackGround);
         var _loc2_:ApplicationDomain = LoaderAgent.getDomain("backGround");
         this.addBackGround(_loc2_);
      }
      
      private function addBackGround(param1:ApplicationDomain) : void
      {
         this._background = DomainUtil.getMovieClip("BackGroundUI",param1);
         this._content.addChildAt(this._background,0);
      }
      
      private function hideBackground() : void
      {
         this._content.removeChild(this._background);
      }
      
      private function showFirstPageView() : void
      {
         this._firstPage = new FirstPagePanel();
         this._firstPage.addEventListener(LoginEvent.LOGIN_START,this.onLoginStart);
         addChild(this._firstPage);
      }
      
      private function disposeFirstPagePanel() : void
      {
         if(this._firstPage)
         {
            this._firstPage.removeEventListener(LoginEvent.LOGIN_START,this.onLoginStart);
            removeChild(this._firstPage);
            this._firstPage.dispose();
            this._firstPage = null;
         }
      }
      
      private function onLoginStart(param1:LoginEvent) : void
      {
         this.createBackground();
         if(this._firstPage.isAutoRegister())
         {
            this._isAutoAcc = true;
         }
         this.disposeFirstPagePanel();
         this.createLoginAgent();
         this.loginStart();
      }
      
      private function createLoginAgent() : void
      {
         if(!this._loginAgent)
         {
            this._loginAgent = new LoginAgent();
            this.addLoginErrorListener();
         }
      }
      
      public function layOut(param1:Stage) : void
      {
         if(this._firstPage)
         {
            this._firstPage.layOut(param1);
         }
         if(this._content)
         {
            this._content.scaleX = param1.stageWidth / 1200;
            this._content.scaleY = param1.stageHeight / 660;
         }
      }
      
      public function loginStart() : void
      {
         if(this.sessionId == null)
         {
            if(ExternalInterface.available)
            {
               this.sessionId = ExternalInterface.call("getSessionID");
            }
         }
         if(this.sessionId != null)
         {
            this.showMainLoginView(function():void
            {
               showAccount(sessionId);
            });
            this._loginPanel.showActorPreview();
         }
         else if(CookieAgent.cookieLen == 0 || this._isAutoAcc)
         {
            this.showMainLoginView();
            this._loginPanel.showActorPreview();
            LoaderAgent.cancel("moreUserLogin");
            if(this._isAutoAcc)
            {
               this.onApplyMimi(null);
            }
         }
         else
         {
            this.showMoreUserLoginPanel();
         }
      }
      
      private function showAccount(param1:String) : void
      {
         var sidAccount:String = null;
         var sidSession:String = null;
         var sidStr:String = param1;
         sidAccount = parseInt(sidStr.substring(0,8),16).toString();
         sidSession = sidStr.substring(8,40);
         if(sidAccount != null && sidSession != null)
         {
            if(this._loginPanel == null)
            {
               TweenNano.delayedCall(0.2,function():void
               {
                  _loginPanel.setAccountPassword(sidAccount,"142857");
                  _loginAgent.setAccountAndSession(sidAccount,sidSession);
               });
            }
         }
      }
      
      private function showMoreUserLoginPanel() : void
      {
         if(!this._moreUserPage)
         {
            this._moreUserPage = new MoreUserLoginPanel();
            this._moreUserPage.addEventListener(LoginEvent.ONE_USER_LOGIN,this.onOneUserLogin);
         }
         this._content.addChild(this._moreUserPage);
         this._moreUserPage.x = 115;
         this._moreUserPage.y = 50;
      }
      
      private function hideMoreUserPanel() : void
      {
         if(Boolean(this._moreUserPage) && Boolean(this._moreUserPage.parent))
         {
            this._content.removeChild(this._moreUserPage);
         }
      }
      
      private function disposeMoreUserPanel() : void
      {
         if(this._moreUserPage)
         {
            this._moreUserPage.removeEventListener(LoginEvent.ONE_USER_LOGIN,this.onOneUserLogin);
            this.hideMoreUserPanel();
            this._moreUserPage.dispose();
            this._moreUserPage = null;
         }
      }
      
      private function onOneUserLogin(param1:LoginEvent) : void
      {
         this.hideMoreUserPanel();
         this.showMainLoginView();
         if(param1.info != null)
         {
            if(Boolean(param1.info.loginAccount) && param1.info.loginAccount != "")
            {
               this._loginPanel.setAccountPassword(param1.info.loginAccount,param1.info.password);
            }
            else
            {
               this._loginPanel.setAccountPassword(param1.info.account,param1.info.password);
            }
         }
         this._loginPanel.showActorPreview();
      }
      
      private function showMainLoginView(param1:Function = null) : void
      {
         LoginStatistics.sendAccountNovice(LoginStatistics.mainPage,"0");
         if(!this._loginPanel)
         {
            this._loginAgent.addEventListener(LoginEvent.LOGIN_SUCCESS,this.onLoginSuccess);
            this._loginPanel = new MainLoginPanel(this._loginAgent,true,param1);
            this._loginPanel.addEventListener(LoginEvent.OTHER_USER_LOGIN,this.onOtherUserLogin);
            this._loginPanel.addEventListener(LoginEvent.APPLY_MIMI,this.onApplyMimi);
         }
         this._content.addChild(this._loginPanel);
      }
      
      private function hideMainLoginView() : void
      {
         if(Boolean(this._loginPanel) && Boolean(this._loginPanel.parent))
         {
            this._content.removeChild(this._loginPanel);
         }
      }
      
      private function onOtherUserLogin(param1:LoginEvent) : void
      {
         this.hideMainLoginView();
         this.showMoreUserLoginPanel();
      }
      
      private function onLoginSuccess(param1:LoginEvent) : void
      {
         if(Connection.netType == Connection.TEL)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.telSuccess,"0");
            LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_9,"0");
         }
         else if(Connection.netType == Connection.CNC)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.cncSuccess,"0");
            LoginStatistics.sendAccountNovice(LoginStatistics.STATISTICS_11,"0");
         }
         this.disposeMoreUserPanel();
         this._loginAgent.removeEventListener(LoginEvent.LOGIN_SUCCESS,this.onLoginSuccess);
         if(this._loginPanel.parent != null)
         {
            this._loginPanel.saveAccountAndPassword();
         }
         else if(this._registerLoginPanel.parent != null)
         {
            this._registerLoginPanel.saveAccountAndPassword();
         }
         this.hideMainLoginView();
         this.hideRegisterLoginPanel();
         this.showServerListPanel();
      }
      
      private function showServerListPanel() : void
      {
         this.hideBackground();
         if(!this._loginAgent.mainServerLoginInfo.hasRole)
         {
            LoginStatistics.sendNovice(LoginStatistics.selectServerGrabSuccess,this._loginAgent.mainServerLoginInfo.account);
            LoginStatistics.sendAccountNovice(LoginStatistics.openServerPage_New,this._loginAgent.mainServerLoginInfo.account);
         }
         else
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.openServerPage_Old,this._loginAgent.mainServerLoginInfo.account);
         }
         this._loginAgent.addEventListener(LoginEvent.GET_SERVER_LIST,this.onGetRecommendedServerList);
         this._loginAgent.getPromotedServerList();
         LoginStatistics.newSendNovice("_newtrans_",this._loginAgent.mainServerLoginInfo.account,"fStartSrvlistReq","前端开始拉取服务器列表");
      }
      
      private function onGetRecommendedServerList(param1:LoginEvent) : void
      {
         this._loginAgent.removeEventListener(LoginEvent.GET_SERVER_LIST,this.onGetRecommendedServerList);
         LoginStatistics.newSendNovice("_newtrans_",this._loginAgent.mainServerLoginInfo.account,"fGetSrvlistSucc","前端成功收到服务器列表");
         this._serverListPanel = new SelectServerPanel(this._loginAgent);
         this._loginAgent.addEventListener(LoginEvent.ONLINE_SERVER_SELECTED,this.onOnlineServerSelected);
         this._content.addChild(this._serverListPanel);
      }
      
      public function selectServer(param1:int = 0) : void
      {
         if(this._loginAgent.serverListInfo.serverInfoVector[param1].userCount < 5)
         {
            this._loginAgent.loginServerInfo = this._loginAgent.serverListInfo.serverInfoVector[param1];
            LoginStatistics.newSendNovice("_newtrans_",this._loginAgent.mainServerLoginInfo.account,"fSendOnlineReq","前端点击执行进入online服务器");
            LoginStatistics.newSendNovice("新手引导tyler版",this._loginAgent.mainServerLoginInfo.account,"2014上半年版新手引导tyler版","选择的online服务器编号" + this._loginAgent.loginServerInfo.serverId);
            this.entryStartGame();
         }
         else
         {
            this.selectServer(param1 + 1);
         }
      }
      
      private function onOnlineServerSelected(param1:LoginEvent) : void
      {
         if(!this._loginAgent.mainServerLoginInfo.hasRole)
         {
            LoginStatistics.sendNovice(LoginStatistics.selectServerLogin,this._loginAgent.mainServerLoginInfo.account);
            LoginStatistics.sendAccountNovice(LoginStatistics.selectServerSuc_New,this._loginAgent.mainServerLoginInfo.account);
         }
         else
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.selectServerSuc_Old,this._loginAgent.mainServerLoginInfo.account);
         }
         this._loginAgent.removeEventListener(LoginEvent.ONLINE_SERVER_SELECTED,this.onOnlineServerSelected);
         this._content.removeChild(this._serverListPanel);
         this.entryStartGame();
      }
      
      private function entryStartGame() : void
      {
         if(!this._loginAgent.mainServerLoginInfo.hasRole)
         {
            this.showCreateRoleView();
         }
         else
         {
            this.enterGame();
            LoaderAgent.cancel("intro");
            LoaderAgent.cancel("createRole");
         }
      }
      
      private function showIntroAnimationPanel() : void
      {
         LoginStatistics.sendAccountNovice("0x1003467C",this._loginAgent.mainServerLoginInfo.account);
         this._introAnimation = new IntroAnimationPanel(this._loginAgent.mainServerLoginInfo.account);
         this._introAnimation.addEventListener(IntroAnimationPanel.EVT_END,this.onIntroEnd);
         this._content.addChild(this._introAnimation);
      }
      
      private function onIntroEnd(param1:Event) : void
      {
         SoundAgent.play();
         this._content.removeChild(this._introAnimation);
         LoginStatistics.sendNovice(LoginStatistics.introFinish,this._loginAgent.mainServerLoginInfo.account);
         LoginStatistics.newSendNovice("新手引导",this._loginAgent.mainServerLoginInfo.account,"新手引导","进入主场景");
         this._introAnimation = null;
         this.enterGame();
      }
      
      private function showCreateRoleView() : void
      {
         this._content.addChildAt(this._background,0);
         this._loginAgent.addEventListener(LoginEvent.CREATE_ROLE_SUCCESS,this.onCreateRoleSuccess);
         this._createRolePanel = new CreateRolePanel(this._loginAgent);
         this._content.addChild(this._createRolePanel);
      }
      
      private function onCreateRoleSuccess(param1:LoginEvent) : void
      {
         this._loginAgent.removeEventListener(LoginEvent.CREATE_ROLE_SUCCESS,this.onCreateRoleSuccess);
         this._content.removeChild(this._createRolePanel);
         this._createRolePanel.dispose();
         this._createRolePanel = null;
         this._justHasRole = true;
         this.hideBackground();
         this.showIntroAnimationPanel();
      }
      
      private function enterGame() : void
      {
         var _loc1_:ServerInfo = this._loginAgent.loginServerInfo;
         var _loc2_:Object = new Object();
         _loc2_.session = this._loginAgent.mainServerLoginInfo.session;
         _loc2_.serverId = _loc1_.serverId;
         _loc2_.onlineServerIp = _loc1_.serverIp;
         _loc2_.onlineServerPort = _loc1_.serverPort;
         _loc2_.userData = this._loginAgent.serverListInfo.friendData;
         _loc2_.otherServerType = this.otherServerType;
         _loc2_.fromGameId = this.fromGameId;
         _loc2_.serverType = Connection.netType;
         _loc2_.account = uint(this._loginAgent.mainServerLoginInfo.account);
         _loc2_.isRemoteLogin = this._loginAgent.mainServerLoginInfo.resultFlag >= 6;
         _loc2_.lastLoginIP = this._loginAgent.mainServerLoginInfo.lastLoginIP;
         _loc2_.lastLoginTime = this._loginAgent.mainServerLoginInfo.lastLoginTime;
         _loc2_.lastLoginCity = this._loginAgent.mainServerLoginInfo.lastLoginCity;
         _loc2_.curLoginCity = this._loginAgent.mainServerLoginInfo.curLoginCity;
         _loc2_.tab = topLeftTmcid;
         this.success(_loc2_);
         _loc2_ = null;
         this.dispose();
      }
      
      public function addLoginErrorListener() : void
      {
         this._loginAgent.addEventListener(LoginEvent.LOGIN_ERROR,this.onLoginError);
      }
      
      public function removeLoginErrorListener() : void
      {
         this._loginAgent.removeEventListener(LoginEvent.LOGIN_ERROR,this.onLoginError);
      }
      
      private function onLoginError(param1:LoginEvent) : void
      {
         AlarmPanel.show(this,param1.info);
      }
      
      private function dispose() : void
      {
         this.removeLoginErrorListener();
         if(this._serverListPanel)
         {
            this._serverListPanel.dispose();
            this._serverListPanel = null;
         }
         this._background = null;
         if(this._loginPanel)
         {
            this._loginPanel.dispose();
            this._loginPanel = null;
         }
         if(this._loginAgent)
         {
            this._loginAgent.dispose();
            this._loginAgent = null;
         }
         LoginConfig.dispose();
         ItemConfig.dispose();
         LoaderPool.dispose();
         LoaderAgent.dispose();
         CookieAgent.dispose();
         SoundAgent.dispose();
      }
      
      private function onApplyMimi(param1:LoginEvent) : void
      {
         this.hideMainLoginView();
         this.showRegisterPanel();
      }
      
      private function showRegisterPanel() : void
      {
         if(this._registerPanel == null)
         {
            this._registerPanel = new MainRegPanel();
            this._registerPanel.addEventListener(LoginEvent.REG_BACK_LOGIN,this.onBackLogin);
            this._registerPanel.addEventListener(LoginEvent.REG_SUCCESS_LOGIN,this.onSuccessLogin);
         }
         this._registerPanel.init();
         this._content.addChild(this._registerPanel);
      }
      
      private function hideRegisterPanel() : void
      {
         if(this._registerPanel != null)
         {
            if(contains(this._registerPanel))
            {
               this._content.removeChild(this._registerPanel);
            }
         }
      }
      
      private function showRegisterLoginPanel(param1:uint, param2:String) : void
      {
         if(this._registerLoginPanel == null)
         {
            this._registerLoginPanel = new MainRegLoginPanel(this._loginAgent);
         }
         this._registerLoginPanel.init(param1,param2);
         this._content.addChild(this._registerLoginPanel);
         this._registerLoginPanel.x = 115;
         this._registerLoginPanel.y = 50;
      }
      
      private function hideRegisterLoginPanel() : void
      {
         if(this._registerLoginPanel != null)
         {
            if(contains(this._registerLoginPanel))
            {
               this._content.removeChild(this._registerLoginPanel);
            }
         }
      }
      
      private function onBackLogin(param1:LoginEvent) : void
      {
         this.hideRegisterPanel();
         this.showMainLoginView();
      }
      
      private function onSuccessLogin(param1:LoginEvent) : void
      {
         var _loc2_:String = String(param1.info);
         var _loc3_:uint = uint(_loc2_.split("#")[0]);
         var _loc4_:String = String(_loc2_.split("#")[1]);
         this.hideRegisterPanel();
         this.showRegisterLoginPanel(_loc3_,_loc4_);
      }
   }
}
