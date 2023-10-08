package com.taomee.seer2.app.processor.activity.CandyNightmareAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DomainUtil;
   
   public class CandyNightmareAct
   {
      
      private static const DAY_LIST:Array = [1541];
      
      private static const RANDOM_ID:int = 111;
      
      private static const FIGHT_INDEX:int = 1439;
      
      public static var isGoAct:Boolean;
       
      
      private var _resLib:ApplicationDomain;
      
      private var _mapModel:MapModel;
      
      private var _boss:MovieClip;
      
      public function CandyNightmareAct(param1:MapModel)
      {
         var mapModel:MapModel = param1;
         super();
         this._mapModel = mapModel;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX)
         {
            TweenNano.delayedCall(2,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
               ModuleManager.showAppModule("CandyNightmarePanel");
            });
         }
         else
         {
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               if(param1.getCount(DAY_LIST[0]) < 10)
               {
                  if(isGoAct)
                  {
                     getURL();
                     isGoAct = false;
                  }
               }
            });
         }
      }
      
      private function init() : void
      {
         var _scenMc:MovieClip = null;
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         _scenMc = this.getMovie("SceneMc0");
         this._mapModel.front.addChild(_scenMc);
         MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
         {
            _scenMc.gotoAndStop(_scenMc.totalFrames);
            SeatTipsManager.registerSeat(new Point(235,118),ActorManager.actorInfo.id);
            (_scenMc["CandyActHit"] as MovieClip).buttonMode = true;
            (_scenMc["CandyActHit"] as MovieClip).addEventListener(MouseEvent.CLICK,function onClick0(param1:MouseEvent):void
            {
               var evt:MouseEvent = param1;
               SeatTipsManager.removeSeat(new Point(235,118),ActorManager.actorInfo.id);
               (_scenMc["CandyActHit"] as MovieClip).removeEventListener(MouseEvent.CLICK,onClick0);
               DisplayObjectUtil.removeFromParent(_scenMc);
               _scenMc = null;
               _scenMc = getMovie("SceneMc1");
               _mapModel.front.addChild(_scenMc);
               MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
               {
                  _scenMc.gotoAndStop(_scenMc.totalFrames);
                  SeatTipsManager.registerSeat(new Point(74,230),ActorManager.actorInfo.id);
                  (_scenMc["CandyActHit"] as MovieClip).buttonMode = true;
                  (_scenMc["CandyActHit"] as MovieClip).addEventListener(MouseEvent.CLICK,function onClick1(param1:MouseEvent):void
                  {
                     SeatTipsManager.removeSeat(new Point(74,230),ActorManager.actorInfo.id);
                     (_scenMc["CandyActHit"] as MovieClip).removeEventListener(MouseEvent.CLICK,onClick1);
                     DisplayObjectUtil.removeFromParent(_scenMc);
                     _scenMc = null;
                     Connection.blockCommand(CommandSet.ITEM_SERVER_GIVE_1051);
                     Connection.send(CommandSet.RANDOM_EVENT_1140,RANDOM_ID,0);
                  });
               },true);
            });
         },true);
      }
      
      private function onEventStart(param1:MessageEvent) : void
      {
         var parser:Parser_1140 = null;
         var _scenMc:MovieClip = null;
         var evt:MessageEvent = param1;
         parser = new Parser_1140(evt.message.getRawDataCopy());
         if(parser.index == RANDOM_ID)
         {
            _scenMc = this.getMovie("SceneMc" + (parser.id + 1));
            this._mapModel.front.addChild(_scenMc);
            MovieClipUtil.playMc(_scenMc,2,_scenMc.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(_scenMc);
               _scenMc = null;
               Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
               if(parser.id == 4)
               {
                  _boss = getMovie("Boss");
                  _boss.buttonMode = true;
                  showMouseHintAtMonster(_boss);
                  _boss.x = 140;
                  _boss.y = 450;
                  _mapModel.content.addChild(_boss);
                  _boss.addEventListener(MouseEvent.CLICK,onBoss);
               }
               else
               {
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(2,function():void
                  {
                     ModuleManager.showAppModule("CandyNightmarePanel");
                  });
               }
            },true);
         }
      }
      
      private function onBoss(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(FIGHT_INDEX);
      }
      
      private function showMouseHintAtMonster(param1:MovieClip) : void
      {
         var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
         _loc2_.y = -_loc2_.height - 100;
         _loc2_.x = (param1.width - param1.width) / 2;
         param1.addChild(_loc2_);
      }
      
      private function getURL() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("CandyNightmareAct"),LoadType.SWF,function(param1:ContentInfo):void
         {
            _resLib = param1.domain;
            init();
         });
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
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onEventStart);
         Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
         SeatTipsManager.removeSeat(new Point(235,118),ActorManager.actorInfo.id);
         SeatTipsManager.removeSeat(new Point(74,230),ActorManager.actorInfo.id);
         if(this._boss)
         {
            this._boss.removeEventListener(MouseEvent.CLICK,this.onBoss);
            this._boss = null;
         }
         LayerManager.resetOperation();
         this._resLib = null;
         this._mapModel = null;
      }
   }
}
