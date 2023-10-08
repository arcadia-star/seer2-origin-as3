package com.taomee.seer2.module.login.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Elastic;
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.config.ServerNameConfig;
   import com.taomee.seer2.module.login.data.OnlineServerListInfo;
   import com.taomee.seer2.module.login.data.ServerInfo;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   
   public class SelectServerPanel extends Sprite
   {
       
      
      private const SERVER_PER_RW:uint = 100;
      
      private var _rwIndex:int = 1;
      
      private var _serverTotalCount:int;
      
      private var _loginAgent:LoginAgent;
      
      private var _serverListInfo:OnlineServerListInfo;
      
      private var _itemPage:com.taomee.seer2.module.login.view.ServerListItemPage;
      
      private var _serverInfoVec:Vector.<ServerInfo>;
      
      private var _serverListMc:MovieClip;
      
      private var _background:MovieClip;
      
      private var _serverAd:MovieClip;
      
      private var _okBtn:SimpleButton;
      
      private var _serCloseBtn:SimpleButton;
      
      private var _serEnterBtn:SimpleButton;
      
      private var _prevBtn:SimpleButton;
      
      private var _nextBtn:SimpleButton;
      
      private var _startGo:SimpleButton;
      
      private var _serverIdInputTxt:TextField;
      
      private var _selectedServerItemInfo:ServerInfo;
      
      private var _pageIndexTxt:TextField;
      
      private var _enterBtn:SimpleButton;
      
      private var _serverListBtn:SimpleButton;
      
      private var _serverListContainer:Sprite;
      
      private var _domain:ApplicationDomain;
      
      public function SelectServerPanel(param1:LoginAgent)
      {
         super();
         this._loginAgent = param1;
         LoaderAgent.addEventListener(LoaderAgent.currServerPage,this.onLoadServerPage);
         LoaderAgent.loadDomain(LoaderAgent.currServerPage);
      }
      
      private function onLoadServerPage(param1:Event) : void
      {
         LoaderAgent.removeEventListner(LoaderAgent.currServerPage,this.onLoadServerPage);
         this._domain = LoaderAgent.getDomain(LoaderAgent.currServerPage);
         LoginStatistics.sendNovice(LoginStatistics.selectServerGrabSuccess,this._loginAgent.mainServerLoginInfo.account);
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.showPanelAnimation();
         this.initData();
         this.initEventListener();
      }
      
      private function createChildren() : void
      {
         this.createBackground();
         this.createServerListContainer();
         this.createSelectePanel();
         this.createServerListPage();
      }
      
      private function createServerListAd() : void
      {
         if(LoginAgent.isNewPlayer == 1)
         {
            this.onOkBtn(null);
            return;
         }
         this._serverAd = DomainUtil.getMovieClip("ServerListAdUI",this._domain);
         this._okBtn = this._serverAd["okBtn"];
         this._serCloseBtn = this._serverAd["closeBtn"];
         this._okBtn.addEventListener(MouseEvent.CLICK,this.onOkBtn);
         this._serCloseBtn.addEventListener(MouseEvent.CLICK,this.onOkBtn);
         this._serEnterBtn = this._serverAd["enterBtn"];
         this._serEnterBtn.addEventListener(MouseEvent.CLICK,this.onEntryBtn);
         if(this._serverAd["activityMC"])
         {
            ActivityCountDownContent.setup(this._serverAd["activityMC"]);
         }
         addChild(this._serverAd);
      }
      
      private function onOkBtn(param1:MouseEvent = null) : void
      {
         this.clearServerAd();
      }
      
      private function clearServerAd() : void
      {
         if(this._serverAd)
         {
            this._okBtn.removeEventListener(MouseEvent.CLICK,this.onOkBtn);
            this._serCloseBtn.removeEventListener(MouseEvent.CLICK,this.onEntryBtn);
            DisplayObjectUtil.removeFromParent(this._serverAd);
            this._serverAd = null;
            this._okBtn = null;
            this._serCloseBtn = null;
         }
      }
      
      private function onEntryBtn(param1:MouseEvent) : void
      {
         this.clearServerAd();
         this._itemPage.selectServer();
      }
      
      private function createBackground() : void
      {
         this._background = DomainUtil.getMovieClip("ServerListBgUI",this._domain);
         addChild(this._background);
         this._background.x = 0;
         this._background.y = 0;
      }
      
      private function createServerListContainer() : void
      {
         this._serverListContainer = new Sprite();
         addChild(this._serverListContainer);
         this._serverListContainer.y = -560;
      }
      
      private function createSelectePanel() : void
      {
         this._serverListMc = DomainUtil.getMovieClip("ServerListUI",this._domain);
         this._serverListContainer.addChild(this._serverListMc);
         this._prevBtn = this._serverListMc["preBtn"];
         this._nextBtn = this._serverListMc["nextBtn"];
         this._startGo = this._serverListMc["startGo"];
         this._pageIndexTxt = this._serverListMc["txtPageIndex"];
         this._serverIdInputTxt = this._serverListMc["txtServerIdInput"];
         this._serverIdInputTxt.restrict = "0-9";
         this._serverIdInputTxt.maxChars = 4;
         this._enterBtn = this._serverListMc["btnEnter"];
         this._serverListBtn = this._serverListMc["serverListBtn"];
      }
      
      private function createServerListPage() : void
      {
         this._itemPage = new com.taomee.seer2.module.login.view.ServerListItemPage(this._loginAgent,this._domain);
         this._serverListContainer.addChild(this._itemPage);
      }
      
      private function showPanelAnimation() : void
      {
         TweenLite.to(this._serverListContainer,0.5,{
            "y":10,
            "onComplete":this.playElasticEffect
         });
      }
      
      private function playElasticEffect() : void
      {
         if(!this._serverListContainer)
         {
            return;
         }
         TweenLite.to(this._serverListContainer,0.5,{
            "y":0,
            "ease":Elastic.easeOut
         });
      }
      
      private function initEventListener() : void
      {
         this._prevBtn.addEventListener(MouseEvent.CLICK,this.onPrePaged);
         this._nextBtn.addEventListener(MouseEvent.CLICK,this.onNextPaged);
         this._enterBtn.addEventListener(MouseEvent.CLICK,this.onQuickEnter);
         this._serverIdInputTxt.addEventListener(MouseEvent.CLICK,this.onInputTextClick);
         this._serverListBtn.addEventListener(MouseEvent.CLICK,this.onGetAllServer);
         this._startGo.addEventListener(MouseEvent.CLICK,this.onStartGo);
      }
      
      private function clearEventListener() : void
      {
         this._prevBtn.removeEventListener(MouseEvent.CLICK,this.onPrePaged);
         this._nextBtn.removeEventListener(MouseEvent.CLICK,this.onNextPaged);
         this._enterBtn.removeEventListener(MouseEvent.CLICK,this.onQuickEnter);
         this._serverIdInputTxt.removeEventListener(MouseEvent.CLICK,this.onInputTextClick);
         this._serverListBtn.removeEventListener(MouseEvent.CLICK,this.onGetAllServer);
      }
      
      private function onStartGo(param1:MouseEvent) : void
      {
         this._itemPage.selectServer();
      }
      
      private function onPrePaged(param1:MouseEvent) : void
      {
         if(this._itemPage.isFirstPage && this._rwIndex > 1)
         {
            --this._rwIndex;
            this._itemPage.orderMode = false;
            this.getRangeServerList();
         }
         else
         {
            this._itemPage.turnToPrevPage();
            this.updatePageStatus();
         }
      }
      
      private function onNextPaged(param1:MouseEvent) : void
      {
         if(this._itemPage.isLastPage && this._rwIndex * this.SERVER_PER_RW < this._serverTotalCount)
         {
            ++this._rwIndex;
            this._itemPage.orderMode = true;
            this.getRangeServerList();
         }
         else
         {
            this._itemPage.turnToNextPage();
            this.updatePageStatus();
         }
      }
      
      private function onQuickEnter(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(this._serverIdInputTxt.text);
         if(_loc2_ == 0)
         {
            this._serverIdInputTxt.text = "输入服务器编码";
            return;
         }
         if(LoginAgent.isNewPlayer != 1 && ServerNameConfig.isNewServer(_loc2_) == 1)
         {
            this._serverIdInputTxt.text = "服务器号不存在";
            return;
         }
         this.getSingleServerInfo(_loc2_);
         if(!this._loginAgent.mainServerLoginInfo.hasRole)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.QuickEnterServer,this._loginAgent.mainServerLoginInfo.account);
         }
         else
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.QuickEnterServer_Old,this._loginAgent.mainServerLoginInfo.account);
         }
      }
      
      private function onGetAllServer(param1:MouseEvent) : void
      {
         this.getRangeServerList();
      }
      
      private function getRangeServerList() : void
      {
         WaitLoadingBar.show(this);
         this._loginAgent.getRangedServerList((this._rwIndex - 1) * this.SERVER_PER_RW + 1,this._rwIndex * this.SERVER_PER_RW,this.onGetRangeServerInfo);
      }
      
      private function onGetRangeServerInfo() : void
      {
         WaitLoadingBar.hide();
         this._serverListInfo = this._loginAgent.serverListInfo;
         this._serverInfoVec = this._serverListInfo.serverInfoVector;
         this._serverInfoVec = this._serverInfoVec.sort(this.serverSort);
         this._itemPage.setServerListData(this._serverInfoVec);
         this.updatePageStatus();
      }
      
      private function serverSort(param1:ServerInfo, param2:ServerInfo) : int
      {
         if(param1.serverId < param2.serverId)
         {
            return -1;
         }
         if(param1.serverId > param2.serverId)
         {
            return 1;
         }
         return 0;
      }
      
      private function onInputTextClick(param1:MouseEvent) : void
      {
         this._serverIdInputTxt.text = "";
      }
      
      private function initData() : void
      {
         WaitLoadingBar.show(this);
         this.onGetRecommendedServerList();
      }
      
      private function onGetRecommendedServerList() : void
      {
         WaitLoadingBar.hide();
         this.createServerListAd();
         this._serverListInfo = this._loginAgent.serverListInfo;
         this._serverInfoVec = this._serverListInfo.serverInfoVector;
         this._serverTotalCount = this._loginAgent.serverTotalCount;
         this._itemPage.setServerListData(this._serverInfoVec);
         DisplayObjectUtil.disableButton(this._prevBtn);
         DisplayObjectUtil.disableButton(this._nextBtn);
         this._pageIndexTxt.text = 1 + "/" + 1;
         if(LoginAgent.isNewPlayer == 1)
         {
            LoaderAgent.addUrlVec();
         }
      }
      
      private function updatePageStatus() : void
      {
         this.checkPageBtn();
         this.updatePageTxt();
      }
      
      private function checkPageBtn() : void
      {
         DisplayObjectUtil.enableButton(this._prevBtn);
         DisplayObjectUtil.enableButton(this._nextBtn);
         if(this._itemPage.isFirstPage && this._rwIndex == 1)
         {
            DisplayObjectUtil.disableButton(this._prevBtn);
         }
         if(this._itemPage.isLastPage && this._rwIndex * this.SERVER_PER_RW >= this._serverTotalCount)
         {
            DisplayObjectUtil.disableButton(this._nextBtn);
         }
      }
      
      private function updatePageTxt() : void
      {
         var _loc1_:int = (this._rwIndex - 1) * 10 + this._itemPage.pageIndex;
         var _loc2_:int = int(this._itemPage.totalPages);
         this._pageIndexTxt.text = _loc1_.toString() + "/" + _loc2_;
      }
      
      private function getSingleServerInfo(param1:uint) : void
      {
         this._loginAgent.getRangedServerList(param1,param1,this.onGetSingleServerInfo);
      }
      
      private function onGetSingleServerInfo() : void
      {
         this._serverListInfo = this._loginAgent.serverListInfo;
         this._serverInfoVec = this._serverListInfo.serverInfoVector;
         if(this._serverInfoVec.length != 1)
         {
            this._serverIdInputTxt.text = "服务器号不存在";
            return;
         }
         this._loginAgent.loginServerInfo = this._serverInfoVec[0];
         var _loc1_:int = int(this._loginAgent.loginServerInfo.userCount);
         if(_loc1_ >= 5)
         {
            AlarmPanel.show(this,"连接失败，请稍后再试 或者尝试其他服务器");
            return;
         }
         this._loginAgent.dispatchEvent(new LoginEvent(LoginEvent.ONLINE_SERVER_SELECTED));
      }
      
      public function dispose() : void
      {
         TweenLite.killTweensOf(this._serverListMc);
         this._itemPage.dispose();
         this.clearEventListener();
         removeChild(this._serverListContainer);
         this._serverListContainer = null;
         this._loginAgent = null;
         this._serverListInfo = null;
         this._serverListMc = null;
         this._itemPage = null;
         this._selectedServerItemInfo = null;
         this._serverInfoVec = null;
         this._serverIdInputTxt = null;
         this._nextBtn = null;
         this._prevBtn = null;
         this._domain = null;
      }
   }
}
