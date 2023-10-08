package com.taomee.seer2.app.processor.map.diceThing
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.config.ShopPanelConfig;
   import com.taomee.seer2.app.config.info.DiceMapPterosaurTileInfo;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.PayManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DomainUtil;
   
   public class DiceMapPterosaurManager
   {
      
      private static var _instance:com.taomee.seer2.app.processor.map.diceThing.DiceMapPterosaurManager;
       
      
      protected var _tileXml:XML;
      
      private var _tileVec:Vector.<DiceMapPterosaurTileInfo>;
      
      private var diceMc:MovieClip;
      
      private var _swapBtn:SimpleButton;
      
      private var scene:LobbyScene;
      
      private var _map:MapModel;
      
      private var _roleMobile:PathMobile;
      
      private var roleMobileID:int;
      
      private var _currentTileSeat:int = 0;
      
      private var _maxSeat:int;
      
      private var _totalSeat:int;
      
      private var _numTxtList:Vector.<TextField>;
      
      private const FOR_ITEM:Array = [205017,205018,205019,205020,205021];
      
      private const FOR_SEAT:uint = 205022;
      
      private const FOR_COUNT:uint = 205015;
      
      private const DAY_COUNT:uint = 1432;
      
      private const SWAP_DICE:uint = 3355;
      
      private const SWAP_REWARD:Array = [3357,3358,3359,3360,3356];
      
      private const FIGHT_ID:uint = 1324;
      
      private const MI_DICE:uint = 605152;
      
      private const ITEM_NAME:Array = ["头部","翼部","后足","尾部","背部"];
      
      private const NEED_NUM:Array = [30,30,30,30,30];
      
      private var _numValueList:Vector.<uint>;
      
      private var _freeCount:int;
      
      private var _useCount:int;
      
      private var _leftCount:int = 0;
      
      private var vipCount:uint;
      
      private var normalCount:uint;
      
      private var OFFSET_TILES_X:uint;
      
      private var OFFSET_TILES_Y:uint;
      
      private var OFFSET_PLAYER_X:uint;
      
      private var OFFSET_PLAYER_Y:uint;
      
      private var _startX:int;
      
      private var _startY:int;
      
      private var _seatX:Vector.<int>;
      
      private var _seatY:Vector.<int>;
      
      public function DiceMapPterosaurManager(param1:instancs)
      {
         this._numValueList = new Vector.<uint>();
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.processor.map.diceThing.DiceMapPterosaurManager
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.processor.map.diceThing.DiceMapPterosaurManager(new instancs());
         }
         return _instance;
      }
      
      public function dispose(param1:SceneEvent) : void
      {
         this._tileXml = null;
         this._tileVec = null;
         this._seatX = null;
         this._seatY = null;
         if(this.diceMc)
         {
            this.diceMc.removeEventListener(MouseEvent.CLICK,this.clickDice);
            this.diceMc = null;
         }
         if(this._swapBtn)
         {
            this._swapBtn.removeEventListener(MouseEvent.CLICK,this.toSwap);
         }
         this._roleMobile = null;
         this.roleMobileID = 0;
         this._currentTileSeat = 0;
         this._maxSeat = 0;
         this._totalSeat = 0;
         this._freeCount = 0;
         this._useCount = 0;
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().show();
         if(this._map)
         {
            this._map.ground.mouseEnabled = true;
            this._map = null;
         }
         if(this.scene)
         {
            this.scene.showToolbar();
            this.scene = null;
         }
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,this.dispose);
      }
      
      public function setup() : void
      {
         this._map = SceneManager.active.mapModel;
         this.setEnvironment();
         QueueLoader.load(URLUtil.getDiceMapData(this._map.id),LoadType.TEXT,this.onXmlLoaded);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,this.dispose);
      }
      
      private function setEnvironment() : void
      {
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         this._map.ground.mouseEnabled = false;
         ActorManager.showRemoteActor = false;
         this.scene = SceneManager.active as LobbyScene;
         this.scene.hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function onXmlLoaded(param1:ContentInfo) : void
      {
         this._tileXml = XML(param1.content);
         this.parseXml();
      }
      
      private function parseXml() : void
      {
         var _loc2_:XML = null;
         var _loc3_:DiceMapPterosaurTileInfo = null;
         this._tileVec = new Vector.<DiceMapPterosaurTileInfo>();
         this.roleMobileID = int(this._tileXml.@mobileId);
         this.vipCount = uint(this._tileXml.@vipCount);
         this.normalCount = uint(this._tileXml.@normalCount);
         this._startX = int(this._tileXml.@x);
         this._startY = int(this._tileXml.@y);
         this.OFFSET_TILES_X = int(this._tileXml.@offTilesX);
         this.OFFSET_TILES_Y = int(this._tileXml.@offTilesY);
         this.OFFSET_PLAYER_X = int(this._tileXml.@offPlayerX);
         this.OFFSET_PLAYER_Y = int(this._tileXml.@offPlayerY);
         var _loc1_:XMLList = this._tileXml.descendants("tile");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = new DiceMapPterosaurTileInfo();
            _loc3_.seat = int(_loc2_.@seat);
            _loc3_.thingType = String(_loc2_.@tileType);
            _loc3_.before = int(_loc2_.@before);
            this._tileVec.push(_loc3_);
         }
         this._tileVec.sort(this.sortVec);
         this._maxSeat = this._tileVec.length;
         if(ActorManager.actorInfo.vipInfo.isVip())
         {
            this._freeCount = this.vipCount;
         }
         else
         {
            this._freeCount = this.normalCount;
         }
         QueueLoader.load(URLUtil.getDiceMapTiles("pterosaur.swf"),LoadType.SWF,this.onTilesLoaded);
      }
      
      private function onTilesLoaded(param1:ContentInfo) : void
      {
         var _loc3_:Class = null;
         var _loc6_:MovieClip = null;
         var _loc2_:ApplicationDomain = param1.domain;
         var _loc4_:uint = this._map.ground.numChildren - 1;
         this._seatX = new Vector.<int>();
         this._seatY = new Vector.<int>();
         var _loc5_:int = 0;
         while(_loc5_ < this._maxSeat)
         {
            _loc3_ = DomainUtil.getClass(this._tileVec[_loc5_].thingType,_loc2_);
            _loc6_ = new _loc3_();
            if(_loc5_ == 0)
            {
               _loc6_.x = this._startX - this.OFFSET_PLAYER_X;
               _loc6_.y = this._startY - this.OFFSET_PLAYER_Y;
            }
            else
            {
               _loc6_.x = this._seatX[_loc5_ - 1] + this.OFFSET_TILES_X * (-int((this._tileVec[_loc5_].before - 1) / 2) * 2 + 1);
               _loc6_.y = this._seatY[_loc5_ - 1] + this.OFFSET_TILES_Y * (2 - Math.abs(this._tileVec[_loc5_].before - 2.5) * 2);
            }
            this._seatX.push(_loc6_.x);
            this._seatY.push(_loc6_.y);
            if(this._tileVec[_loc5_].before == 2 || this._tileVec[_loc5_].before == 3)
            {
               _loc4_ = this._map.ground.numChildren - 1;
            }
            this._map.ground.addChildAt(_loc6_,_loc4_);
            _loc5_++;
         }
         this.initUI();
      }
      
      private function initUI() : void
      {
         this.diceMc = this._map.content["dice"];
         this.diceMc.gotoAndStop(1);
         this.diceMc.buttonMode = true;
         this.diceMc.mouseChildren = false;
         this.diceMc.addEventListener(MouseEvent.CLICK,this.clickDice);
         this._numTxtList = new Vector.<TextField>();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._numTxtList.push(this._map.content["txtParts" + _loc1_]);
            _loc1_++;
         }
         this._swapBtn = this._map.content["swapNpc"];
         this._swapBtn.addEventListener(MouseEvent.CLICK,this.toSwap);
         if(!this._roleMobile)
         {
            this.initMobile();
         }
         this.getPartsNum();
         this.getLeftCount();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onFightComplete);
      }
      
      private function toSwap(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("PterosaurPanel");
         ModuleManager.addEventListener("PterosaurPanel",ModuleEvent.HIDE,this.onHide);
      }
      
      private function onHide(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("PterosaurPanel",ModuleEvent.HIDE,this.onHide);
         this.getPartsNum();
      }
      
      private function getPartsNum(param1:Boolean = false, param2:String = "") : void
      {
         var needTip:Boolean = param1;
         var tipTxt:String = param2;
         ActiveCountManager.requestActiveCountList(this.FOR_ITEM,function(param1:Parser_1142):void
         {
            var _loc2_:String = null;
            var _loc3_:uint = 0;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            updateDis(param1.infoVec);
            if(needTip)
            {
               _loc2_ = "";
               _loc3_ = 0;
               _loc5_ = 0;
               while(_loc5_ < 5)
               {
                  if((_loc6_ = param1.infoVec[_loc5_] - _numValueList[_loc5_]) > 0)
                  {
                     _loc2_ += " " + ITEM_NAME[_loc5_] + "零件+" + _loc6_ + ",";
                     _loc3_ += _loc5_ + 1;
                     _loc4_ = _loc6_;
                  }
                  else if(_loc6_ < 0)
                  {
                     _loc2_ += " " + ITEM_NAME[_loc5_] + "零件" + _loc6_ + ",";
                     _loc3_ += _loc5_ + 1;
                     _loc4_ = _loc6_;
                  }
                  _loc5_++;
               }
               if(_loc2_ != "")
               {
                  ModuleManager.showAppModule("PterosaurGameTipsPanel",{
                     "item":_loc3_,
                     "num":_loc4_
                  });
               }
            }
            _numValueList = param1.infoVec;
         });
      }
      
      private function updateDis(param1:Vector.<uint>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            this._numTxtList[_loc2_].text = param1[_loc2_].toString() + "/" + this.NEED_NUM[_loc2_];
            _loc2_++;
         }
      }
      
      private function getLeftCount() : void
      {
         DayLimitManager.getDoCount(this.DAY_COUNT,function(param1:uint):void
         {
            var c:uint = param1;
            _useCount = c;
            ActiveCountManager.requestActiveCount(FOR_COUNT,function(param1:uint, param2:uint):void
            {
               _leftCount = ActsHelperUtil.getCanNum(_useCount,param2,_freeCount);
               setLeftCountText();
            });
         });
      }
      
      private function setLeftCountText() : void
      {
         var _loc1_:TextField = this._map.content["countTxt"]["leftTxt"];
         _loc1_.text = "还可以抛" + this._leftCount + "次";
      }
      
      private function clickDice(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.diceMc.mouseEnabled = false;
         if(ActorManager.actorInfo.coins < 300 && this._useCount < this._freeCount)
         {
            AlertManager.showAlert("赛尔豆不够啦，去赚一点再来吧~");
            this.diceMc.mouseEnabled = true;
            return;
         }
         if(this._leftCount <= 0)
         {
            AlertManager.showConfirm("你没有可以用的骰子了\n是否花费" + ShopPanelConfig.getItemPrice(this.MI_DICE) + "星钻买一个?",function():void
            {
               PayManager.buyItem(MI_DICE,function():void
               {
                  getLeftCount();
                  SwapManager.swapItem(SWAP_DICE,1,dicePlay);
               },function():void
               {
                  diceMc.mouseEnabled = true;
               });
            },function():void
            {
               diceMc.mouseEnabled = true;
            });
         }
         else
         {
            SwapManager.swapItem(this.SWAP_DICE,1,this.dicePlay);
         }
      }
      
      private function dicePlay(param1:IDataInput = null) : void
      {
         var diceResult:int = 0;
         var data:IDataInput = param1;
         new SwapInfo(data,false);
         --this._leftCount;
         this.setLeftCountText();
         if(this._useCount < this._freeCount)
         {
            ServerMessager.addMessage("消耗300赛尔豆,抛一次骰子！");
         }
         this.diceMc.mouseEnabled = false;
         this.diceMc.buttonMode = false;
         MovieClipUtil.playMc(this.diceMc,"旋转","停止",function():void
         {
            ActiveCountManager.requestActiveCount(FOR_SEAT,function(param1:uint, param2:uint):void
            {
               var stopMc:MovieClip;
               var mc:MovieClip;
               var type:uint = param1;
               var c:uint = param2;
               _totalSeat = c % _maxSeat;
               diceResult = _totalSeat - _currentTileSeat;
               if(_totalSeat < _currentTileSeat)
               {
                  diceResult += _maxSeat;
               }
               stopMc = diceMc.getChildAt(0) as MovieClip;
               stopMc.gotoAndStop(diceResult);
               mc = stopMc.getChildAt(0) as MovieClip;
               MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
               {
                  moveSeat();
               });
            });
         });
      }
      
      private function moveSeat() : void
      {
         ++this._currentTileSeat;
         if(this._currentTileSeat >= this._maxSeat)
         {
            this._currentTileSeat -= this._maxSeat;
         }
         this._roleMobile.addEventListener(MoveEvent.FINISHED,this.moveFinished);
         if(this.roleMobileID != 0)
         {
            this._roleMobile.walkToLocation(this._seatX[this._currentTileSeat] + this.OFFSET_PLAYER_X,this._seatY[this._currentTileSeat] + this.OFFSET_PLAYER_Y);
         }
         else
         {
            this._roleMobile.runToLocation(this._seatX[this._currentTileSeat] + this.OFFSET_PLAYER_X,this._seatY[this._currentTileSeat] + this.OFFSET_PLAYER_Y);
         }
      }
      
      private function moveFinished(param1:MoveEvent) : void
      {
         this._roleMobile.removeEventListener(MoveEvent.FINISHED,this.moveFinished);
         if(this._currentTileSeat != this._totalSeat)
         {
            this.moveSeat();
         }
         else
         {
            this.checkThing();
         }
      }
      
      private function checkThing() : void
      {
         var thingIndex:int = -1;
         switch(this._tileVec[this._currentTileSeat].thingType)
         {
            case "fight":
               FightManager.startFightWithBoss(this.FIGHT_ID);
               break;
            case "game":
               this.startGame();
               break;
            case "getFive":
               thingIndex = 0;
               break;
            case "getOrLose":
               thingIndex = 1;
               break;
            case "losePart":
               thingIndex = 2;
               break;
            case "getpart1":
            case "getpart2":
            case "getpart3":
            case "getpart4":
            case "getpart5":
               thingIndex = 3;
               break;
            case "getTen":
               thingIndex = 4;
         }
         if(thingIndex > -1)
         {
            SwapManager.swapItem(this.SWAP_REWARD[thingIndex],1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               getPartsNum(true);
            });
         }
         this.resetDice();
      }
      
      private function startGame() : void
      {
         ModuleManager.addEventListener("PterosaurGamePanel",ModuleEvent.DISPOSE,this.onGameOver);
         ModuleManager.showAppModule("PterosaurGamePanel");
      }
      
      private function onGameOver(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("PterosaurGamePanel",ModuleEvent.DISPOSE,this.onGameOver);
         this.getPartsNum(true,"小游戏结束，");
      }
      
      private function onFightComplete(param1:SceneEvent) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               this.getPartsNum(true,"战斗胜利，");
            }
            else
            {
               this.getPartsNum(true,"战斗失败，");
            }
         }
      }
      
      private function resetDice() : void
      {
         if(this.diceMc)
         {
            this.diceMc.mouseEnabled = true;
            this.diceMc.buttonMode = true;
            LayerManager.resetOperation();
         }
      }
      
      private function sortVec(param1:DiceMapPterosaurTileInfo, param2:DiceMapPterosaurTileInfo) : int
      {
         if(param1.seat > param2.seat)
         {
            return 1;
         }
         if(param1.seat < param2.seat)
         {
            return -1;
         }
         return 0;
      }
      
      private function initMobile() : void
      {
         if(this._roleMobile)
         {
            MobileManager.removeMobile(this._roleMobile,MobileType.PET);
            this._roleMobile = null;
         }
         if(this.roleMobileID != 0)
         {
            this._roleMobile = new PathMobile();
            this._roleMobile.resourceUrl = URLUtil.getPetSwf(this.roleMobileID);
            MobileManager.addMobile(this._roleMobile,MobileType.PET);
         }
         else
         {
            this._roleMobile = ActorManager.getActor();
            ActorManager.getActor().show();
            ActorManager.getActor().blockNoNo = true;
            ActorManager.getActor().blockFollowingPet = true;
         }
         ActiveCountManager.requestActiveCount(this.FOR_SEAT,function(param1:uint, param2:uint):void
         {
            _currentTileSeat = param2 % _maxSeat;
            _roleMobile.setPostion(new Point(_seatX[_currentTileSeat] + OFFSET_PLAYER_X,_seatY[_currentTileSeat] + OFFSET_PLAYER_Y));
         });
      }
   }
}

class instancs
{
    
   
   public function instancs()
   {
      super();
   }
}
