package com.taomee.seer2.app.processor.map.diceThing
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.DiceMapThingConfig;
   import com.taomee.seer2.app.config.info.DiceMapTileInfo;
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.map.diceThing.box.BoxThing;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.app.processor.map.diceThing.fight.FightThing;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
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
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DomainUtil;
   
   public class DiceMapManager
   {
      
      private static var _instance:com.taomee.seer2.app.processor.map.diceThing.DiceMapManager;
       
      
      protected var tileXml:XML;
      
      private var tileVec:Vector.<DiceMapTileInfo>;
      
      private var diceMc:MovieClip;
      
      private var diceResult:int;
      
      private var scene:LobbyScene;
      
      private var _map:MapModel;
      
      private var roleMobile:PathMobile;
      
      private var roleMobileID:int;
      
      private var currentTileSeat:int = 0;
      
      private var maxSeat:int;
      
      private var totalSeat:int;
      
      private var freeCount:int;
      
      private var useCount:int;
      
      private var leftCount:int;
      
      private var isReverse:Boolean;
      
      private var currentThing:com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
      
      private var swapNpc:MovieClip;
      
      public function DiceMapManager(param1:instancs)
      {
         super();
      }
      
      public static function getInstance() : com.taomee.seer2.app.processor.map.diceThing.DiceMapManager
      {
         if(!_instance)
         {
            _instance = new com.taomee.seer2.app.processor.map.diceThing.DiceMapManager(new instancs());
         }
         return _instance;
      }
      
      public function dispose(param1:SceneEvent) : void
      {
         this.tileXml = null;
         this.tileVec = null;
         if(this.diceMc)
         {
            this.diceMc.removeEventListener(MouseEvent.CLICK,this.clickDice);
            this.diceMc = null;
         }
         if(this.swapNpc)
         {
            this.swapNpc.removeEventListener(MouseEvent.CLICK,this.toSwap);
         }
         this.roleMobile = null;
         if(Boolean(this.currentThing) && !(this.currentThing is FightThing))
         {
            this.currentThing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
            this.currentThing.dispose();
            this.currentThing = null;
         }
         ModuleManager.removeEventListener("DiceCompletePanel",ModuleEvent.DISPOSE,this.resetData);
         this.diceResult = 0;
         this.roleMobileID = 0;
         this.currentTileSeat = 0;
         this.maxSeat = 0;
         this.totalSeat = 0;
         this.freeCount = 0;
         this.useCount = 0;
         this.isReverse = false;
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
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.getLimitNum);
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,this.dispose);
      }
      
      public function setup(param1:MapModel) : void
      {
         this._map = param1;
         this.setEnvironment();
         if(ActorManager.actorInfo.vipInfo.isVip())
         {
            this.freeCount = 10;
         }
         else
         {
            this.freeCount = 5;
         }
         Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,this.getLimitNum);
         Connection.send(CommandSet.DAILY_LIMIT_1065,492);
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
      
      private function getLimitNum(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
         if(_loc2_.id == 492)
         {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.getLimitNum);
            this.useCount = _loc2_.count;
            this.createNew();
         }
      }
      
      private function createNew() : void
      {
         QueueLoader.load(URLUtil.getDiceMapData(this._map.id),LoadType.TEXT,this.onXmlLoaded);
      }
      
      private function onXmlLoaded(param1:ContentInfo) : void
      {
         this.tileXml = XML(param1.content);
         this.parseXml();
      }
      
      private function parseXml() : void
      {
         var _loc2_:XML = null;
         var _loc3_:DiceMapTileInfo = null;
         this.tileVec = new Vector.<DiceMapTileInfo>();
         this.roleMobileID = int(this.tileXml.@mobileId);
         var _loc1_:XMLList = this.tileXml.descendants("tile");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = new DiceMapTileInfo();
            _loc3_.seat = int(_loc2_.@seat);
            _loc3_.thingType = String(_loc2_.@tileType);
            _loc3_.thingId = String(_loc2_.@thingId);
            _loc3_.x = int(_loc2_.@x);
            _loc3_.y = int(_loc2_.@y);
            this.tileVec.push(_loc3_);
         }
         this.tileVec.sort(this.sortVec);
         this.maxSeat = this.tileVec.length - 1;
         this.initUI();
      }
      
      private function initUI() : void
      {
         this.diceMc = this._map.content["dice"];
         this.diceMc.gotoAndStop(1);
         this.diceMc.buttonMode = true;
         this.diceMc.mouseChildren = false;
         this.diceMc.addEventListener(MouseEvent.CLICK,this.clickDice);
         this.swapNpc = this._map.content["swapNpc"];
         this.swapNpc.buttonMode = true;
         this.swapNpc.addEventListener(MouseEvent.CLICK,this.toSwap);
         var _loc1_:TextField = this._map.content["countTxt"]["freeTxt"];
         _loc1_.text = "可免费抛" + (this.freeCount - this.useCount) + "次";
         if(!this.roleMobile)
         {
            this.initMobile();
         }
         this.requestItem();
      }
      
      private function requestItem() : void
      {
         ItemManager.requestItemList(this.getNum);
      }
      
      private function toSwap(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("DiceStarSwapPanel"));
         ModuleManager.addEventListener("DiceStarSwapPanel",ModuleEvent.DISPOSE,this.onDispose);
      }
      
      private function onDispose(param1:ModuleEvent) : void
      {
         ModuleManager.removeEventListener("DiceStarSwapPanel",ModuleEvent.DISPOSE,this.onDispose);
         this.requestItem();
      }
      
      private function onCount(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onCount);
         var _loc2_:int = this.freeCount - this.useCount;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(ItemManager.getSpecialItem(500516))
         {
            this.leftCount = _loc2_ + ItemManager.getSpecialItem(500516).quantity;
         }
         else
         {
            this.leftCount = _loc2_;
         }
         var _loc3_:TextField = this._map.content["countTxt"]["freeTxt"];
         _loc3_.text = "可免费抛" + this.leftCount + "次";
      }
      
      private function getNum() : void
      {
         var _loc1_:TextField = this._map.content["starNumTxt"];
         _loc1_.text = ItemManager.getItemQuantityByReferenceId(400136).toString();
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,this.onCount);
         ItemManager.requestSpecialItemList();
      }
      
      private function clickDice(param1:MouseEvent) : void
      {
         if(ActorManager.actorInfo.coins < 300 && this.leftCount == 0)
         {
            AlertManager.showAlert("赛尔豆不够了，去赚点豆子再来玩哦!!");
            return;
         }
         SwapManager.swapItem(594,1,this.dicePlay);
      }
      
      private function dicePlay(param1:IDataInput = null) : void
      {
         var swap:SwapInfo;
         var freeTxt:TextField;
         var data:IDataInput = param1;
         this.isReverse = false;
         swap = new SwapInfo(data,false);
         if(ActorManager.actorInfo.coins < 300)
         {
            AlertManager.showAlert("剩余赛尔豆不足!!");
            return;
         }
         --this.leftCount;
         ++this.useCount;
         freeTxt = this._map.content["countTxt"]["freeTxt"];
         if(this.leftCount < 0)
         {
            this.leftCount = 0;
            ServerMessager.addMessage("消耗300赛尔豆,抛一次骰子！");
         }
         freeTxt.text = "可免费抛" + this.leftCount.toString() + "次";
         this.diceResult = Math.random() * 6 + 1;
         this.diceMc.mouseEnabled = false;
         this.diceMc.buttonMode = false;
         MovieClipUtil.playMc(this.diceMc,"旋转","停止",function():void
         {
            var mc:MovieClip;
            var stopMc:MovieClip = diceMc.getChildAt(0) as MovieClip;
            stopMc.gotoAndStop(diceResult);
            mc = stopMc.getChildAt(0) as MovieClip;
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               totalSeat = currentTileSeat + diceResult;
               if(totalSeat > maxSeat)
               {
                  totalSeat = maxSeat;
               }
               moveSeat();
            });
         });
      }
      
      private function checkTileSeat() : void
      {
         if(this.currentTileSeat == this.maxSeat)
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_92);
            this.completeOneRound();
         }
         else
         {
            this.checkThing();
         }
      }
      
      private function checkThing() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:* = null;
         var _loc6_:DiceThingInfo = null;
         var _loc7_:String = null;
         var _loc8_:Class = null;
         var _loc9_:int = 0;
         var _loc1_:DiceMapTileInfo = this.tileVec[this.currentTileSeat];
         if(_loc1_.thingType != DiceThingType.EMPTY_THING)
         {
            _loc2_ = _loc1_.thingType + _loc1_.thingId;
            if(_loc1_.thingId == "random")
            {
               _loc9_ = int(Math.random() * this.tileVec[this.currentTileSeat].thingNum);
               _loc2_ = _loc1_.thingType + _loc9_;
            }
            _loc3_ = "com.taomee.seer2.app.processor.map.diceThing.";
            _loc4_ = _loc1_.thingType;
            if(_loc1_.thingType == DiceThingType.ADDMONEY_THING || _loc1_.thingType == DiceThingType.SUBMONEY_THING)
            {
               _loc4_ = "money";
            }
            _loc5_ = _loc4_ + ".";
            (_loc6_ = DiceMapThingConfig.thingMap.getValue(_loc2_) as DiceThingInfo).currentSeat = this.currentTileSeat;
            _loc7_ = _loc6_.className;
            _loc8_ = DomainUtil.getCurrentDomainClass(_loc3_ + _loc5_ + _loc7_);
            this.currentThing = new _loc8_(_loc6_);
            this.currentThing.addEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
            this.currentThing.setUpThing();
         }
         else
         {
            this.resetDice();
         }
      }
      
      private function thingOver(param1:DiceThingEvent) : void
      {
         if(this.currentThing is BoxThing)
         {
            ItemManager.requestItemList(this.getNum);
         }
         this.currentThing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
         this.currentThing.dispose();
         this.currentThing = null;
         if(param1.resultInfo.currentSeat != -1 && this.currentTileSeat != param1.resultInfo.currentSeat)
         {
            this.currentTileSeat = param1.resultInfo.currentSeat;
            this.totalSeat = this.currentTileSeat;
         }
         if(Boolean(param1.resultInfo) && param1.resultInfo.moveTile != 0)
         {
            if(param1.resultInfo.moveTile == 500)
            {
               this.resetData();
            }
            else
            {
               this.totalSeat = this.currentTileSeat + param1.resultInfo.moveTile;
               if(this.totalSeat > this.maxSeat)
               {
                  this.totalSeat = this.maxSeat;
               }
               else if(this.totalSeat < 0)
               {
                  this.totalSeat = 0;
               }
               this.isReverse = false;
               if(param1.resultInfo.moveTile < 0)
               {
                  this.isReverse = true;
               }
               this.moveSeat();
            }
         }
         else
         {
            this.resetDice();
         }
      }
      
      private function moveSeat() : void
      {
         if(this.isReverse)
         {
            --this.currentTileSeat;
         }
         else
         {
            ++this.currentTileSeat;
         }
         this.roleMobile.addEventListener(MoveEvent.FINISHED,this.moveFinished);
         if(this.roleMobileID != 0)
         {
            this.roleMobile.walkToLocation(this.tileVec[this.currentTileSeat].x,this.tileVec[this.currentTileSeat].y);
         }
         else
         {
            this.roleMobile.runToLocation(this.tileVec[this.currentTileSeat].x,this.tileVec[this.currentTileSeat].y);
         }
      }
      
      private function moveFinished(param1:MoveEvent) : void
      {
         this.roleMobile.removeEventListener(MoveEvent.FINISHED,this.moveFinished);
         if(this.currentTileSeat != this.totalSeat)
         {
            this.moveSeat();
         }
         else
         {
            this.checkTileSeat();
         }
      }
      
      private function completeOneRound() : void
      {
         this.requestReward();
      }
      
      private function requestReward() : void
      {
         Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,this.getLimit);
         Connection.send(CommandSet.DAILY_LIMIT_1065,494);
      }
      
      private function resetData(param1:ModuleEvent = null) : void
      {
         this.currentTileSeat = 0;
         this.totalSeat = 0;
         this.roleMobile.setPostion(new Point(this.tileVec[this.currentTileSeat].x,this.tileVec[this.currentTileSeat].y));
         this.resetDice();
      }
      
      private function getLimit(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.getLimit);
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawData());
         if(_loc2_.count < 1)
         {
            SwapManager.swapItem(613,1,this.onSwapSuccess);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("DiceCompletePanel"));
         }
         ModuleManager.addEventListener("DiceCompletePanel",ModuleEvent.DISPOSE,this.resetData);
      }
      
      private function onSwapSuccess(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1,false);
         ModuleManager.toggleModule(URLUtil.getAppModule("DiceCompletePanel"));
         var _loc3_:TextField = this._map.content["starNumTxt"];
         _loc3_.text = ItemManager.getItemQuantityByReferenceId(400136).toString();
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
      
      private function sortVec(param1:DiceMapTileInfo, param2:DiceMapTileInfo) : int
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
         if(this.roleMobile)
         {
            MobileManager.removeMobile(this.roleMobile,MobileType.PET);
            this.roleMobile = null;
         }
         if(this.roleMobileID != 0)
         {
            this.roleMobile = new PathMobile();
            this.roleMobile.resourceUrl = URLUtil.getPetSwf(this.roleMobileID);
            MobileManager.addMobile(this.roleMobile,MobileType.PET);
         }
         else
         {
            this.roleMobile = ActorManager.getActor();
            ActorManager.getActor().show();
            ActorManager.getActor().blockNoNo = true;
            ActorManager.getActor().blockFollowingPet = true;
         }
         this.roleMobile.setPostion(new Point(this.tileVec[this.currentTileSeat].x,this.tileVec[this.currentTileSeat].y));
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
