package com.taomee.seer2.app.activity.processor.giftFromSeer
{
   import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.activity.processor.GiftFromSeer;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class GiftFromSeerMapHandler extends ActivityMapHandler
   {
      
      private static const SWAP_ID:uint = 219;
      
      private static const DAY_LIMIT_INDEX:uint = 326;
      
      private static const TOTAL_BOX_COUNT:uint = 22;
      
      private static const BOSS_INDEX:uint = 52;
       
      
      private var _boxCount:uint;
      
      private var _box:SimpleButton;
      
      private var _openBox:MovieClip;
      
      private var _miKa:MovieClip;
      
      protected var _boxPos:Point;
      
      public function GiftFromSeerMapHandler(param1:ActivityProcessor)
      {
         super(param1);
         this.showGetMiKaAnimation();
         if((_activityProcessor as GiftFromSeer).hasGetMiKa == false)
         {
            this.showSpecial();
         }
      }
      
      private function showGetMiKaAnimation() : void
      {
         if(SceneManager.active && SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.positionIndex) && FightManager.currentFightRecord.initData.positionIndex == BOSS_INDEX)
         {
            (_activityProcessor as GiftFromSeer).hasGetMiKa = true;
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("giftFromSeer/getMiKaFull"));
         }
      }
      
      private function showSpecial() : void
      {
         Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065,this.onGetBoxCount);
         Connection.send(CommandSet.DAILY_LIMIT_1065,DAY_LIMIT_INDEX);
      }
      
      private function isShowMiKa() : Boolean
      {
         return this._boxCount == TOTAL_BOX_COUNT - 1;
      }
      
      private function onGetBoxCount(param1:MessageEvent) : void
      {
         var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
         if(_loc2_.id == DAY_LIMIT_INDEX)
         {
            Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onGetBoxCount);
            this._boxCount = _loc2_.count;
            if(this._boxCount < TOTAL_BOX_COUNT)
            {
               ServerMessager.addMessage("你已经找到 <font color=\'#ffcc00\'>" + this._boxCount + "</font> 个礼盒了，加油");
               this.showBox();
            }
         }
      }
      
      private function showMiKa() : void
      {
         this._miKa = (_activityProcessor as GiftFromSeer).miKa;
         if(this._miKa == null)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("giftFromSeer/miKa"),LoadType.SWF,this.onMiKaLoaded);
         }
         else
         {
            this.playMiKa();
         }
      }
      
      private function onMiKaLoaded(param1:ContentInfo) : void
      {
         this._miKa = (_activityProcessor as GiftFromSeer).miKa = (param1.content as MovieClip)["box"];
         this.playMiKa();
      }
      
      private function playMiKa() : void
      {
         this._miKa.x = this._boxPos.x;
         this._miKa.y = this._boxPos.y;
         this.clearBox();
         SceneManager.active.mapModel.content.addChild(this._miKa);
         MovieClipUtil.playMc(this._miKa,1,this._miKa.totalFrames,function():void
         {
            clearMiKa();
            FightManager.startFightWithWild(BOSS_INDEX);
         },true);
      }
      
      private function clearMiKa() : void
      {
         QueueLoader.cancel(URLUtil.getActivityAnimation("giftFromSeer/miKa"),this.onMiKaLoaded);
         if(this._miKa)
         {
            this._miKa.stop();
            DisplayObjectUtil.removeFromParent(this._miKa);
            this._miKa = null;
         }
      }
      
      private function showOpenBox() : void
      {
         this._openBox = (_activityProcessor as GiftFromSeer).openBox;
         if(this._openBox == null)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("giftFromSeer/openBox"),LoadType.SWF,this.onOpenBoxLoaded);
         }
         else
         {
            this.playOpenBox();
         }
      }
      
      private function onOpenBoxLoaded(param1:ContentInfo) : void
      {
         this._openBox = (_activityProcessor as GiftFromSeer).openBox = (param1.content as MovieClip)["box"];
         this.playOpenBox();
      }
      
      private function playOpenBox() : void
      {
         this._openBox.x = this._boxPos.x;
         this._openBox.y = this._boxPos.y;
         this.clearBox();
         SceneManager.active.mapModel.content.addChild(this._openBox);
         MovieClipUtil.playMc(this._openBox,1,this._openBox.totalFrames,function():void
         {
            var _loc1_:Array = null;
            var _loc2_:uint = 0;
            clearOpenBox();
            if(_activityProcessor)
            {
               _loc1_ = (_activityProcessor as GiftFromSeer).getRelateMapIDArr();
               if(_loc1_)
               {
                  _loc2_ = uint(_loc1_.indexOf(SceneManager.active.mapID));
                  if(_loc2_ != -1)
                  {
                     (_activityProcessor as GiftFromSeer).coldTime[_loc2_] = 60;
                  }
                  SwapManager.swapItem(SWAP_ID);
               }
            }
         },true);
      }
      
      private function clearOpenBox() : void
      {
         QueueLoader.cancel(URLUtil.getActivityAnimation("giftFromSeer/openBox"),this.onOpenBoxLoaded);
         if(this._openBox)
         {
            this._openBox.stop();
            DisplayObjectUtil.removeFromParent(this._openBox);
            this._openBox = null;
         }
      }
      
      protected function showBox() : void
      {
         var _loc1_:uint = uint((_activityProcessor as GiftFromSeer).getRelateMapIDArr().indexOf(SceneManager.active.mapID));
         if(_loc1_ != -1 && (_activityProcessor as GiftFromSeer).coldTime[_loc1_] == 0)
         {
            this._box = (_activityProcessor as GiftFromSeer).box;
            if(this._box == null)
            {
               QueueLoader.load(URLUtil.getActivityAnimation("giftFromSeer/box"),LoadType.SWF,this.onBoxLoaded);
            }
            else
            {
               this.addBox();
            }
         }
      }
      
      private function onBoxLoaded(param1:ContentInfo) : void
      {
         this._box = (_activityProcessor as GiftFromSeer).box = (param1.content as MovieClip)["box"];
         this.addBox();
      }
      
      private function addBox() : void
      {
         if(Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel))
         {
            this._box.x = this._boxPos.x;
            this._box.y = this._boxPos.y;
            SceneManager.active.mapModel.content.addChild(this._box);
            this._box.addEventListener(MouseEvent.CLICK,this.onBoxClick);
         }
      }
      
      private function clearBox() : void
      {
         QueueLoader.cancel(URLUtil.getActivityAnimation("giftFromSeer/box"),this.onBoxLoaded);
         if(this._box)
         {
            this._box.removeEventListener(MouseEvent.CLICK,this.onBoxClick);
            DisplayObjectUtil.removeFromParent(this._box);
            this._box = null;
         }
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         if(this.isShowMiKa())
         {
            this.showMiKa();
         }
         else
         {
            this.showOpenBox();
         }
      }
      
      override public function process() : void
      {
      }
      
      override public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065,this.onGetBoxCount);
         this.clearBox();
         this.clearMiKa();
         this.clearOpenBox();
         super.dispose();
      }
   }
}
