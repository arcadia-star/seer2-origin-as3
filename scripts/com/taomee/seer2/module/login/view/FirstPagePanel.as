package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.HttpURLUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.utils.clearTimeout;
   
   public class FirstPagePanel extends Sprite
   {
      
      private static const BTN_NUM:int = 8;
       
      
      private var _firstPageMc:MovieClip;
      
      private var _btnVec:Vector.<SimpleButton>;
      
      private var _domain:ApplicationDomain;
      
      private var _isAutoRegister:Boolean;
      
      private var _mc0:MovieClip;
      
      private var _setTimeout:uint;
      
      private var _tipMCList:MovieClip;
      
      private var _downMC:MovieClip;
      
      private var _bgMC:MovieClip;
      
      private var _actorMC:MovieClip;
      
      private var _titleMC:MovieClip;
      
      private var _schoolMark:MovieClip;
      
      private var _stage:Stage;
      
      private var _firstPageStr:String;
      
      private var _pageIndex:int = 0;
      
      private var _pageMC:MovieClip;
      
      public function FirstPagePanel()
      {
         super();
         this._firstPageStr = this.getCurPageStr();
         LoaderAgent.addEventListener(this._firstPageStr,this.onLoadFirstPage);
         LoaderAgent.loadDomain(this._firstPageStr);
      }
      
      private function getCurPageStr() : String
      {
         return "firstPage";
      }
      
      private function onLoadFirstPage(param1:Event) : void
      {
         LoaderAgent.removeEventListner(this._firstPageStr,this.onLoadFirstPage);
         this._domain = LoaderAgent.getDomain(this._firstPageStr);
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.initEventListener();
         LoginStatistics.sendAccountNovice(LoginStatistics.openFirstPage,"0");
      }
      
      public function layOut(param1:Stage) : void
      {
         this._stage = param1;
         if(this._tipMCList)
         {
            this._tipMCList.x = param1.stageWidth;
         }
         if(this._downMC)
         {
            this._downMC.x = param1.stageWidth / 2 - (1200 - param1.stageWidth) / 1200 * 150;
            this._downMC.y = param1.stageHeight;
         }
         if(this._bgMC)
         {
            this._bgMC.x = param1.stageWidth / 2;
            this._bgMC.y = param1.stageHeight / 2;
         }
         if(this._titleMC)
         {
            this._titleMC.y = param1.stageHeight;
         }
      }
      
      private function createChildren() : void
      {
         this._firstPageMc = DomainUtil.getMovieClip("FirstPageUI",this._domain);
         addChild(this._firstPageMc);
         this._tipMCList = this._firstPageMc["tipMC"];
         this._downMC = this._firstPageMc["downMC"];
         this._bgMC = this._firstPageMc["bgMC"];
         this._titleMC = this._firstPageMc["titleMC"];
         this._schoolMark = this._downMC["schoolMark"];
         this.layOut(this._stage);
         this._btnVec = new Vector.<SimpleButton>();
         var _loc1_:int = 0;
         while(_loc1_ < BTN_NUM)
         {
            this._btnVec.push(this._tipMCList["btn_" + _loc1_]);
            _loc1_++;
         }
         this._btnVec[3].visible = false;
         this._mc0 = this._tipMCList["mc0"];
         this._mc0.buttonMode = true;
         var _loc2_:int = new Date(2016,10,25).date - new Date().date;
      }
      
      private function startPage() : void
      {
         this._firstPageMc.gotoAndStop(this._pageIndex + 1);
         this._pageMC = this._firstPageMc["pageMC"];
         if(this._pageIndex == 0)
         {
            this._pageMC.gotoAndPlay(2);
            this._pageMC.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this._pageIndex = 1;
         }
         else
         {
            this._pageMC.gotoAndPlay(2);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this._pageMC.currentFrame == this._pageMC.totalFrames)
         {
            this._pageMC.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this._pageMC.gotoAndStop(1);
            this.startPage();
         }
      }
      
      private function initEventListener() : void
      {
         this._firstPageMc.addEventListener("start",this.onLoginStart);
         this._firstPageMc.addEventListener("favorite",this.onFavorite);
         this._firstPageMc.addEventListener("register",this.onRegister);
         this._firstPageMc.addEventListener("taomee",this.onTaomee);
         this._firstPageMc.addEventListener("parentsRead",this.onParentsRead);
         var _loc1_:int = 0;
         while(_loc1_ < this._btnVec.length)
         {
            this._btnVec[_loc1_].addEventListener(MouseEvent.CLICK,this.onBtnClick);
            _loc1_++;
         }
         this._mc0.addEventListener(MouseEvent.CLICK,this.onbbs);
      }
      
      private function onAD(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://game.61.com/event/tlj-2015/?tad=innermedia.seer2.free.banner"),"_blank");
      }
      
      private function onNewLink(param1:MouseEvent) : void
      {
         var _loc2_:String = "http://seer.v.61.com/?tad=innermedia.seer.free.tricon";
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
      
      private function onDownMCMC(param1:MouseEvent) : void
      {
         var _loc2_:String = "http://game.61.com/web/tlj.shtml?tad=innermedia.seer2.free.hyy";
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
      
      private function onParentsRead(param1:Event) : void
      {
         var _loc2_:String = "http://parents.61.com/care";
         navigateToURL(new URLRequest(_loc2_),"_blank");
         LoginStatistics.newSendNovice("基本数据","-1","首页按钮点击","淘米游戏LOGO点击");
      }
      
      private function onbbs(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(HttpURLUtil.BBS_ACTIVITY),"_blank");
      }
      
      private function onRegister(param1:Event) : void
      {
         var _loc2_:String = null;
         if(ExternalInterface.available)
         {
            this._isAutoRegister = true;
            this.onLoginStart(null);
         }
         else
         {
            _loc2_ = "http://account.61.com/register";
            navigateToURL(new URLRequest(_loc2_),"_blank");
         }
         LoginStatistics.newSendNovice("基本数据","-1","首页按钮点击","注册账号点击");
      }
      
      private function closeEventListener() : void
      {
         this._firstPageMc.removeEventListener("start",this.onLoginStart);
         this._firstPageMc.removeEventListener("favorite",this.onFavorite);
         this._firstPageMc.removeEventListener("register",this.onRegister);
         this._firstPageMc.removeEventListener("taomee",this.onTaomee);
         this._firstPageMc.removeEventListener("parentsRead",this.onParentsRead);
         var _loc1_:int = 1;
         while(_loc1_ < this._btnVec.length)
         {
            this._btnVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.onBtnClick);
            _loc1_++;
         }
         if(this._pageMC)
         {
            this._pageMC.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         this._pageMC = null;
         clearTimeout(this._setTimeout);
      }
      
      private function onLoginStart(param1:Event) : void
      {
         LoginStatistics.newSendNovice("基本数据","-1","首页按钮点击","开始按钮点击");
         dispatchEvent(new LoginEvent(LoginEvent.LOGIN_START));
      }
      
      private function onFavorite(param1:Event) : void
      {
         LoginStatistics.newSendNovice("基本数据","-1","首页按钮点击","收藏游戏点击");
         ExternalInterface.call("addBookmark","约瑟传说-飞跃巅峰！","http://seer2.61.com");
      }
      
      private function onTaomee(param1:Event) : void
      {
         var _loc2_:String = "http://game.61.com";
         navigateToURL(new URLRequest(_loc2_),"_blank");
         LoginStatistics.newSendNovice("基本数据","-1","首页按钮点击","淘米游戏LOGO点击");
      }
      
      private function onBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.currentTarget.name.split("_")[1]);
         HttpURLUtil.linkToGame(_loc2_);
         LoginStatistics.newSendNovice("基本数据","-1","首页按钮点击",_loc2_ + 1 + "号广告位点击");
      }
      
      public function isAutoRegister() : Boolean
      {
         return this._isAutoRegister;
      }
      
      public function dispose() : void
      {
         this.removeChild(this._firstPageMc);
         this.closeEventListener();
         this._firstPageMc = null;
         this._domain = null;
      }
   }
}
