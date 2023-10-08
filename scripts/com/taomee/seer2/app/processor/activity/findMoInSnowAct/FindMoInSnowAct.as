package com.taomee.seer2.app.processor.activity.findMoInSnowAct
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.MineManger;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.activity.findMoInSnowAct.actList.StopActEvent;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
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
   
   public class FindMoInSnowAct
   {
      
      private static var _self:com.taomee.seer2.app.processor.activity.findMoInSnowAct.FindMoInSnowAct;
      
      private static const SEARCH_NUM_FOR:uint = 203497;
      
      private static const FIND_MAP_NUM_FOR:uint = 203498;
      
      private static const SEARCH_NUM_DAY:int = 901;
      
      private static const GIFT_GET_MINE:int = 269;
      
      private static const USE_SWAP:int = 2217;
      
      private static const MI_NUM_BUY_ID:uint = 400386;
      
      private static const RANDOM_ID:int = 73;
      
      private static const FIND_NUM_RULE:Vector.<int> = Vector.<int>([5,8]);
      
      private static var _isLeave:Boolean;
       
      
      private var _map:MapModel;
      
      private var _resLib:ApplicationDomain;
      
      private var _menu:MovieClip;
      
      private var _leave:SimpleButton;
      
      private var _findState:MovieClip;
      
      private var _forward:SimpleButton;
      
      private var _searchNum:TextField;
      
      private var _miNumBuy:SimpleButton;
      
      private var _forwardMC:MovieClip;
      
      private var _giftList:Vector.<MovieClip>;
      
      public function FindMoInSnowAct()
      {
         super();
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
      }
      
      public static function getInstance() : com.taomee.seer2.app.processor.activity.findMoInSnowAct.FindMoInSnowAct
      {
         if(_self == null)
         {
            _self = new com.taomee.seer2.app.processor.activity.findMoInSnowAct.FindMoInSnowAct();
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
         QueueLoader.load(URLUtil.getActivityAnimation("findMoInSnowAct/FindMoInSnowAct"),LoadType.SWF,function(param1:ContentInfo):void
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
         this._findState = this._menu["findState"];
         this._findState.buttonMode = true;
         this._forward = this._menu["forward"];
         this._searchNum = this._menu["searchNum"];
         this._miNumBuy = this._menu["miNumBuy"];
         this._forwardMC = this.getMovie("ForwardMC");
      }
      
      private function initEvent() : void
      {
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
      
      private function onEventTest(param1:int) : void
      {
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var sceneMC:MovieClip = null;
         var sceneMcNameList:Array = null;
         var evt:MessageEvent = param1;
         var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
         this.update();
         if(parser.index == RANDOM_ID)
         {
            this.clearGiftList();
            if(parser.id == 1)
            {
               ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowEventOneActPanel"),"正在打开雪兽出没挑战面板...",{"type":this.getRandom(1,4)});
            }
            else if(parser.id == 2)
            {
               this._menu.visible = false;
               sceneMC = this.getMovie("SceneMC_0");
               this._map.front.addChild(sceneMC);
               MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMC);
                  sceneMC = null;
                  ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowEventTwoActPanel"),"正在打开小动物冰冻小游戏面板...",{"func":function(param1:Boolean):void
                  {
                     var isFinish:Boolean = param1;
                     if(isFinish)
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("findMoInSnowAct/FindMoInSnowAct1"),function():void
                        {
                           SwapManager.swapItem(USE_SWAP,1,function(param1:IDataInput):void
                           {
                              new SwapInfo(param1);
                              _menu.visible = true;
                           },null,new SpecialInfo(1,1));
                        },true,true,2,true);
                     }
                     else
                     {
                        sceneMC = getMovie("SceneMC_1");
                        _map.front.addChild(sceneMC);
                        MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
                        {
                           DisplayUtil.removeForParent(sceneMC);
                           sceneMC = null;
                           _menu.visible = true;
                        },true);
                     }
                  }});
               },true);
            }
            else if(parser.id == 3)
            {
               ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowEventThreeActPanel"),"正在打开氏族族人卖货郎面板...");
            }
            else if(parser.id == 4)
            {
               this._menu.visible = false;
               sceneMC = this.getMovie("SceneMC_2");
               this._map.front.addChild(sceneMC);
               MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMC);
                  sceneMC = null;
                  ModuleManager.addEventListener("FindMoInSnowEventFourActPanel",ModuleEvent.DISPOSE,function(param1:ModuleEvent):void
                  {
                     _menu.visible = true;
                  });
                  ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowEventFourActPanel"),"正在打开送迷路的小绿回家面板...");
               },true);
            }
            else if(parser.id == 5)
            {
               this._menu.visible = false;
               sceneMC = this.getMovie("SceneMC_3");
               this._map.front.addChild(sceneMC);
               MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMC);
                  sceneMC = null;
                  new StopActEvent(15,function():void
                  {
                     _menu.visible = true;
                     ServerMessager.addMessage("好了！你可以继续前进了！");
                  });
               },true);
            }
            else if(parser.id == 6)
            {
               sceneMC = this.getMovie("SceneMC_4");
               this._map.front.addChild(sceneMC);
               MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(sceneMC);
                  sceneMC = null;
                  ModuleManager.addEventListener("FindMoInSnowEventSixActPanel",ModuleEvent.DISPOSE,function(param1:ModuleEvent):void
                  {
                     addRandomGift();
                  });
                  ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowEventSixActPanel"),"正在打开遇到悬浮物提示面板...");
               },true);
            }
            else if(parser.id == 7)
            {
               sceneMcNameList = ["SceneMC_5","SceneMC_6","SceneMC_7","SceneMC_8"];
               ActiveCountManager.requestActiveCount(FIND_MAP_NUM_FOR,function(param1:uint, param2:uint):void
               {
                  var type:uint = param1;
                  var val:uint = param2;
                  if(FIND_MAP_NUM_FOR == type)
                  {
                     sceneMC = getMovie(sceneMcNameList[val - 1]);
                     _map.front.addChild(sceneMC);
                     MovieClipUtil.playMc(sceneMC,2,sceneMC.totalFrames,function():void
                     {
                        DisplayUtil.removeForParent(sceneMC);
                        sceneMC = null;
                        ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowMeetBossActPanel"),"正在打开遇到boss挑战事件提示面板...",{"type":val});
                     },true);
                  }
               });
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
      
      private function getRandom(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = param1 + int(Math.random() * (param2 - param1) + 0.5);
         if(_loc3_ > param2)
         {
            _loc3_ = param2;
         }
         return _loc3_;
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
         index = this._giftList.indexOf(evt.currentTarget);
         MineManger.getMineItem(GIFT_GET_MINE,function(param1:Parser_1060):void
         {
            param1.showResult();
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
      
      private function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         this._forward.mouseEnabled = false;
         DayLimitManager.getDoCount(SEARCH_NUM_DAY,function(param1:int):void
         {
            var val:int = param1;
            ActiveCountManager.requestActiveCount(SEARCH_NUM_FOR,function(param1:uint, param2:uint):void
            {
               var _loc3_:int = 0;
               if(param1 == SEARCH_NUM_FOR)
               {
                  if(VipManager.vipInfo.isVip())
                  {
                     if(val > FIND_NUM_RULE[1])
                     {
                        _loc3_ = int(param2);
                     }
                     else
                     {
                        _loc3_ = FIND_NUM_RULE[1] - val + param2;
                     }
                  }
                  else if(val > FIND_NUM_RULE[0])
                  {
                     _loc3_ = int(param2);
                  }
                  else
                  {
                     _loc3_ = FIND_NUM_RULE[0] - val + param2;
                  }
                  if(_loc3_ > 0)
                  {
                     setBtnState(_forward,true);
                  }
                  else
                  {
                     setBtnState(_forward,false);
                  }
                  _searchNum.text = _loc3_.toString();
                  findStateHandle();
                  if(callBack != null)
                  {
                     callBack();
                  }
               }
            });
         });
      }
      
      private function findStateHandle() : void
      {
         ActiveCountManager.requestActiveCount(FIND_MAP_NUM_FOR,function(param1:uint, param2:uint):void
         {
            if(FIND_MAP_NUM_FOR == param1)
            {
               if(param2 + 1 > 4)
               {
                  param2 = 4;
               }
               else
               {
                  param2 += 1;
               }
               _findState.gotoAndStop(param2);
            }
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
            _self = null;
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
         this._forward = null;
         this._searchNum = null;
         this._miNumBuy = null;
         this.clearGiftList();
      }
   }
}
