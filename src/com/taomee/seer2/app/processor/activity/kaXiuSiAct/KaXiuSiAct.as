package com.taomee.seer2.app.processor.activity.kaXiuSiAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class KaXiuSiAct
   {
      
      private static var _self:KaXiuSiAct;
      
      private static const LAST_EVENT_FOR:uint = 203130;
      
      private static const SEARCH_NUM_FOR:uint = 203131;
      
      private static const SEARCH_NUM_DAY:int = 800;
      
      private static const GIFT_GET_SWAP:int = 1783;
      
      private static const MI_NUM_BUY_ID:uint = 400195;
      
      private static const RANDOM_ID:int = 57;
      
      private static const BOSS_LIST:Vector.<int> = Vector.<int>([575,576]);
      
      private static const GOLD_CARD_LIST:Vector.<uint> = Vector.<uint>([400324,400325,400326,400327]);
      
      private static const TIP_PANEL_ITEM_TIPS:Vector.<String> = Vector.<String>(["2K经验芯片","时空包裹（小几率出极品资质）","性格重置秘药（价值2元）","神秘果实（使精灵获得经验，等级越高效果越大）"]);
      
      private static var _isLeave:Boolean;
       
      
      private var _map:MapModel;
      
      private var _resLib:ApplicationDomain;
      
      private var _menu:MovieClip;
      
      private var _leave:SimpleButton;
      
      private var _tipLink:SimpleButton;
      
      private var _tip:MovieClip;
      
      private var _tipCloseBtn:SimpleButton;
      
      private var _tipItemList:Vector.<MovieClip>;
      
      private var _forward:SimpleButton;
      
      private var _searchNum:TextField;
      
      private var _miNumBuy:SimpleButton;
      
      private var _forwardMC:MovieClip;
      
      private var _giftList:Vector.<MovieClip>;
      
      private var _searchNumVal:int;
      
      public function KaXiuSiAct()
      {
         super();
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         Connection.addCommandListener(CommandSet.ITEM_SERVER_GIVE_1051,this.onGetItem);
      }
      
      public static function getInstance() : KaXiuSiAct
      {
         if(_self == null)
         {
            _self = new KaXiuSiAct();
         }
         return _self;
      }
      
      public function setup(param1:MapModel) : void
      {
         this._map = param1;
         _isLeave = false;
         this.hideLobbyMenu();
         this.getURL();
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("kaXiuSiAct/KaXiuSiAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function showLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
      }
      
      private function init() : void
      {
         this.initSet();
         this.initEvent();
         this.update();
         this.show();
      }
      
      private function initSet() : void
      {
         this._menu = this.getMovie("Menu");
         this._leave = this._menu["leave"];
         this._tipLink = this._menu["tipLink"];
         this._tip = this._menu["tip"];
         this._tip.visible = false;
         this._tip.mouseEnabled = this._tip.mouseChildren = false;
         this._tipCloseBtn = this._tip["closeBtn"];
         this._tipItemList = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this._tipItemList.push(this._tip["tip" + _loc1_]);
            (this._tipItemList[_loc1_] as MovieClip).buttonMode = true;
            _loc1_++;
         }
         this._forward = this._menu["forward"];
         this._searchNum = this._menu["searchNum"];
         this._miNumBuy = this._menu["miNumBuy"];
         this._forwardMC = this.getMovie("ForwardMC");
      }
      
      private function initEvent() : void
      {
         this._tipLink.addEventListener(MouseEvent.CLICK,this.onTipShow);
         this._tipCloseBtn.addEventListener(MouseEvent.CLICK,this.onTipHide);
         var _loc1_:int = 0;
         while(_loc1_ < this._tipItemList.length)
         {
            TooltipManager.addCommonTip(this._tipItemList[_loc1_],TIP_PANEL_ITEM_TIPS[_loc1_]);
            _loc1_++;
         }
         this._miNumBuy.addEventListener(MouseEvent.CLICK,this.onMiNumBuy);
         this._forward.addEventListener(MouseEvent.CLICK,this.onForward);
         this._leave.addEventListener(MouseEvent.CLICK,this.onLeave);
      }
      
      private function onLeave(param1:MouseEvent) : void
      {
         _isLeave = true;
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function onForward(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(this.forwardFilter())
         {
            this._leave.mouseEnabled = this._forward.mouseEnabled = false;
            this._map.front.addChild(this._forwardMC);
            MovieClipUtil.playMc(this._forwardMC,2,this._forwardMC.totalFrames,function():void
            {
               _forwardMC.parent.removeChild(_forwardMC);
               Connection.send(CommandSet.RANDOM_EVENT_1140,RANDOM_ID,0);
            });
         }
      }
      
      private function forwardFilter() : Boolean
      {
         if(TimeManager.getAvailableTime() <= 0)
         {
            AlertManager.showAlert("电池已耗完,暂时不可前进,以防遇到对战不可进入战斗哦!");
            return false;
         }
         var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(_loc1_ != null)
         {
            if(_loc1_.hp == 0)
            {
               AlertManager.showAlert("首发精灵体力耗尽,暂时不可前进,以防遇到对战不可进入战斗哦!");
               return false;
            }
            return true;
         }
         AlertManager.showAlert("没有设置首发精灵,暂时不可前进,以防遇到对战不可进入战斗哦!");
         return false;
      }
      
      private function onGetItem(param1:MessageEvent) : void
      {
         var _loc5_:int = 0;
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         _loc2_.readUnsignedInt();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = int(_loc2_.readUnsignedInt());
            if(GOLD_CARD_LIST.indexOf(_loc5_) != -1)
            {
               ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventThreeActPanel"),"正在打开挑战卡修斯胜利提示面板...",{
                  "type":2,
                  "itemId":_loc5_
               });
               break;
            }
            _loc4_++;
         }
      }
      
      private function onEventTest(param1:int) : void
      {
         var id:int = param1;
         this.clearGiftList();
         if(id == 1)
         {
            ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventOneActPanel"),"正在打开遇到敌人面板...",{"type":1});
         }
         else if(id == 2)
         {
            ModuleManager.addEventListener("KaXiuSiEventTwoActPanel",ModuleEvent.DISPOSE,function(param1:ModuleEvent):void
            {
               addRandomGift();
            });
            ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventTwoActPanel"),"正在打开遇到悬浮物提示面板...");
         }
         else if(id == 3)
         {
            ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventThreeActPanel"),"正在打开获得卡牌面板...",{
               "type":1,
               "itemId":400318
            });
         }
         else if(id == 4)
         {
            ModuleManager.addEventListener("KaXiuSiEventFourActPanel",ModuleEvent.DISPOSE,this.onEventFourHide);
            ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventFourActPanel"),"正在打开天上掉馅饼面板...");
         }
         else if(id == 5)
         {
            ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventFiveActPanel"),"正在打开遇见卡修斯面板...");
         }
      }
      
      private function onEventFourHide(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("KaXiuSiEventFourActPanel",ModuleEvent.DISPOSE,this.onEventFourHide);
         this.update();
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var evt:MessageEvent = param1;
         var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
         if(parser.index == RANDOM_ID)
         {
            this.clearGiftList();
            if(parser.id == 1)
            {
               ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventOneActPanel"),"正在打开遇到敌人面板...",{"type":parser.count});
            }
            else if(parser.id == 2)
            {
               ModuleManager.addEventListener("KaXiuSiEventTwoActPanel",ModuleEvent.DISPOSE,function onTwoClose(param1:ModuleEvent):void
               {
                  ModuleManager.removeEventListener("KaXiuSiEventTwoActPanel",ModuleEvent.DISPOSE,onTwoClose);
                  addRandomGift();
               });
               ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventTwoActPanel"),"正在打开遇到悬浮物提示面板...");
            }
            else if(parser.id == 3)
            {
               ModuleManager.addEventListener("KaXiuSiEventThreeActPanel",ModuleEvent.DISPOSE,function onThreeClose(param1:ModuleEvent):void
               {
                  ModuleManager.removeEventListener("KaXiuSiEventThreeActPanel",ModuleEvent.DISPOSE,onThreeClose);
                  update();
               });
               ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventThreeActPanel"),"正在打开获得卡牌面板...",{
                  "type":1,
                  "itemId":parser.count
               });
            }
            else if(parser.id == 4)
            {
               ModuleManager.addEventListener("KaXiuSiEventFourActPanel",ModuleEvent.DISPOSE,function onFourClose(param1:ModuleEvent):void
               {
                  ModuleManager.removeEventListener("KaXiuSiEventFourActPanel",ModuleEvent.DISPOSE,onFourClose);
                  update();
               });
               ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventFourActPanel"),"正在打开天上掉馅饼面板...");
            }
            else if(parser.id == 5)
            {
               ModuleManager.showModule(URLUtil.getAppModule("KaXiuSiEventFiveActPanel"),"正在打开遇见卡修斯面板...");
            }
         }
         this._leave.mouseEnabled = this._forward.mouseEnabled = true;
      }
      
      private function addRandomGift() : void
      {
         var _loc1_:MovieClip = null;
         this.clearGiftList();
         this._menu.visible = false;
         this._giftList = new Vector.<MovieClip>();
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = this.getMovie("RandomGift");
            this._giftList.push(_loc1_);
            _loc1_.x = 215 + Math.random() * 700;
            _loc1_.y = 50 + Math.random() * 400;
            this._map.content.addChild(_loc1_);
            _loc1_.buttonMode = true;
            _loc1_.addEventListener(MouseEvent.CLICK,this.onGiftClick);
            _loc2_++;
         }
      }
      
      private function clearGiftList() : void
      {
         var _loc1_:int = 0;
         if(this._giftList)
         {
            _loc1_ = 0;
            while(_loc1_ < this._giftList.length)
            {
               this._giftList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onGiftClick);
               DisplayUtil.removeForParent(this._giftList[_loc1_]);
               _loc1_++;
            }
            this._giftList = null;
         }
      }
      
      private function onGiftClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var evt:MouseEvent = param1;
         this.setAllGiftMouseEnable(false);
         index = this._giftList.indexOf(evt.currentTarget as MovieClip);
         SwapManager.swapItem(GIFT_GET_SWAP,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            DisplayUtil.removeForParent(_giftList[index]);
            _giftList.splice(index,1);
            setAllGiftMouseEnable(true);
            if(_giftList.length == 0)
            {
               _menu.visible = true;
               update();
            }
         },function(param1:uint):void
         {
            DisplayUtil.removeForParent(_giftList[index]);
            _giftList.splice(index,1);
            setAllGiftMouseEnable(true);
            if(_giftList.length == 0)
            {
               _menu.visible = true;
               update();
            }
         });
      }
      
      private function setAllGiftMouseEnable(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._giftList.length)
         {
            this._giftList[_loc2_].mouseEnabled = this._giftList[_loc2_].mouseChildren = param1;
            _loc2_++;
         }
      }
      
      private function onMiNumBuy(param1:MouseEvent) : void
      {
         this._forward.mouseEnabled = false;
         ModuleManager.addEventListener("BuyPropPanel",ModuleEvent.DISPOSE,this.onBuyPanelHide);
         ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"),"正在打开米币小面板...",{
            "itemId":MI_NUM_BUY_ID,
            "canBatch":true,
            "isLimitNum":false,
            "buyType":"mi",
            "itemType":"hideShop"
         });
      }
      
      private function onBuyPanelHide(param1:ModuleEvent) : void
      {
         this._forward.mouseEnabled = true;
         ModuleManager.removeEventListener("BuyPropPanel",ModuleEvent.DISPOSE,this.onBuyPanelHide);
         this.update();
      }
      
      private function onTipShow(param1:MouseEvent) : void
      {
         this._tip.visible = true;
         this._tip.mouseEnabled = this._tip.mouseChildren = true;
         this._miNumBuy.mouseEnabled = this._forward.mouseEnabled = this._tipLink.mouseEnabled = false;
      }
      
      private function onTipHide(param1:MouseEvent) : void
      {
         this._tip.visible = false;
         this._tip.mouseEnabled = this._tip.mouseChildren = false;
         this._miNumBuy.mouseEnabled = this._tipLink.mouseEnabled = true;
         if(int(this._searchNum.text) > 0)
         {
            this._forward.mouseEnabled = true;
         }
         else
         {
            this._forward.mouseEnabled = false;
         }
      }
      
      private function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         this._forward.mouseEnabled = false;
         ActiveCountManager.requestActiveCount(SEARCH_NUM_FOR,function(param1:int, param2:int):void
         {
            var num1:int = 0;
            var type:int = param1;
            var val:int = param2;
            num1 = val;
            DayLimitManager.getDoCount(SEARCH_NUM_DAY,function(param1:int):void
            {
               var _loc2_:int = 0;
               if(VipManager.vipInfo.isVip())
               {
                  _loc2_ = 8 - param1;
               }
               else
               {
                  _loc2_ = 5 - param1;
               }
               _searchNumVal = num1 + _loc2_;
               if(_searchNumVal > 0)
               {
                  setBtnState(_forward,true);
               }
               else
               {
                  setBtnState(_forward,false);
               }
               _searchNum.text = _searchNumVal.toString();
               if(callBack != null)
               {
                  callBack();
               }
            });
         });
      }
      
      private function setBtnState(param1:SimpleButton, param2:Boolean) : void
      {
         if(param2)
         {
            param1.filters = [];
            param1.mouseEnabled = true;
         }
         else
         {
            ColorFilter.setGrayscale(param1);
            param1.mouseEnabled = false;
         }
      }
      
      private function show() : void
      {
         this._map.content.addChild(this._menu);
      }
      
      private function getMovie(param1:String) : MovieClip
      {
         if(this._resLib)
         {
            return DomainUtil.getMovieClip(param1,this._resLib);
         }
         return null;
      }
      
      public function dispose() : void
      {
         if(_isLeave)
         {
            Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
            Connection.removeCommandListener(CommandSet.ITEM_SERVER_GIVE_1051,this.onGetItem);
            _self = null;
         }
         if(this._tipLink)
         {
            this._tipLink.removeEventListener(MouseEvent.ROLL_OVER,this.onTipShow);
            this._tipLink.removeEventListener(MouseEvent.ROLL_OUT,this.onTipHide);
            DisplayUtil.removeForParent(this._tipLink);
            this._tipLink = null;
         }
         if(this._miNumBuy)
         {
            this._miNumBuy.removeEventListener(MouseEvent.CLICK,this.onMiNumBuy);
            DisplayUtil.removeForParent(this._miNumBuy);
            this._miNumBuy = null;
         }
         if(this._forward)
         {
            this._forward.removeEventListener(MouseEvent.CLICK,this.onForward);
            DisplayUtil.removeForParent(this._forward);
            this._forward = null;
         }
         if(this._leave)
         {
            this._leave.removeEventListener(MouseEvent.CLICK,this.onLeave);
            DisplayUtil.removeForParent(this._leave);
            this._leave = null;
         }
         if(this._menu)
         {
            DisplayUtil.removeForParent(this._menu);
            this._menu = null;
         }
         this._map = null;
         this._resLib = null;
         this._leave = null;
         this._tipLink = null;
         this._tip = null;
         this._forward = null;
         this._searchNum = null;
         this._miNumBuy = null;
         this.clearGiftList();
      }
   }
}
