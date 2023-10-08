package com.taomee.seer2.app.processor.map.diceThing
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.DiceMapThingConfig;
   import com.taomee.seer2.app.config.info.DiceThingInfo;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.IDataInput;
   import flash.utils.Timer;
   import org.taomee.utils.DomainUtil;
   
   public class DiceMap10372Manager
   {
      
      private static var _ins:com.taomee.seer2.app.processor.map.diceThing.DiceMap10372Manager;
       
      
      private var dayLimit:Array;
      
      private var forever:Array;
      
      private var swap_id:Array;
      
      private var fight_id:Array;
      
      private var initBoo:Boolean;
      
      private var _map:MapModel;
      
      private var _curScene:LobbyScene;
      
      private var _tileArr:Array;
      
      private var _diceMc:MovieClip;
      
      private var _diceResult:int;
      
      private var _swapBtn:SimpleButton;
      
      private var _getBtn:SimpleButton;
      
      private var _mark:MovieClip;
      
      private var _remainFd:TextField;
      
      private var _scoreFd:TextField;
      
      private var _roleMobile:PathMobile;
      
      private var _roleMobileID:int;
      
      private var _curPt:int = 0;
      
      private var currentThing:com.taomee.seer2.app.processor.map.diceThing.BaseDiceThing;
      
      private var _curGameIndex:int;
      
      private var score:int;
      
      private var _tm:Timer;
      
      private var _startPt:int = 0;
      
      public function DiceMap10372Manager()
      {
         this.dayLimit = [1313,1314,1315];
         this.forever = [204670,204671,204672];
         this.swap_id = [3126,3128,3127,3135,3136];
         this.fight_id = [1201,1202,1203];
         super();
      }
      
      public static function get ins() : com.taomee.seer2.app.processor.map.diceThing.DiceMap10372Manager
      {
         if(_ins == null)
         {
            _ins = new com.taomee.seer2.app.processor.map.diceThing.DiceMap10372Manager();
         }
         return _ins;
      }
      
      public function setup() : void
      {
         this._map = SceneManager.active.mapModel;
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         this._map.ground.mouseEnabled = false;
         ActorManager.showRemoteActor = false;
         this._curScene = SceneManager.active as LobbyScene;
         this._curScene.hideToolbar();
         PetAvatarPanel.show();
         if(this.initBoo == false)
         {
            this.initBoo = true;
            QueueLoader.load(URLUtil.getDiceMapData(this._map.id),LoadType.TEXT,this.onXmlLoaded);
            this._tm = new Timer(30);
            this._tm.addEventListener(TimerEvent.TIMER,this.run);
         }
         if(this._roleMobile == null)
         {
            this.initMobile();
         }
         else
         {
            ActorManager.getActor().show();
            ActorManager.getActor().blockNoNo = true;
            ActorManager.getActor().blockFollowingPet = true;
         }
         this._diceMc = this._map.content["dice"];
         this._swapBtn = this._map.content["swapNpc"];
         this._getBtn = this._map.content["getBtn"];
         this._mark = this._map.content["marks"];
         this._remainFd = this._map.content["numFd"];
         this._scoreFd = this._map.content["scoreFd"];
         this._mark.width = 1;
         this._map.content["bar"].mask = this._mark;
         this._diceMc.gotoAndStop(1);
         this._diceMc.buttonMode = true;
         this._diceMc.mouseChildren = false;
         this._diceMc.addEventListener(MouseEvent.CLICK,this.onDice);
         this._swapBtn.addEventListener(MouseEvent.CLICK,this.onDice);
         this._getBtn.addEventListener(MouseEvent.CLICK,this.onDice);
         this.update(function():void
         {
            var _loc1_:int = _curPt % _tileArr.length;
            _roleMobile.setPostion(new Point(_tileArr[_loc1_].x,_tileArr[_loc1_].y));
         });
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onComplete);
      }
      
      private function onDice(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         switch(evt.currentTarget)
         {
            case this._diceMc:
               if(int(this._remainFd.text) > 0)
               {
                  this.moveNum();
               }
               else
               {
                  ShopManager.buyItemForId(604162,function():void
                  {
                     moveNum();
                  });
               }
               break;
            case this._swapBtn:
               ModuleManager.showAppModule("XiaNaSwapPanel",{"fun":this.closeFun});
               break;
            case this._getBtn:
               SwapManager.swapItem(this.swap_id[3],1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  update();
               });
         }
      }
      
      private function closeFun() : void
      {
         this.update();
      }
      
      private function circleFun() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.lineStyle(2,16777215);
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawCircle(0,0,2);
         _loc1_.graphics.endFill();
         this._map.content.addChild(_loc1_);
         return _loc1_;
      }
      
      private function moveNum() : void
      {
         this._diceMc.mouseEnabled = false;
         SwapManager.swapItem(this.swap_id[0],1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            _startPt = _curPt;
            update(function():void
            {
               _diceMc.gotoAndPlay(9);
               _tm.start();
            });
         });
      }
      
      private function onXmlLoaded(param1:ContentInfo) : void
      {
         var _loc4_:XML = null;
         var _loc5_:Object = null;
         var _loc2_:XML = XML(param1.content);
         var _loc3_:XMLList = _loc2_.tile;
         this._tileArr = [];
         for each(_loc4_ in _loc3_)
         {
            (_loc5_ = {}).seat = int(_loc4_.@seat);
            _loc5_.thingType = String(_loc4_.@tileType);
            _loc5_.x = int(_loc4_.@x);
            _loc5_.y = String(_loc4_.@y);
            this._tileArr.push(_loc5_);
         }
         this._tileArr.sortOn("seat",Array.NUMERIC);
      }
      
      private function onCheckThing() : void
      {
         var num:int = this._curPt % this._tileArr.length;
         var obj:Object = this._tileArr[num];
         SwapManager.swapItem(this.swap_id[1],1,function(param1:IDataInput):void
         {
            var lastScore:int = 0;
            var data:IDataInput = param1;
            new SwapInfo(data);
            lastScore = score;
            DayLimitManager.getDoCount(dayLimit[1],function(param1:int):void
            {
               var parentPath:String = null;
               var packagePath:String = null;
               var thingKey:String = null;
               var thingInfo:DiceThingInfo = null;
               var className:String = null;
               var classThing:Class = null;
               var val:int = param1;
               update();
               switch(val)
               {
                  case 101:
                  case 102:
                     _curGameIndex = val;
                     parentPath = "com.taomee.seer2.app.processor.map.diceThing.";
                     packagePath = DiceThingType.CHANCE_THING + ".";
                     thingKey = val == 101 ? "chance1" : "chance0";
                     thingInfo = DiceMapThingConfig.thingMap.getValue(thingKey) as DiceThingInfo;
                     className = thingInfo.className;
                     classThing = DomainUtil.getCurrentDomainClass(parentPath + packagePath + className);
                     currentThing = new classThing(thingInfo);
                     currentThing.addEventListener(DiceThingEvent.DICE_THING_OVER,thingOver);
                     currentThing.setUpThing();
                     break;
                  case 201:
                     FightManager.startFightWithWild(fight_id[0]);
                     break;
                  case 202:
                     FightManager.startFightWithWild(fight_id[1]);
                     break;
                  case 203:
                     FightManager.startFightWithWild(fight_id[2]);
                     break;
                  default:
                     _diceMc.mouseEnabled = true;
               }
               update(function():void
               {
                  if(score > lastScore)
                  {
                     ServerMessager.addMessage("亲密度：+" + (score - lastScore));
                  }
                  else if(score < lastScore)
                  {
                     ServerMessager.addMessage("亲密度：-" + (lastScore - score));
                  }
               });
            });
         });
      }
      
      private function thingOver(param1:DiceThingEvent) : void
      {
         var num:int;
         var event:DiceThingEvent = param1;
         this.currentThing.removeEventListener(DiceThingEvent.DICE_THING_OVER,this.thingOver);
         this.currentThing.dispose();
         this.currentThing = null;
         num = event.resultInfo.rightNum;
         SwapManager.swapItem(this.swap_id[2],1,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            new SwapInfo(data);
            _startPt = _curPt;
            update(function():void
            {
               if(Math.abs(_startPt - _curPt) > 5)
               {
               }
               if(_startPt - _curPt != 0)
               {
                  _roleMobile.addEventListener(MoveEvent.FINISHED,moveFinished);
                  moveFinished();
               }
               else
               {
                  _diceMc.mouseEnabled = true;
               }
            });
         },null,new SpecialInfo(2,num,this._curGameIndex));
      }
      
      private function update(param1:Function = null) : void
      {
         var fun:Function = param1;
         DayLimitManager.getDoCount(this.dayLimit[0],function(param1:int):void
         {
            var val:int = param1;
            ActiveCountManager.requestActiveCountList(forever,function(param1:Parser_1142):void
            {
               var _loc2_:int = int(param1.infoVec[0]);
               var _loc3_:int = int(param1.infoVec[1]);
               var _loc4_:int = int(param1.infoVec[2]);
               _scoreFd.text = _loc3_ + "/100";
               score = _loc3_;
               var _loc5_:Boolean;
               var _loc6_:int = (_loc5_ = ActorManager.actorInfo.vipInfo.isVip()) ? 15 : 10;
               _remainFd.text = ActsHelperUtil.getCanNum(val,_loc2_,_loc6_) + "";
               _mark.width = _loc3_ / 100 * 450;
               if(_loc3_ < 100)
               {
                  _getBtn.visible = false;
               }
               else
               {
                  _getBtn.visible = true;
               }
               _curPt = _loc4_;
               if(fun != null)
               {
                  fun.call();
               }
            });
         });
      }
      
      private function onComplete(param1:SceneEvent) : void
      {
         var lastScore:int = 0;
         var evt:SceneEvent = param1;
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.fight_id.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1)
            {
               if(this._roleMobile == null)
               {
                  this._roleMobile = new PathMobile();
                  this._roleMobile.resourceUrl = URLUtil.getPetSwf(this._roleMobileID);
                  MobileManager.addMobile(this._roleMobile,MobileType.PET);
               }
               this._roleMobile = ActorManager.getActor();
               ActorManager.getActor().show();
               ActorManager.getActor().blockNoNo = true;
               ActorManager.getActor().blockFollowingPet = true;
               lastScore = this.score;
               this.update(function():void
               {
                  if(score > lastScore)
                  {
                     ServerMessager.addMessage("亲密度：+" + (score - lastScore));
                  }
                  else if(score < lastScore)
                  {
                     ServerMessager.addMessage("亲密度：-" + (lastScore - score));
                  }
               });
            }
         }
      }
      
      private function run(param1:Event) : void
      {
         if(this._diceMc.currentFrame >= 30)
         {
            this._diceMc.gotoAndStop(1);
            MovieClip(this._diceMc["diceMc"]).gotoAndStop(this._curPt - this._startPt);
            this._tm.stop();
            this._roleMobile.addEventListener(MoveEvent.FINISHED,this.moveFinished);
            this.moveFinished();
         }
      }
      
      private function moveFinished(param1:MoveEvent = null) : void
      {
         if(this._curPt - this._startPt == 0)
         {
            this._roleMobile.removeEventListener(MoveEvent.FINISHED,this.moveFinished);
            this.onCheckThing();
            return;
         }
         var _loc2_:int = this._curPt % this._tileArr.length;
         if(this._roleMobileID == 0)
         {
            this._roleMobile.runToLocation(this._tileArr[_loc2_].x,this._tileArr[_loc2_].y);
            this._startPt = this._curPt;
         }
      }
      
      private function initMobile() : void
      {
         if(this._roleMobile)
         {
            MobileManager.removeMobile(this._roleMobile,MobileType.PET);
            this._roleMobile = null;
         }
         this._roleMobile = new PathMobile();
         this._roleMobile.resourceUrl = URLUtil.getPetSwf(this._roleMobileID);
         MobileManager.addMobile(this._roleMobile,MobileType.PET);
         this._roleMobile = ActorManager.getActor();
         ActorManager.getActor().show();
         ActorManager.getActor().blockNoNo = true;
         ActorManager.getActor().blockFollowingPet = true;
      }
   }
}
