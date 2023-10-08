package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.events.MoveEvent;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_1250 extends MapProcessor
   {
      
      private static const NPC_NUM:int = 5;
      
      private static const DAY_LIMIT_ID:int = 762;
      
      private static const BOSS_DAY_LIMIT:int = 763;
      
      private static const ACTOR_POS_LIST:Vector.<Point> = Vector.<Point>([new Point(808,534),new Point(648,445),new Point(769,345),new Point(489,347),new Point(433,323)]);
      
      private static const NPC_POS_LIST:Vector.<Point> = Vector.<Point>([new Point(749,499),new Point(647,405),new Point(836,307),new Point(363,359),new Point(428,286)]);
      
      private static const LIGHT_POS_LIST:Vector.<Point> = Vector.<Point>([new Point(541,300),new Point(497,223),new Point(637,154),new Point(257,192)]);
      
      private static const NPC_ID_LIST:Array = [608,604,605,606,607];
      
      private static const FIGHT_ID_LIST:Array = [537,538,539,540,541];
      
      private static const SHAPE_POS:Array = [new Point(485,377),new Point(562,303),new Point(582,237),new Point(316,257)];
      
      private static const SHAPE_RECT:Array = [new Point(74,15),new Point(70,2),new Point(2,42),new Point(82,2)];
       
      
      private var npcList:Array;
      
      private var currentComplete:int = 0;
      
      private var bossComplete:int = 0;
      
      private var actor:Actor;
      
      private var clickMobileIndex:int = -1;
      
      private var shape:Shape;
      
      private var _resLib:ResourceLibrary;
      
      private var _lastFightIndex:int = -1;
      
      private var canFirstSeeBoss:Boolean = false;
      
      public function MapProcessor_1250(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.actor = ActorManager.getActor();
         this.npcList = [];
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         _loc1_.writeUnsignedInt(2);
         _loc1_.writeUnsignedInt(DAY_LIMIT_ID);
         _loc1_.writeUnsignedInt(BOSS_DAY_LIMIT);
         DayLimitListManager.getDoCount(_loc1_,this.getDayLimitList);
      }
      
      private function getDayLimitList(param1:DayLimitListInfo) : void
      {
         var _loc2_:Parser_1065 = null;
         var _loc3_:int = 0;
         while(_loc3_ < 2)
         {
            _loc2_ = param1.dayLimitList[_loc3_];
            if(_loc2_.id == DAY_LIMIT_ID)
            {
               this.currentComplete = _loc2_.count;
            }
            else if(_loc2_.id == BOSS_DAY_LIMIT)
            {
               this.bossComplete = _loc2_.count;
            }
            _loc3_++;
         }
         this.checkMobile();
      }
      
      private function checkMobile() : void
      {
         var _loc2_:Mobile = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.currentComplete)
         {
            this.npcList.push(null);
            _loc1_++;
         }
         var _loc3_:int = this.currentComplete;
         while(_loc3_ < 4)
         {
            _loc2_ = new Mobile();
            _loc2_.resourceUrl = URLUtil.getNpcSwf(NPC_ID_LIST[_loc3_]);
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.CLICK,this.toFight);
            _loc2_.setPostion(NPC_POS_LIST[_loc3_]);
            MobileManager.addMobile(_loc2_,MobileType.NPC);
            this.npcList.push(_loc2_);
            _loc3_++;
         }
         if(this.currentComplete < 4)
         {
            this.setShape(this.currentComplete);
         }
         var _loc4_:Boolean = SceneManager.prevSceneType == SceneType.ARENA ? true : false;
         var _loc5_:Boolean = FightManager.fightWinnerSide == FightSide.LEFT ? true : false;
         var _loc6_:int = int(FightManager.currentFightRecord.initData.positionIndex);
         this._lastFightIndex = FIGHT_ID_LIST.indexOf(_loc6_);
         var _loc7_:Boolean = this.currentComplete == 4 ? true : false;
         this.canFirstSeeBoss = _loc6_ == FIGHT_ID_LIST[3] && _loc7_ && this.bossComplete == 0 ? true : false;
         if(_loc4_ && _loc5_ && this._lastFightIndex >= 0 && this._lastFightIndex <= 3)
         {
            this.showSpriteLight();
         }
         if(_loc7_ && !this.canFirstSeeBoss)
         {
            this.showBoss();
         }
      }
      
      private function showBoss() : void
      {
         var _loc1_:Mobile = new Mobile();
         _loc1_.resourceUrl = URLUtil.getNpcSwf(NPC_ID_LIST[4]);
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.toFight);
         _loc1_.setPostion(NPC_POS_LIST[4]);
         MobileManager.addMobile(_loc1_,MobileType.NPC);
         this.npcList[4] = _loc1_;
      }
      
      private function showSpriteLight() : void
      {
         if(!this._resLib)
         {
            QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/" + 1250),LoadType.DOMAIN,this.onLoadComplete);
         }
         else
         {
            this.showLight();
         }
      }
      
      private function onLoadComplete(param1:ContentInfo) : void
      {
         this._resLib = new ResourceLibrary(param1.content);
         this.showLight();
      }
      
      private function showLight() : void
      {
         var light:MovieClip = null;
         light = this._resLib.getMovieClip("light");
         light.x = LIGHT_POS_LIST[this._lastFightIndex].x;
         light.y = LIGHT_POS_LIST[this._lastFightIndex].y;
         _map.content.addChild(light);
         MovieClipUtil.playMc(light,1,light.totalFrames,function():void
         {
            var boss:MovieClip = null;
            DisplayObjectUtil.removeFromParent(light);
            if(canFirstSeeBoss)
            {
               boss = _resLib.getMovieClip("ShowYiBeast");
               _map.content.addChild(boss);
               MovieClipUtil.playMc(boss,1,boss.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(boss);
                  showBoss();
               });
            }
         });
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var x:Number;
         var y:Number;
         var e:MouseEvent = param1;
         this.clickMobileIndex = this.npcList.indexOf(e.currentTarget as Mobile);
         x = Number(this.actor.x);
         y = Number(this.actor.y);
         if(x == ACTOR_POS_LIST[this.clickMobileIndex].x && y == ACTOR_POS_LIST[this.clickMobileIndex].y)
         {
            if(this.clickMobileIndex == 4)
            {
               if(this.bossComplete >= 3)
               {
                  NpcDialog.show(113,"超级NONO",[[0,"勇士！今天的挑战次数已经用完，请明天再来挑战吧！"]],["明天再来！"]);
               }
               else
               {
                  NpcDialog.show(113,"超级NONO",[[0,"每天有3次挑战机会，您已经挑战" + this.bossComplete + "次！是否立即开始挑战？"]],["开始挑战！","准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(FIGHT_ID_LIST[4]);
                  }]);
               }
            }
         }
         this.actor.addEventListener(MoveEvent.FINISHED,this.onMoveFinish);
         this.actor.runToLocation(ACTOR_POS_LIST[this.clickMobileIndex].x,ACTOR_POS_LIST[this.clickMobileIndex].y);
      }
      
      private function onMoveFinish(param1:MoveEvent) : void
      {
         var x:Number;
         var y:Number;
         var e:MoveEvent = param1;
         this.actor.removeEventListener(MoveEvent.FINISHED,this.onMoveFinish);
         x = Number(this.actor.x);
         y = Number(this.actor.y);
         if(Math.abs(x - ACTOR_POS_LIST[this.clickMobileIndex].x) <= 2 && Math.abs(y - ACTOR_POS_LIST[this.clickMobileIndex].y) <= 2)
         {
            if(this.clickMobileIndex == 4)
            {
               if(this.bossComplete >= 3)
               {
                  NpcDialog.show(113,"超级NONO",[[0,"勇士！今天的挑战次数已经用完，请明天再来挑战吧！"]],["明天再来！"]);
               }
               else
               {
                  NpcDialog.show(113,"超级NONO",[[0,"每天有3次挑战机会，您已经挑战" + this.bossComplete + "次！是否立即开始挑战？"]],["开始挑战！","准备一下"],[function():void
                  {
                     FightManager.startFightWithWild(FIGHT_ID_LIST[4]);
                  }]);
               }
            }
            else
            {
               FightManager.startFightWithWild(FIGHT_ID_LIST[this.clickMobileIndex]);
            }
         }
         this.clickMobileIndex = -1;
      }
      
      private function setShape(param1:int) : void
      {
         if(!this.shape)
         {
            this.shape = new Shape();
         }
         else
         {
            this.shape.graphics.clear();
         }
         this.shape.graphics.beginFill(0,1);
         this.shape.graphics.drawRect(0,0,SHAPE_RECT[this.currentComplete].x,SHAPE_RECT[this.currentComplete].y);
         this.shape.graphics.endFill();
         this.shape.x = SHAPE_POS[this.currentComplete].x;
         this.shape.y = SHAPE_POS[this.currentComplete].y;
         _map.path.addChild(this.shape);
         _map.recalculatePathData();
      }
      
      override public function dispose() : void
      {
         this.clickMobileIndex = -1;
         this._lastFightIndex = -1;
         this.actor.removeEventListener(MoveEvent.FINISHED,this.onMoveFinish);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            if(this.npcList[_loc1_])
            {
               this.npcList[_loc1_].removeEventListener(MouseEvent.CLICK,this.toFight);
               MobileManager.removeMobile(this.npcList[_loc1_],MobileType.NPC);
               this.npcList[_loc1_] = null;
            }
            _loc1_++;
         }
         this._resLib = null;
         this.canFirstSeeBoss = false;
         if(this.shape)
         {
            DisplayObjectUtil.removeFromParent(this.shape);
            this.shape.graphics.clear();
            this.shape = null;
            _map.recalculatePathData();
         }
      }
   }
}
