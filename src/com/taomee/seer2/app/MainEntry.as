package com.taomee.seer2.app
{
   import com.taomee.analytics.Analytics;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.debugTools.DebugTools;
   import com.taomee.seer2.app.init.LoginInfo;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
   import com.taomee.seer2.app.notify.NoticeManager;
   import com.taomee.seer2.app.novice.NoviceInit;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.team.TeamManager;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.UILoader;
   import com.taomee.seer2.core.log.Logger;
   import com.taomee.seer2.core.manager.GlobalsManager;
   import com.taomee.seer2.core.manager.VersionManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.ImageLevelManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.LoadingBG;
   import com.taomee.seer2.core.ui.LoadingBar;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.ui.ContextMenuItem;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import org.taomee.bean.BeanEvent;
   import org.taomee.bean.BeanManager;
   import org.taomee.manager.TaomeeManager;
   import org.taomee.utils.StringUtil;
   import org.taomee.utils.Tick;
   
   public class MainEntry
   {
       
      
      private var _logger:Logger;
      
      private var _isDeputize:Boolean;
      
      private var _socketTimeOut:int;
      
      private var _isConection:Boolean = false;
      
      public var _root:Sprite;
      
      private var _bg:Sprite;
      
      public function MainEntry()
      {
         super();
      }

      public function setXML(param1:XML, param2:XML) : void
      {
         ClientConfig.setXML(param1);
         BeanManager.config(param2);
      }
      
      public function setConfig(param1:Boolean, param2:Object, param3:String, param4:Boolean = false) : void
      {
         ClientConfig.setDebug(param1);
         ClientConfig.setRootURL(param3);
         ClientConfig.setLocal(param4);
         VersionManager.setup(param2);
      }
      
      public function initialize(param1:Sprite, param2:Object) : void
      {
         this._root = param1;
         this._logger = Logger.getLogger("MainEntry");
         ModuleManager.setup(param1.stage);
         TaomeeManager.stage = param1.stage;
         LayerManager.setup(param1);
         ImageLevelManager.setStage(param1.stage);
         TooltipManager.setup();
         LoginInfo.setFromBaseInfo(param2);
         Connection.setUserId(LoginInfo.account);
         Connection.setGameId(10);
         this.loginOnline();
         Analytics.init(3,"http://seer2.61.com",param1.stage);
         if(!ClientConfig.isDebug)
         {
         }
         GlobalsManager.isFromGF = param2.fromGameId == 6;
         GlobalsManager.serverType = param2.serverType;
         GlobalsManager.otherServerType = param2.otherServerType;
         GlobalsManager.isRemoteLogin = param2.isRemoteLogin;
         GlobalsManager.lastLoginIP = param2.lastLoginIP;
         GlobalsManager.lastLoginTime = param2.lastLoginTime;
         GlobalsManager.lastLoginCity = param2.lastLoginCity;
         GlobalsManager.curLoginCity = param2.curLoginCity;
         GlobalsManager.tab = param2.tab;
         GlobalsManager.fromGame = param2.fromGameId;
         Connection.netType = GlobalsManager.serverType;
         Connection.blockCommand(CommandSet.ITEM_SERVER_GIVE_1051);
         Connection.blockCommand(CommandSet.GET_CONIS_1547);
         Connection.blockCommand(CommandSet.TEMP_NOTIFY_1548);
         this._bg = new LoadingBG();
         LayerManager.mapLayer.addChild(this._bg);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         TaomeeManager.stage.addEventListener(Event.RESIZE,this.onResize);
         this.onResize(null);
         try
         {
            //Seer2NextEntry.initialize();
         }
         catch(e:*)
         {
         }
      }
      
      public function getImageModuleShow() : void
      {
         ImageLevelManager.showImagePanel();
      }
      
      private function onResize(param1:Event) : void
      {
         if(this._bg)
         {
            this._bg.scaleX = TaomeeManager.stage.stageWidth / 1200;
            this._bg.scaleY = TaomeeManager.stage.stageHeight / 660;
            this._bg.x = 0;
            this._bg.y = 0;
         }
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         var imageLevelItem:ContextMenuItem;
         var evt:SceneEvent = param1;
         TaomeeManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         DisplayObjectUtil.removeFromParent(this._bg);
         imageLevelItem = new ContextMenuItem("设置画质");
         var t:Object = this._root.contextMenu;
         t.customItems.push(imageLevelItem);
         imageLevelItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,function(param1:ContextMenuEvent):void
         {
            getImageModuleShow();
         });
      }
      
      private function loginOnline() : void
      {
         LoadingBar.show("正在进入游戏");
         Connection.addEventListener(Event.CONNECT,this.onSocketConnect);
         Connection.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
         Connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
         try
         {
            this._socketTimeOut = setTimeout(this.onSocketTimeOut,6000);
            Connection.connect(LoginInfo.onlineIP,LoginInfo.onlinePort);
            StatisticsManager.newSendNovice("_newtrans_","fSendOnlineReq","前端执行进入Online服务IP:" + LoginInfo.onlineIP + "端口:" + LoginInfo.onlinePort);
         }
         catch(e:SecurityError)
         {
            onSocketSecurityError(null);
         }
      }
      
      private function onSocketTimeOut() : void
      {
         this.onSocketSecurityError(null);
      }
      
      private function onSocketConnect(param1:Event) : void
      {
         var _loc2_:ByteArray = null;
         Connection.removeEventListener(Event.CONNECT,this.onSocketConnect);
         Connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
         clearTimeout(this._socketTimeOut);
         if(this._isDeputize)
         {
            this._logger.info("代理服务器连接成功");
            _loc2_ = new ByteArray();
            _loc2_.writeShort(LoginInfo.onlinePort);
            Connection.send(CommandSet.DEPUTIZE_SEND_999,StringUtil.ipToBytes(LoginInfo.onlineIP),_loc2_);
         }
         NoticeManager.block();
         this._isConection = false;
         Connection.addCommandListener(CommandSet.ONLINE_LOGIN_1001,this.onLoginOnline);
         Connection.send(CommandSet.ONLINE_LOGIN_1001,GlobalsManager.fromGame,LoginInfo.session,this.getTopLeftTmcid());
         if(!ClientConfig.isDebug)
         {
         }
         StatisticsManager.newSendNovice("_newtrans_","fSocketOnline","前端建立Socket连接到Online成功");
         StatisticsManager.newSendNovice("_newtrans_","fOnlineSucc","前端成功进入online服务器");
         StatisticsManager.newSendNovice("_newtrans_","fSend1001Req","前端发送1001登陆协议");
      }
      
      private function getTopLeftTmcid() : LittleEndianByteArray
      {
         var _loc2_:String = null;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.length = 64;
         if(GlobalsManager.tab != null && GlobalsManager.tab != "none" && GlobalsManager.tab != "")
         {
            _loc1_.writeUTFBytes(GlobalsManager.tab);
         }
         else
         {
            _loc1_.writeUTFBytes("0");
         }
         return _loc1_;
      }
      
//      public function showDebugToolPanel(param1:Boolean = false) : void
//      {
//         if(param1)
//         {
//            DebugTools.setUp(LoginInfo.account);
//            return;
//         }
//         if(DebugTools.uiLoadedFlag)
//         {
//            if(!LayerManager.topLayer.contains(DebugTools.getInstance()))
//            {
//               LayerManager.topLayer.addChild(DebugTools.getInstance());
//            }
//            else
//            {
//               DisplayObjectUtil.removeFromParent(DebugTools.getInstance());
//            }
//         }
//      }

      public static function showDebugToolPanel(param1:Boolean = true) : void
      {
         if(param1)
         {
            DebugTools.setUp(LoginInfo.account);
         }
         if(DebugTools.uiLoadedFlag)
         {
            if(!LayerManager.topLayer.contains(DebugTools.getInstance()))
            {
               LayerManager.topLayer.addChild(DebugTools.getInstance());
            }
            else
            {
               LayerManager.topLayer.addChild(DebugTools.getInstance());
            }
         }
      }

      private function runConnection(param1:int) : void
      {
         if(!this._isConection)
         {
            Connection.connect(LoginInfo.onlineIP,LoginInfo.onlinePort);
            Connection.addEventListener(Event.CONNECT,this.onSocketConnect);
            Connection.addEventListener(IOErrorEvent.IO_ERROR,this.onSocketError);
            Connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSocketSecurityError);
         }
      }
      
      private function onSocketError(param1:IOErrorEvent) : void
      {
         LoadingBar.show("进入游戏失败");
         StatisticsManager.sendError(StatisticsManager.onlineFailed);
      }
      
      private function onSocketSecurityError(param1:SecurityErrorEvent) : void
      {
         this._logger.error("online服务器安全策略错误");
         LoadingBar.show("游戏服务器安全策略错误");
         StatisticsManager.sendError(StatisticsManager.onlineSandbox);
         if(this._isDeputize)
         {
            return;
         }
         this._isDeputize = true;
         clearTimeout(this._socketTimeOut);
         if(Connection.netType == Connection.TEL)
         {
            Connection.connect(ClientConfig.telDeputizeIP,ClientConfig.telDeputizePort);
         }
         else
         {
            Connection.connect(ClientConfig.cncDeputizeIP,ClientConfig.cncDeputizePort);
         }
         StatisticsManager.newSendNovice("新手引导tyler版","2014上半年版新手引导tyler版","连接Online失败 游戏服务器安全策略错误IP:" + LoginInfo.onlineIP + "端口:" + LoginInfo.onlinePort + "服务器编号" + LoginInfo.serverID);
         this._logger.info("连接代理服务器");
      }
      
      private function onLoginOnline(param1:MessageEvent) : void
      {
         this._isConection = true;
         if(ClientConfig.isDebug)
         {
            Tick.instance.removeRender(this.runConnection);
         }
         this._logger.info("成功登录online");
         Connection.removeCommandListener(CommandSet.ONLINE_LOGIN_1001,this.onLoginOnline);
         LoginInfo.setFromOnline(param1.message.getRawData());
         UILoader.load(URLUtil.getUISwf("UI"),LoadType.DOMAIN,this.onLoadUI);
      }
      
      private function onLoadUI(param1:ContentInfo) : void
      {
         LoadingBar.show("正在进入地图");
         UIManager.setup(param1.content);
         showDebugToolPanel(false);
         this.initBean();
         StatisticsManager.newSendNovice("_newtrans_","fLoadInfoSucc","加载资源成功");
      }
      
      private function initBean() : void
      {
         BeanManager.addEventListener(BeanEvent.COMPLETE,this.onBeanComplete);
         BeanManager.start("1");
      }
      
      private function onBeanComplete(param1:BeanEvent) : void
      {
         BeanManager.removeEventListener(BeanEvent.COMPLETE,this.onBeanComplete);
         ClientConfig.isInitComplete = true;
         if(param1.id == "1")
         {
            if(QuestManager.isInit)
            {
               this.onQuestInit(null);
            }
            else
            {
               QuestManager.addEventListener(QuestEvent.INIT,this.onQuestInit);
            }
         }
         else if(param1.id == "2")
         {
         }
      }
      
      private function onQuestInit(param1:QuestEvent) : void
      {
         var _loc2_:uint = 0;
         QuestManager.removeEventListener(QuestEvent.INIT,this.onQuestInit);
         RightToolbarConter.instance.newPlayerShowFilter();
         LoginInfo.startCheckDayOneLogin();
         if(QuestManager.isFreshQuestComplete())
         {
            BeanManager.start("2");
            _loc2_ = new Date(2014,8,26).getTime() / 1000;
            if(SceneType.getTypeFromMapID(LoginInfo.mapId) == SceneType.NOVICE)
            {
               if(NewPlayerGuideTimeManager.timeCheckNewGuide())
               {
                  SceneManager.changeScene(SceneType.COPY,80491);
               }
               else
               {
                  SceneManager.changeScene(SceneType.COPY,80351);
               }
            }
            if(ActorManager.actorInfo.createTime > _loc2_ && !NewPlayerGuideTimeManager.timeCheckNewGuide() && QuestManager.isComplete(83) == false)
            {
               SceneManager.changeScene(SceneType.COPY,80351);
            }
            else if(NewPlayerGuideTimeManager.timeCheckNewGuide() && !QuestManager.isComplete(99))
            {
               SceneManager.changeScene(SceneType.COPY,80491);
            }
            else
            {
               this.enterScene();
            }
         }
         else
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
            if(NoviceInit.exec() == false)
            {
               this.enterScene();
            }
         }
      }
      
      private function enterScene() : void
      {
         var _loc1_:int = int(SceneType.getFromServerType(LoginInfo.sceneId));
         if(_loc1_ == SceneType.TEAM && TeamManager.teamId == 0)
         {
            SceneManager.changeScene(SceneType.HOME,ActorManager.actorInfo.id);
         }
         else
         {
            SceneManager.changeScene(_loc1_,LoginInfo.mapId);
         }
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         if(QuestManager.isFreshQuestComplete())
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         }
      }
   }
}
