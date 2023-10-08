package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.config.ServerNameConfig;
   import com.taomee.seer2.module.login.data.ServerInfo;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   
   public class ServerListItem extends Sprite
   {
       
      
      private var _serverInfo:ServerInfo;
      
      private var _serverDetailMc:MovieClip;
      
      private var _serverIdTxt:TextField;
      
      private var _serverNameTxt:TextField;
      
      private var _bg:MovieClip;
      
      private var _id:uint;
      
      private var _userCountView:MovieClip;
      
      private var _svrIcon:MovieClip;
      
      private var _domain:ApplicationDomain;
      
      private var _tuijian:MovieClip;
      
      public function ServerListItem(param1:ApplicationDomain)
      {
         super();
         this._domain = param1;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.createChildren();
         this.initEventListener();
      }
      
      private function createChildren() : void
      {
         this._serverDetailMc = DomainUtil.getMovieClip("ServerDetailUI",this._domain);
         this._serverDetailMc.buttonMode = true;
         addChild(this._serverDetailMc);
         this._serverIdTxt = this._serverDetailMc.serverIdTxt;
         this._serverNameTxt = this._serverDetailMc.serverNameTxt;
         this._serverIdTxt.mouseEnabled = false;
         this._serverNameTxt.mouseEnabled = false;
         this._userCountView = this._serverDetailMc.userCountView;
         this._bg = this._serverDetailMc.bg;
         this._svrIcon = this._serverDetailMc.svrIcon;
         this._tuijian = this._serverDetailMc.tuijian;
      }
      
      private function initEventListener() : void
      {
      }
      
      private function clearEventListener() : void
      {
      }
      
      private function onMouseRollOver(param1:MouseEvent) : void
      {
         this._serverDetailMc.gotoAndStop(2);
      }
      
      private function onMouseRollOut(param1:MouseEvent) : void
      {
         this._serverDetailMc.gotoAndStop(1);
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         this._serverDetailMc.gotoAndStop(3);
      }
      
      public function destroy() : void
      {
         this.clearEventListener();
         removeChild(this._serverDetailMc);
         this._serverInfo = null;
         this._serverDetailMc = null;
         this._serverIdTxt = null;
         this._serverNameTxt = null;
         this._domain = null;
      }
      
      private function showServerStatusIcon(param1:int) : void
      {
         this.resetServerStatusIcon();
      }
      
      private function resetServerStatusIcon() : void
      {
      }
      
      private function initView() : void
      {
         this._serverIdTxt.text = this._id.toString();
         this._serverNameTxt.text = ServerNameConfig.getServerName(this._id);
         this.createUserCountView();
         this._bg.gotoAndStop(this._serverInfo.isRecommendSvr + 1);
         if(LoginAgent.isNewPlayer == 1)
         {
            this._svrIcon.gotoAndStop(this._serverInfo.isRecommendSvr + 1);
            this._tuijian.gotoAndStop(this._serverInfo.isRecommendSvr + 1);
         }
         else
         {
            this._svrIcon.gotoAndStop(this._serverInfo.isRecommendSvr);
            this._tuijian.gotoAndStop(this._serverInfo.isRecommendSvr);
         }
      }
      
      public function setName(param1:String) : void
      {
         this._serverNameTxt.text = param1;
      }
      
      private function createUserCountView() : void
      {
         var _loc2_:uint = 0;
         if(this._serverInfo.userCount < 5)
         {
            _loc2_ = Math.random() * 100;
            if(_loc2_ > 50)
            {
               this._userCountView.gotoAndStop(4);
            }
            else
            {
               this._userCountView.gotoAndStop(3);
            }
         }
         else
         {
            this._userCountView.gotoAndStop(5);
         }
         var _loc1_:Boolean = true;
         if(this._serverInfo.isNewSvr == 1 && LoginAgent.isNewPlayer != 1)
         {
            _loc1_ = false;
         }
         if(this._serverInfo.userCount == 5 || !_loc1_)
         {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this.buttonMode = false;
         }
         else
         {
            this.mouseEnabled = true;
            this.mouseChildren = true;
            this.buttonMode = true;
         }
      }
      
      public function reset() : void
      {
      }
      
      public function createDefualtData(param1:uint) : void
      {
         this._id = param1;
         this._serverInfo = new ServerInfo();
         this._serverInfo.serverId = 1;
         this._serverInfo.serverIp = "10.1.1.52";
         this._serverInfo.serverPort = 1980;
         this.initView();
      }
      
      public function get serverInfo() : ServerInfo
      {
         return this._serverInfo;
      }
      
      public function set serverInfo(param1:ServerInfo) : void
      {
         this._serverInfo = param1;
         this._id = this._serverInfo.serverId;
         this.initView();
      }
      
      public function get hasInfo() : Boolean
      {
         return this._serverInfo != null;
      }
      
      public function get isFull() : Boolean
      {
         return true;
      }
      
      public function get isCrowd() : Boolean
      {
         return true;
      }
   }
}
