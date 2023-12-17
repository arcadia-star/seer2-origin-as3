package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.common.MovieClipPlayer;
   import com.taomee.seer2.app.common.ResourceLibraryLoader;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.ResourceLibrary;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class HaniSnowManActivity
   {
      
      private static var _instance:HaniSnowManActivity;
       
      
      private const SNOW_BALL_ITEM_ID:int = 400216;
      
      private const SNOW_BALL_ITEM_COUNT:int = 10;
      
      private var _mapModel:MapModel;
      
      private var _hasSnow:Boolean;
      
      private var _randomStatus:int;
      
      private var _resLoader:ResourceLibraryLoader;
      
      private var _resLib:ResourceLibrary;
      
      private var _mcPlayer:MovieClipPlayer;
      
      private var _normalAnimation:MovieClip;
      
      private var _snowManAnimation:MovieClip;
      
      private var _eatAnimation:MovieClip;
      
      private var _cryAnimation:MovieClip;
      
      private var _smileAnimation:MovieClip;
      
      public function HaniSnowManActivity()
      {
         super();
      }
      
      public static function get instance() : HaniSnowManActivity
      {
         if(_instance == null)
         {
            _instance = new HaniSnowManActivity();
            _instance.init();
         }
         return _instance;
      }
      
      public static function enterMap(param1:MapModel) : void
      {
         instance.enterMap(param1);
      }
      
      public static function leaveMap() : void
      {
         instance.leaveMap();
      }
      
      public function init() : void
      {
         this._resLoader = new ResourceLibraryLoader(URLUtil.getRes("active/resource/hani_snow_man_activity" + URLUtil.POSTFIX_SWF));
         this._mcPlayer = new MovieClipPlayer();
      }
      
      public function enterMap(param1:MapModel) : void
      {
         this._mapModel = param1;
         this._resLoader.getLib(this.onGetLib);
      }
      
      public function leaveMap() : void
      {
         this._resLoader.cancel(true);
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.HANI_SNOW_QUERY_1167,this.onQuery);
         ItemManager.removeEventListener1(ItemEvent.REQUEST_ITEM_SUCCESS,this.onRequestSuccess);
         if(this._smileAnimation)
         {
            this._smileAnimation.removeEventListener(MouseEvent.CLICK,this.onSmileAnimationClick);
         }
         if(this._normalAnimation)
         {
            this._normalAnimation.removeEventListener(MouseEvent.CLICK,this.onNormalClick);
         }
         this._resLoader.dispose();
      }
      
      private function onGetLib(param1:ResourceLibrary) : void
      {
         this._resLib = param1;
         this._normalAnimation = this._resLib.getMovieClip("normal");
         this._snowManAnimation = this._resLib.getMovieClip("snow");
         this._snowManAnimation.gotoAndStop(1);
         this._eatAnimation = this._resLib.getMovieClip("eat");
         this._eatAnimation.gotoAndStop(1);
         this._cryAnimation = this._resLib.getMovieClip("cry");
         this._cryAnimation.gotoAndStop(1);
         this._smileAnimation = this._resLib.getMovieClip("smile");
         this.query();
      }
      
      private function query() : void
      {
         Connection.addCommandListener(CommandSet.HANI_SNOW_QUERY_1167,this.onQuery);
         Connection.send(CommandSet.HANI_SNOW_QUERY_1167);
      }
      
      private function onQuery(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.HANI_SNOW_QUERY_1167,this.onQuery);
         var _loc2_:IDataInput = param1.message.getRawData();
         this._hasSnow = _loc2_.readUnsignedInt() == 1;
         this._randomStatus = _loc2_.readUnsignedInt();
         this.processActivity();
      }
      
      private function processActivity() : void
      {
         if(this._hasSnow)
         {
            this.processRandomStatus();
         }
         else
         {
            this.processSnowNormal();
         }
      }
      
      private function processSnowNormal() : void
      {
         this._mapModel.front.addChild(this._normalAnimation);
         DisplayObjectUtil.enableButtonMode(this._normalAnimation);
         this._normalAnimation.addEventListener(MouseEvent.CLICK,this.onNormalClick);
      }
      
      private function onNormalClick(param1:MouseEvent) : void
      {
         ItemManager.addEventListener1(ItemEvent.REQUEST_ITEM_SUCCESS,this.onRequestSuccess);
         ItemManager.requestItemList(null);
      }
      
      private function onRequestSuccess(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_ITEM_SUCCESS,this.onRequestSuccess);
         var _loc2_:int = ItemManager.getItemQuantityByReferenceId(this.SNOW_BALL_ITEM_ID);
         if(_loc2_ == 0)
         {
            NpcDialog.show(448,"多利",[[0,"要堆雪人可是要很多雪球的哦，寒冰龟霸占着好多的雪球，你帮我取10个雪球来吧。"]],["好吧"]);
         }
         else if(_loc2_ < this.SNOW_BALL_ITEM_COUNT)
         {
            NpcDialog.show(448,"多利",[[0,"还没有足够的雪球吗？我妈随时会来叫我吃饭，我们得快点啦。"]],["哦，知道了"]);
         }
         else
         {
            NpcDialog.show(448,"多利",[[0,"这些雪球就够了，我已经等不及了，让我们马上开始吧！"]],["哦，知道了"],[this.buildSnowMan]);
         }
      }
      
      private function buildSnowMan() : void
      {
         SwapManager.swapItem(162,10,function(param1:IDataInput):void
         {
            var data:IDataInput = param1;
            var swapInfo:SwapInfo = new SwapInfo(data);
            _hasSnow = true;
            DisplayObjectUtil.removeFromParent(_normalAnimation);
            _mapModel.front.addChild(_snowManAnimation);
            _mcPlayer.playMc(_snowManAnimation,1,_snowManAnimation.totalFrames,false,function():void
            {
               DisplayObjectUtil.removeFromParent(_snowManAnimation);
               randomStatus();
            });
         });
      }
      
      private function processRandomStatus() : void
      {
         switch(this._randomStatus)
         {
            case 0:
               this.randomStatus();
               break;
            case 1:
               this.processEat();
               break;
            case 2:
               this.processSmile();
               break;
            case 3:
               this.pocessCry();
         }
      }
      
      private function randomStatus() : void
      {
         Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         Connection.send(CommandSet.RANDOM_EVENT_1140,2,0);
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc3_ == 2)
         {
            this._randomStatus = _loc4_;
            this.processRandomStatus();
         }
      }
      
      private function processEat() : void
      {
         this._mapModel.front.addChild(this._eatAnimation);
         this._mcPlayer.playMc(this._eatAnimation,1,this._eatAnimation.totalFrames,false,function():void
         {
            DisplayObjectUtil.removeFromParent(_eatAnimation);
            SwapManager.swapItem(163,1,onActivityComplete);
         });
      }
      
      private function processSmile() : void
      {
         this._mapModel.front.addChild(this._smileAnimation);
         DisplayObjectUtil.enableButtonMode(this._smileAnimation);
         this._smileAnimation.addEventListener(MouseEvent.CLICK,this.onSmileAnimationClick);
      }
      
      private function onSmileAnimationClick(param1:MouseEvent) : void
      {
         FightManager.startFightWithWild(39);
      }
      
      private function pocessCry() : void
      {
         this._mapModel.front.addChild(this._cryAnimation);
         this._mcPlayer.playMc(this._cryAnimation,1,this._cryAnimation.totalFrames,false,function():void
         {
            DisplayObjectUtil.removeFromParent(_cryAnimation);
            SwapManager.swapItem(163,1,onActivityComplete);
         });
      }
      
      private function onActivityComplete(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         this._hasSnow = false;
         this._randomStatus = 0;
      }
   }
}
