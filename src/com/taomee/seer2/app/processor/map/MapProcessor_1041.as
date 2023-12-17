package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.serverBuffer.positonValue.ServerBufferPosition_46;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_1041 extends MapProcessor
   {
       
      
      private var isSuccess:Boolean = false;
      
      private var werWolf:MovieClip;
      
      private var werWolfBloodNum:int = 120;
      
      private var werWolfBloodMc:MovieClip;
      
      private var wolfBloodBarBg:MovieClip;
      
      private var boxBloodVec:Vector.<MovieClip>;
      
      private var boxBloodBgVec:Vector.<MovieClip>;
      
      private var boxVec:Vector.<MovieClip>;
      
      private var currenttime:int;
      
      private var boxNum:int = 5;
      
      private var hitTipsVec:Vector.<MouseClickHintSprite>;
      
      private var isShoot:Boolean = false;
      
      public function MapProcessor_1041(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         SwapManager.swapItem(603,1,this.onStart);
      }
      
      private function showTips(param1:int = 0) : void
      {
         if(this.isShoot)
         {
            Tick.instance.removeRender(this.showTips);
         }
         else
         {
            ServerMessager.addMessage("使用头部射击，连续攻打狼妖！");
         }
      }
      
      private function onStart(param1:IDataInput) : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.NEWPLAYER_BUFF,this.getBuff);
      }
      
      private function getBuff(param1:ServerBuffer) : void
      {
         var isPlay:int = 0;
         var buff:ServerBuffer = param1;
         isPlay = buff.readDataAtPostion(ServerBufferPosition_46.PLAY_WOLF_FULL);
         if(isPlay != 1)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("challengeWolf2"),function():void
            {
               isPlay = 1;
               ServerBufferManager.updateServerBuffer(ServerBufferType.NEWPLAYER_BUFF,ServerBufferPosition_46.PLAY_WOLF_FULL,isPlay);
               initUI();
               initShoot();
               initTimer();
            });
         }
         else
         {
            this.initUI();
            this.initShoot();
            this.initTimer();
         }
      }
      
      private function initUI() : void
      {
         ActorManager.showRemoteActor = false;
         this.werWolf = _map.content["werWolf"];
         this.werWolf.cacheAsBitmap = true;
         this.werWolf.mouseChildren = false;
         this.werWolf.gotoAndStop(1);
         this.werWolfBloodMc = _map.content["wolfBloodBar"];
         this.wolfBloodBarBg = _map.content["wolfBloodBarBg"];
         this.boxBloodVec = new Vector.<MovieClip>();
         this.boxBloodBgVec = new Vector.<MovieClip>();
         this.boxVec = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.boxBloodVec.push(_map.content["boxBar" + _loc1_]);
            this.boxBloodBgVec.push(_map.content["boxBarBg" + _loc1_]);
            this.boxBloodBgVec[_loc1_].mouseEnabled = false;
            this.boxBloodBgVec[_loc1_].mouseChildren = false;
            this.boxVec.push(_map.content["box" + _loc1_]);
            this.boxVec[_loc1_].mouseChildren = false;
            this.boxVec[_loc1_].gotoAndStop(1);
            this.boxVec[_loc1_].buttonMode = true;
            this.boxVec[_loc1_].addEventListener(MouseEvent.CLICK,this.clickBox);
            _loc1_++;
         }
         this.hitTipsVec = new Vector.<MouseClickHintSprite>(5);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.boxVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.clickBox);
            _loc1_++;
         }
         ShootController.removeEventListener(ShootEvent.PLAY_END,this.checkTarget);
         ShootController.removeEventListener(ShootEvent.PLAY_START,this.disEnableMap);
         Tick.instance.removeRender(this.changTime);
         Tick.instance.removeRender(this.showTips);
         ActorManager.showRemoteActor = true;
      }
      
      private function clickBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!this.isSuccess)
         {
            AlertManager.showAlert("打败狼妖才可以获得宝箱，赶紧阻止狼妖破坏宝箱吧！");
            return;
         }
         _loc2_ = this.boxVec.indexOf(MovieClip(param1.target));
         _loc3_ = 604 + _loc2_;
         DisplayObjectUtil.removeFromParent(this.hitTipsVec[_loc2_]);
         DisplayObjectUtil.removeFromParent(MovieClip(param1.target));
         SwapManager.swapItem(_loc3_,1,this.onSwapSuccess);
      }
      
      private function onSwapSuccess(param1:IDataInput) : void
      {
         var _loc2_:SwapInfo = new SwapInfo(param1);
         --this.boxNum;
         if(this.boxNum == 0)
         {
            AlertManager.showAlert("所有的宝箱都开启了，回骰子星机关城去吧!",this.goMap1040);
         }
      }
      
      private function initTimer() : void
      {
         Tick.instance.addRender(this.changTime,1000);
      }
      
      private function changTime(param1:int) : void
      {
         var _loc2_:Number = NaN;
         ++this.currenttime;
         if(this.currenttime < 30)
         {
            _loc2_ = (30 - this.currenttime) / 30;
            this.changeWolfAndBox(1,_loc2_);
         }
         else if(this.currenttime < 60)
         {
            if(this.currenttime == 30)
            {
               this.removeBoxAndBar(0);
            }
            _loc2_ = (60 - this.currenttime) / 30;
            this.changeWolfAndBox(2,_loc2_);
         }
         else if(this.currenttime < 90)
         {
            if(this.currenttime == 60)
            {
               this.removeBoxAndBar(1);
            }
            _loc2_ = (90 - this.currenttime) / 30;
            this.changeWolfAndBox(3,_loc2_);
         }
         else if(this.currenttime < 120)
         {
            if(this.currenttime == 90)
            {
               this.removeBoxAndBar(2);
            }
            _loc2_ = (120 - this.currenttime) / 30;
            this.changeWolfAndBox(4,_loc2_);
         }
         else if(this.currenttime < 150)
         {
            if(this.currenttime == 120)
            {
               this.removeBoxAndBar(3);
            }
            _loc2_ = (150 - this.currenttime) / 30;
            this.changeWolfAndBox(5,_loc2_);
         }
         else
         {
            if(this.currenttime == 150)
            {
               this.removeBoxAndBar(4);
            }
            Tick.instance.removeRender(this.changTime);
            AlertManager.showAlert("狼妖砸碎了所有的宝箱，已经逃走。赶紧去机关城找找他的踪影吧!",this.goMap1040);
         }
      }
      
      private function removeBoxAndBar(param1:int, param2:Boolean = true) : void
      {
         if(param2)
         {
            --this.boxNum;
            DisplayObjectUtil.removeFromParent(this.boxVec[param1]);
         }
         DisplayObjectUtil.removeFromParent(this.boxBloodVec[param1]);
         DisplayObjectUtil.removeFromParent(this.boxBloodBgVec[param1]);
      }
      
      private function goMap1040() : void
      {
         SceneManager.changeScene(SceneType.LOBBY,1040);
      }
      
      private function changeWolfAndBox(param1:int, param2:Number) : void
      {
         if(this.werWolf.currentFrame != param1)
         {
            this.werWolf.gotoAndStop(param1);
         }
         this.setBarProgress(this.boxBloodVec[param1 - 1],param2);
         this.boxVec[param1 - 1].visible = false;
      }
      
      private function initShoot() : void
      {
         this.showTips();
         Tick.instance.addRender(this.showTips,3000);
         ShootController.addEventListener(ShootEvent.PLAY_START,this.disEnableMap);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.checkTarget);
      }
      
      private function disEnableMap(param1:ShootEvent) : void
      {
         _map.ground.mouseChildren = false;
         _map.ground.mouseEnabled = false;
      }
      
      private function checkTarget(param1:ShootEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         _map.ground.mouseChildren = true;
         _map.ground.mouseEnabled = true;
         this.isShoot = true;
         var _loc2_:ShootInfo = param1.info;
         if(!this.isSuccess && _loc2_.userID == ActorManager.actorInfo.id && this.werWolf.hitTestPoint(_loc2_.endPos.x,_loc2_.endPos.y))
         {
            --this.werWolfBloodNum;
            _loc3_ = this.werWolfBloodNum / 120;
            this.setBarProgress(this.werWolfBloodMc,_loc3_);
            if(this.werWolfBloodNum <= 0)
            {
               Tick.instance.removeRender(this.changTime);
               DisplayObjectUtil.removeFromParent(this.werWolf);
               DisplayObjectUtil.removeFromParent(this.wolfBloodBarBg);
               DisplayObjectUtil.removeFromParent(this.werWolfBloodMc);
               _loc4_ = 0;
               while(_loc4_ < 5)
               {
                  this.removeBoxAndBar(_loc4_,false);
                  if(Boolean(this.boxVec[_loc4_].parent) && !this.boxVec[_loc4_].visible)
                  {
                     this.boxVec[_loc4_].visible = true;
                  }
                  _loc4_++;
               }
               this.isSuccess = true;
               ShootController.close();
               AlertManager.showAlert("恭喜你，打败了狼妖。点击地图上的宝箱开启宝箱吧。",this.createTips);
            }
         }
         if(!this.isSuccess)
         {
            ShootController.start(ShootController.id,true);
            ShootController.isAllow = true;
         }
      }
      
      private function createTips() : void
      {
         var _loc2_:MouseClickHintSprite = null;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            if(this.boxVec[_loc1_].parent)
            {
               _loc2_ = new MouseClickHintSprite();
               _loc2_.x = this.boxVec[_loc1_].x;
               _loc2_.y = this.boxVec[_loc1_].y;
               this.hitTipsVec[_loc1_] = _loc2_;
               this.boxVec[_loc1_].parent.addChild(this.hitTipsVec[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      private function setBarProgress(param1:MovieClip, param2:Number) : void
      {
         var _loc3_:MovieClip = param1;
         var _loc4_:int = 0;
         if(param1 == this.werWolfBloodMc)
         {
            _loc4_ = 135;
         }
         else
         {
            _loc4_ = 87;
         }
         _loc3_.width = _loc4_ * param2;
      }
   }
}
