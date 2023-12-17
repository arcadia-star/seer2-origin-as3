package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80172 extends MapProcessor
   {
       
      
      private var fightNum:int;
      
      private var buyFightNum:int;
      
      private var haveUsedFightNum:int;
      
      private var movie:MovieClip;
      
      private var clickTargetList:Vector.<MovieClip>;
      
      private var mouseList:Vector.<MouseClickHintSprite>;
      
      private var RANDOM:int = 85;
      
      private const postionList:Array = [new Point(243,164),new Point(418,164),new Point(607,164),new Point(757,164)];
      
      public function MapProcessor_80172(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.movie = _map.content["movie"];
         if(this.movie)
         {
            this.movie.visible = false;
            this.movie.gotoAndStop(1);
         }
         this.clickTargetList = new Vector.<MovieClip>();
         this.mouseList = new Vector.<MouseClickHintSprite>();
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this.clickTargetList.push(_map.content["clickTarget" + _loc1_]);
            this.clickTargetList[_loc1_].buttonMode = true;
            this.mouseList.push(new MouseClickHintSprite());
            _loc1_++;
         }
         ActiveCountManager.requestActiveCount(203975,this.getForlimit);
      }
      
      private function getForlimit(param1:uint, param2:uint) : void
      {
         this.buyFightNum = param2;
         DayLimitManager.getDoCount(1065,this.getDaylimit);
      }
      
      private function getDaylimit(param1:uint) : void
      {
         this.haveUsedFightNum = param1;
         if(ActorManager.actorInfo.vipInfo.isVip())
         {
            this.fightNum = 5 + this.buyFightNum - this.haveUsedFightNum;
         }
         else
         {
            this.fightNum = 3 + this.buyFightNum - this.haveUsedFightNum;
         }
         this.check_play_movie();
      }
      
      private function check_play_movie() : void
      {
         ServerBufferManager.getServerBuffer(218,this.getServerBuffer);
      }
      
      private function getServerBuffer(param1:ServerBuffer) : void
      {
         var buffer:ServerBuffer = param1;
         var count:int = buffer.readDataAtPostion(1);
         if(count == 0)
         {
            if(this.movie)
            {
               this.movie.visible = true;
               MovieClipUtil.playMc(this.movie,1,this.movie.totalFrames,function():void
               {
                  DisplayObjectUtil.removeFromParent(movie);
                  ServerBufferManager.updateServerBuffer(218,1,1);
                  showPanel();
               });
            }
            else
            {
               this.showPanel();
            }
         }
         else
         {
            this.showPanel();
         }
      }
      
      private function showPanel() : void
      {
         var _loc1_:int = 0;
         ModuleManager.showModule(URLUtil.getAppModule("KaNiYaChaoJinHuaAlertPanel"),"");
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _map.content.addChild(this.mouseList[_loc1_]);
            this.mouseList[_loc1_].x = this.postionList[_loc1_].x;
            this.mouseList[_loc1_].y = this.postionList[_loc1_].y;
            this.clickTargetList[_loc1_].addEventListener(MouseEvent.CLICK,this.onClick);
            _loc1_++;
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:BuyPropInfo = null;
         if(this.fightNum > 0)
         {
            this.startFight();
         }
         else
         {
            _loc2_ = new BuyPropInfo();
            _loc2_.buyComplete = this.startFight;
            _loc2_.itemId = 603575;
            ShopManager.buyVirtualItem(_loc2_);
         }
      }
      
      private function startFight(param1:* = null) : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         Connection.send(CommandSet.RANDOM_EVENT_1140,this.RANDOM,0);
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         FightManager.startFightWithBoss(_loc4_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            this.clickTargetList[_loc1_].removeEventListener(MouseEvent.CLICK,this.onClick);
            DisplayObjectUtil.removeFromParent(this.mouseList[_loc1_]);
            _loc1_++;
         }
      }
   }
}
