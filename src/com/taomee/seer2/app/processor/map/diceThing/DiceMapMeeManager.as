package com.taomee.seer2.app.processor.map.diceThing
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.DiceMapThingMeeConfig;
   import com.taomee.seer2.app.config.info.DiceMapTileInfo;
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.app.shopManager.ShopManager;
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
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import org.taomee.utils.DomainUtil;
   
   public class DiceMapMeeManager
   {
      
      private static var _instance:DiceMapMeeManager;
       
      
      private var _map:MapModel;
      
      private var scene:LobbyScene;
      
      private var diceMc:MovieClip;
      
      private var roleMobile:PathMobile;
      
      protected var tileXml:XML;
      
      private var tileVec:Vector.<DiceMapTileInfo>;
      
      private var currentThing:BaseDiceThing;
      
      private var roleMobileID:uint;
      
      private var normalCount:uint;
      
      private var vipCount:uint;
      
      private var seatInfoId:uint;
      
      private var freeCountId:uint;
      
      private var buyCountId:uint;
      
      private var buyId:uint;
      
      private var randomIndex:uint;
      
      private var freeCount:uint;
      
      private var itemId:uint;
      
      private var endSwapId:uint;
      
      private var diceResult:uint;
      
      private var useCount:uint;
      
      private var buyCount:uint;
      
      private var currentTileSeat:int = 0;
      
      private var maxSeat:int;
      
      private var totalSeat:int;
      
      private var leftCount:int;
      
      private var isReverse:Boolean;
      
      private var reqBuyCount:Boolean;
      
      private var needCheckThing:Boolean;
      
      private var buyBtn:SimpleButton;
      
      public function DiceMapMeeManager(param1:instancs)
      {
         super();
      }
      
      public static function getInstance() : DiceMapMeeManager
      {
         if(!_instance)
         {
            _instance = new DiceMapMeeManager(new instancs());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this._map = SceneManager.active.mapModel;
         this.setEnvironment();
         QueueLoader.load(URLUtil.getDiceMapData(this._map.id),LoadType.TEXT,this.onXmlLoaded);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,this.dispose);
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
         this.roleMobile = null;
         if(this.currentThing)
         {
            this.currentThing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
            this.currentThing.dispose();
            this.currentThing = null;
         }
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
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,this.dispose);
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
         this.vipCount = uint(this.tileXml.@vipCount);
         this.normalCount = uint(this.tileXml.@normalCount);
         this.seatInfoId = uint(this.tileXml.@seatInfoId);
         this.freeCountId = uint(this.tileXml.@freeCountId);
         this.buyCountId = uint(this.tileXml.@buyCountId);
         this.buyId = uint(this.tileXml.@buyId);
         this.randomIndex = uint(this.tileXml.@randomIndex);
         this.itemId = uint(this.tileXml.@itemId);
         this.endSwapId = uint(this.tileXml.@endSwapId);
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
         if(ActorManager.actorInfo.vipInfo.isVip())
         {
            this.freeCount = this.vipCount;
         }
         else
         {
            this.freeCount = this.normalCount;
         }
         this.reqData();
      }
      
      private function reqData() : void
      {
         ActiveCountManager.requestActiveCountList([this.seatInfoId,this.buyCountId],this.getCount);
      }
      
      private function getCount(param1:Parser_1142) : void
      {
         this.currentTileSeat = param1.infoVec[0];
         this.buyCount = param1.infoVec[1];
         ItemManager.requestItemList(this.getNum);
      }
      
      private function getNum() : void
      {
         DayLimitManager.getDoCount(this.freeCountId,this.getUseCount);
      }
      
      private function getUseCount(param1:uint) : void
      {
         this.useCount = param1;
         if(this.useCount > this.freeCount)
         {
            this.leftCount = this.buyCount;
         }
         else
         {
            this.leftCount = this.freeCount - this.useCount + this.buyCount;
         }
         this.initUI();
         if(this.currentTileSeat == this.maxSeat)
         {
            this.checkTileSeat();
         }
         if(this.needCheckThing)
         {
            this.checkThing();
         }
      }
      
      private function initUI() : void
      {
         this.diceMc = this._map.content["dice"];
         this.diceMc.gotoAndStop(1);
         this.diceMc.buttonMode = true;
         this.diceMc.mouseChildren = false;
         this.diceMc.addEventListener(MouseEvent.CLICK,this.clickDice);
         this.buyBtn = this._map.content["buyBtn"];
         this.buyBtn.addEventListener(MouseEvent.CLICK,this.buyCountHand);
         var _loc1_:TextField = this._map.content["itemNumTxt"];
         _loc1_.text = ItemManager.getItemQuantityByReferenceId(this.itemId).toString();
         var _loc2_:TextField = this._map.content["countTxt"]["freeTxt"];
         _loc2_.text = "还可以抛" + this.leftCount + "次";
         if(!this.roleMobile)
         {
            this.initMobile();
         }
      }
      
      protected function buyCountHand(param1:MouseEvent) : void
      {
         ShopManager.buyItemForId(this.buyId,this.updateNum);
      }
      
      private function updateNum(param1:*) : void
      {
         this.reqData();
      }
      
      private function clickDice(param1:MouseEvent) : void
      {
         if(this.leftCount == 0)
         {
            ShopManager.buyItemForId(this.buyId,this.buyCountComelete);
            return;
         }
         if(this.useCount < this.freeCount && ActorManager.actorInfo.coins < 500)
         {
            AlertManager.showAlert("赛尔豆不够了，去赚点豆子再来玩哦!!");
            return;
         }
         this.diceMc.mouseEnabled = false;
         this.buyCountComelete(null);
      }
      
      private function buyCountComelete(param1:*) : void
      {
         this.reqBuyCount = true;
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.getResult);
         Connection.send(CommandSet.RANDOM_EVENT_1140,this.randomIndex,0);
      }
      
      private function getResult(param1:MessageEvent) : void
      {
         var p:Parser_1140;
         var event:MessageEvent = param1;
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.getResult);
         p = new Parser_1140(event.message.getRawData());
         this.diceResult = p.id;
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
            if(this.isReverse)
            {
               this.isReverse = false;
            }
            this.checkTileSeat();
         }
      }
      
      private function checkTileSeat() : void
      {
         if(this.currentTileSeat == this.maxSeat)
         {
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_92);
            SwapManager.swapItem(this.endSwapId,1,this.onSwapSuccess);
         }
         else
         {
            this.reqData();
            this.needCheckThing = true;
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
         this.needCheckThing = false;
         var _loc1_:DiceMapTileInfo = this.tileVec[this.currentTileSeat];
         if(_loc1_.thingType != DiceThingType.EMPTY_THING)
         {
            _loc2_ = _loc1_.thingType + _loc1_.thingId;
            _loc3_ = "com.taomee.seer2.app.processor.map.diceThing.";
            _loc4_ = _loc1_.thingType;
            if(_loc1_.thingType == DiceThingType.ADDMONEY_THING || _loc1_.thingType == DiceThingType.SUBMONEY_THING)
            {
               _loc4_ = "money";
            }
            _loc5_ = _loc4_ + ".";
            (_loc6_ = DiceMapThingMeeConfig.thingMap.getValue(_loc2_) as DiceThingInfo).currentSeat = this.currentTileSeat;
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
         this.currentThing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
         this.currentThing.dispose();
         this.currentThing = null;
         this.diceMc.mouseEnabled = true;
         ItemManager.requestItemList(this.getNum1);
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
      
      private function getNum1() : void
      {
         var _loc1_:TextField = this._map.content["itemNumTxt"];
         _loc1_.text = ItemManager.getItemQuantityByReferenceId(this.itemId).toString();
      }
      
      private function onSwapSuccess(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         var _loc3_:TextField = this._map.content["itemNumTxt"];
         _loc3_.text = ItemManager.getItemQuantityByReferenceId(this.itemId).toString();
         this.resetData();
      }
      
      private function resetData() : void
      {
         this.currentTileSeat = 0;
         this.totalSeat = 0;
         this.roleMobile.setPostion(new Point(this.tileVec[this.currentTileSeat].x,this.tileVec[this.currentTileSeat].y));
         this.resetDice();
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
   }
}

class instancs
{
    
   
   public function instancs()
   {
      super();
   }
}
