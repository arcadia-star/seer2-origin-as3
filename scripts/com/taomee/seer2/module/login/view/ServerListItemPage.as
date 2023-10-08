package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoginAgent;
   import com.taomee.seer2.module.login.data.ServerInfo;
   import com.taomee.seer2.module.login.event.LoginEvent;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class ServerListItemPage extends Sprite
   {
      
      public static const VIEW_SIZE:int = 10;
      
      private static const ITEM_DISTANCE:uint = 125;
       
      
      private var _currentPageItemVec:Vector.<com.taomee.seer2.module.login.view.ServerListItem>;
      
      private var _serverInfoVec:Vector.<ServerInfo>;
      
      private var _pageIndex:uint = 1;
      
      private var _totalPages:uint = 1;
      
      private var _loginAgent:LoginAgent;
      
      public var orderMode:Boolean = true;
      
      private var _domain:ApplicationDomain;
      
      private var _serverIndex:int = 0;
      
      public function ServerListItemPage(param1:LoginAgent, param2:ApplicationDomain)
      {
         super();
         this._loginAgent = param1;
         this._domain = param2;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._currentPageItemVec = new Vector.<com.taomee.seer2.module.login.view.ServerListItem>();
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this.x = 102;
         this.y = 80;
         this.createBlankItem(this._currentPageItemVec);
      }
      
      private function createBlankItem(param1:Vector.<com.taomee.seer2.module.login.view.ServerListItem>) : void
      {
         var _loc3_:com.taomee.seer2.module.login.view.ServerListItem = null;
         var _loc2_:int = 0;
         while(_loc2_ < VIEW_SIZE)
         {
            _loc3_ = new com.taomee.seer2.module.login.view.ServerListItem(this._domain);
            _loc3_.x = (_loc3_.width + ITEM_DISTANCE) * (_loc2_ % 2) + 215;
            _loc3_.y = (_loc3_.height + 20) * (_loc2_ >> 1) + 35;
            _loc3_.visible = false;
            this.addChild(_loc3_);
            this.addItemEventListener(_loc3_);
            param1.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function clearItems() : void
      {
         var _loc1_:com.taomee.seer2.module.login.view.ServerListItem = null;
         for each(_loc1_ in this._currentPageItemVec)
         {
            this.destroyItem(_loc1_);
         }
      }
      
      private function hideItem(param1:Vector.<com.taomee.seer2.module.login.view.ServerListItem>) : void
      {
         var _loc2_:com.taomee.seer2.module.login.view.ServerListItem = null;
         for each(_loc2_ in param1)
         {
            this.removeChild(_loc2_);
         }
      }
      
      private function addItemEventListener(param1:com.taomee.seer2.module.login.view.ServerListItem) : void
      {
         param1.buttonMode = true;
         param1.addEventListener(MouseEvent.CLICK,this.onServerItemClick);
      }
      
      private function onServerItemClick(param1:MouseEvent) : void
      {
         if(!this._loginAgent.mainServerLoginInfo.hasRole)
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.ClickServerBtn_New,this._loginAgent.mainServerLoginInfo.account);
            LoginStatistics.sendNovice(LoginStatistics.selectServerSelectOne,this._loginAgent.mainServerLoginInfo.account);
         }
         else
         {
            LoginStatistics.sendAccountNovice(LoginStatistics.ClickServerBtn_Old,this._loginAgent.mainServerLoginInfo.account);
         }
         var _loc2_:com.taomee.seer2.module.login.view.ServerListItem = param1.currentTarget as com.taomee.seer2.module.login.view.ServerListItem;
         this._loginAgent.loginServerInfo = _loc2_.serverInfo;
         this._loginAgent.dispatchEvent(new LoginEvent(LoginEvent.ONLINE_SERVER_SELECTED));
      }
      
      private function destroyItem(param1:com.taomee.seer2.module.login.view.ServerListItem) : void
      {
         param1.removeEventListener(MouseEvent.CLICK,this.onServerItemClick);
         if(param1.parent != null)
         {
            this.removeChild(param1);
         }
         param1.destroy();
      }
      
      public function selectServer(param1:int = 0) : void
      {
         if(this._currentPageItemVec[param1].serverInfo.userCount < 5)
         {
            this._loginAgent.loginServerInfo = this._currentPageItemVec[param1].serverInfo;
            this._loginAgent.dispatchEvent(new LoginEvent(LoginEvent.ONLINE_SERVER_SELECTED));
         }
         else
         {
            this.selectServer(param1 + 1);
         }
      }
      
      public function setServerListData(param1:Vector.<ServerInfo>) : void
      {
         var _loc4_:ServerInfo = null;
         var _loc2_:Vector.<ServerInfo> = Vector.<ServerInfo>([]);
         var _loc3_:int = 0;
         for each(_loc4_ in param1)
         {
            if(_loc4_.serverId <= 400)
            {
               if(_loc3_ < 2)
               {
                  _loc4_.isRecommendSvr = 1;
               }
               else
               {
                  _loc4_.isRecommendSvr = 0;
               }
               _loc3_++;
               _loc2_.push(_loc4_);
            }
         }
         this._serverInfoVec = _loc2_;
         this._totalPages = Math.ceil(this._serverInfoVec.length / VIEW_SIZE);
         if(this.orderMode)
         {
            this.order();
         }
         else
         {
            this.reverseOrder();
         }
      }
      
      private function reverseOrder() : void
      {
         this._pageIndex = this._totalPages;
         this.update();
      }
      
      public function order() : void
      {
         this._pageIndex = 1;
         this.update();
      }
      
      private function update() : void
      {
         var _loc2_:com.taomee.seer2.module.login.view.ServerListItem = null;
         var _loc3_:ServerInfo = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._currentPageItemVec.length)
         {
            _loc2_ = this._currentPageItemVec[_loc1_];
            if((this._pageIndex - 1) * VIEW_SIZE + _loc1_ >= this._serverInfoVec.length)
            {
               _loc2_.visible = false;
            }
            else
            {
               _loc3_ = this._serverInfoVec[(this._pageIndex - 1) * VIEW_SIZE + _loc1_];
               _loc2_.serverInfo = _loc3_;
               _loc2_.visible = true;
            }
            _loc1_++;
         }
      }
      
      public function turnToPrevPage() : void
      {
         --this._pageIndex;
         this.update();
      }
      
      public function turnToNextPage() : void
      {
         ++this._pageIndex;
         this.update();
      }
      
      public function get isLastPage() : Boolean
      {
         return this._pageIndex == this._totalPages;
      }
      
      public function get isFirstPage() : Boolean
      {
         return this._pageIndex == 1;
      }
      
      public function get pageIndex() : uint
      {
         return this._pageIndex;
      }
      
      public function get totalPages() : uint
      {
         return this._totalPages;
      }
      
      public function dispose() : void
      {
         this.clearItems();
         this._loginAgent = null;
         this._currentPageItemVec = null;
         this._domain = null;
      }
   }
}
