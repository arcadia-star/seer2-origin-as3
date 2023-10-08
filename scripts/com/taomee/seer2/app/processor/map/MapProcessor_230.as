package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.KingCarZhangManager;
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.Map230Prize;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.guoNianFangBianPao.GuoNianBianPao;
   import com.taomee.seer2.app.processor.activity.heroTieAct.HeroTieAct;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_230 extends TitleMapProcessor
   {
       
      
      private var _diamondVec:Vector.<MovieClip>;
      
      private var _diamond1:MovieClip;
      
      private var _diamond1HotArea:MovieClip;
      
      private var _redFlag:MovieClip;
      
      private var _redFlagHotArea:MovieClip;
      
      private var _littleBoyHotArea:MovieClip;
      
      private var _littleDuckGame:MovieClip;
      
      private var _funnyLion:MovieClip;
      
      private var _fireRaceIntroduce:MovieClip;
      
      private var _fireRaceIntroduceCloseBtn:SimpleButton;
      
      private var _PrizeMC:Map230Prize;
      
      private var bianpao:GuoNianBianPao;
      
      private var _kingCar:KingCarZhangManager;
      
      private var mcCar:MovieClip;
      
      private var index:int;
      
      private var _heroTieAct:HeroTieAct;
      
      public function MapProcessor_230(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initFireRaceIntroduce();
         this.initDiamondVec();
         this.initLittleDuckGame();
         this.initRedFlag();
         this.initFunnyLion();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_163);
         this._kingCar = new KingCarZhangManager(_map);
      }
      
      private function addKingChar() : void
      {
         if(KingCarZhangManager.go == -1)
         {
            _map.content["newCar"].visible = false;
            return;
         }
         if(KingCarZhangManager.dayState[KingCarZhangManager.go])
         {
            _map.content["newCar"].visible = false;
            KingCarZhangManager.go = -1;
            return;
         }
         _map.content["newCar"].visible = true;
         this.index = KingCarZhangManager.go;
         KingCarZhangManager.go = 0;
         this.mcCar = _map.content["newCar"];
         this.mcCar.gotoAndStop(1);
         this.mcCar.mouseChildren = false;
         this.mcCar.addEventListener(MouseEvent.CLICK,this.onMouseCar);
         MovieClipUtil.playMc(this.mcCar,1,this.mcCar.totalFrames,function():void
         {
            mcCar.gotoAndStop(mcCar.totalFrames);
         },true);
      }
      
      private function onMouseCar(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.mcCar.currentFrame == this.mcCar.totalFrames)
         {
            SwapManager.swapItem(KingCarZhangManager.CarSwap,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               mcCar.visible = false;
               ModuleManager.closeForName("KingCarZhangPanel");
               ModuleManager.showModule(URLUtil.getAppModule("KingCarZhangSmallPanel"),"打开保护的面板...");
            },null,new SpecialInfo(1,this.index));
            this.mcCar.removeEventListener(MouseEvent.CLICK,this.onMouseCar);
         }
      }
      
      private function initHeroTieAct() : void
      {
         this._heroTieAct = new HeroTieAct(_map);
      }
      
      private function disposeHeroTieAct() : void
      {
         if(this._heroTieAct)
         {
            this._heroTieAct.dispose();
            this._heroTieAct = null;
         }
      }
      
      private function initGuoNianBianPao() : void
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         if(_loc1_.month == 1 && (_loc1_.date >= 6 && _loc1_.date <= 13))
         {
            this.bianpao = new GuoNianBianPao(this._map);
            this.bianpao.initBianPao();
         }
      }
      
      private function initFireRaceIntroduce() : void
      {
         this._fireRaceIntroduce = _map.content["fireRaceIntroduce"];
         this._fireRaceIntroduce.visible = false;
         this._fireRaceIntroduce.mouseEnabled = false;
         this._fireRaceIntroduceCloseBtn = this._fireRaceIntroduce["closeBtn"];
         this._fireRaceIntroduceCloseBtn.addEventListener(MouseEvent.CLICK,this.onFireRaceIntroduceClose);
      }
      
      private function onFireRaceIntroduceClose(param1:MouseEvent) : void
      {
         LayerManager.resetOperation();
         this._fireRaceIntroduce.visible = false;
      }
      
      private function initPrizeMC() : void
      {
         if(DateUtil.inInDateScope(5,14,21,14,31))
         {
            this._PrizeMC = new Map230Prize();
         }
      }
      
      private function initDiamondVec() : void
      {
         this._diamondVec = new Vector.<MovieClip>();
         this._diamond1 = _map.content["diamond1"];
         this._diamond1HotArea = _map.content["diamond1HotArea"];
         closeInteractor(this._diamond1);
         initInteractor(this._diamond1HotArea);
         this._diamond1HotArea.addEventListener(MouseEvent.MOUSE_OVER,this.onDiamondOneMouseOver);
         this._diamond1HotArea.addEventListener(MouseEvent.MOUSE_OUT,this.onDiamondOneMouseOut);
         this._diamond1HotArea.addEventListener(MouseEvent.CLICK,this.onDiamondOneClick);
         var _loc1_:MovieClip = _map.content["diamond2"];
         this._diamondVec.push(_loc1_);
         var _loc2_:MovieClip = _map.content["diamond3"];
         this._diamondVec.push(_loc2_);
         this.addDiamondEventListener();
      }
      
      private function addDiamondEventListener() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            initInteractor(this._diamondVec[_loc1_]);
            this._diamondVec[_loc1_].gotoAndStop(1);
            this._diamondVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.onDiamondMouseOver);
            this._diamondVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.onDiamondMouseOut);
            this._diamondVec[_loc1_].addEventListener(MouseEvent.CLICK,this.onDiamondClick);
            _loc1_++;
         }
      }
      
      private function onDiamondOneMouseOver(param1:MouseEvent) : void
      {
         this._diamond1.gotoAndStop(3);
      }
      
      private function onDiamondOneMouseOut(param1:MouseEvent) : void
      {
         this._diamond1.gotoAndStop(1);
      }
      
      private function onDiamondOneClick(param1:MouseEvent) : void
      {
         this._diamond1.gotoAndStop(1);
         this._fireRaceIntroduce.visible = true;
         LayerManager.focusOnTopLayer();
         LayerManager.topLayer.addChild(this._fireRaceIntroduce);
      }
      
      private function onDiamondMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame != 3)
         {
            _loc2_.gotoAndStop(2);
         }
      }
      
      private function onDiamondMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame != 3)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      private function onDiamondClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame != 3)
         {
            _loc2_.gotoAndStop(3);
         }
         else
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      private function initRedFlag() : void
      {
         this._redFlag = _map.content["redFlag"];
         this._redFlagHotArea = _map.content["redFlagHotArea"];
         this._redFlag.gotoAndStop(1);
         closeInteractor(this._redFlag);
         initInteractor(this._redFlagHotArea);
         this._redFlagHotArea.addEventListener(MouseEvent.MOUSE_OVER,this.onRedFlagOver);
         this._redFlagHotArea.addEventListener(MouseEvent.MOUSE_OUT,this.onRedFlagOut);
      }
      
      private function onRedFlagOver(param1:MouseEvent) : void
      {
         this._redFlag.gotoAndStop(2);
      }
      
      private function onRedFlagOut(param1:MouseEvent) : void
      {
         this._redFlag.gotoAndStop(1);
      }
      
      private function initLittleDuckGame() : void
      {
         this._littleBoyHotArea = _map.content["littleBoyHotArea"];
         this._littleDuckGame = _map.content["littleDuckGame"];
         this._littleDuckGame.gotoAndStop(2);
         closeInteractor(this._littleDuckGame);
         initInteractor(this._littleBoyHotArea);
         this._littleBoyHotArea.addEventListener(MouseEvent.CLICK,this.onLittleGameClick);
      }
      
      private function onLittleGameClick(param1:MouseEvent) : void
      {
         this.reward();
         closeInteractor(this._littleBoyHotArea);
         this._littleDuckGame.gotoAndStop(3);
      }
      
      private function reward() : void
      {
         if(SwapManager.isSwapNumberMax(30))
         {
            SwapManager.entrySwap(30);
         }
      }
      
      private function initFunnyLion() : void
      {
         this._funnyLion = _map.content["funnyLion"];
         initInteractor(this._funnyLion);
         this._funnyLion.gotoAndStop(1);
         this._funnyLion.addEventListener(MouseEvent.MOUSE_OVER,this.onFunnyLionOver);
         this._funnyLion.addEventListener(MouseEvent.MOUSE_OUT,this.onFunnyLionOut);
      }
      
      private function onFunnyLionOver(param1:MouseEvent) : void
      {
         this._funnyLion.gotoAndStop(2);
      }
      
      private function onFunnyLionOut(param1:MouseEvent) : void
      {
         this._funnyLion.gotoAndStop(1);
      }
      
      private function clearDiamondVec() : void
      {
         this._diamond1HotArea.removeEventListener(MouseEvent.MOUSE_OVER,this.onDiamondOneMouseOver);
         this._diamond1HotArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onDiamondOneMouseOut);
         this._diamond1HotArea.removeEventListener(MouseEvent.CLICK,this.onDiamondOneClick);
         var _loc1_:uint = 0;
         while(_loc1_ < 2)
         {
            this._diamondVec[_loc1_].removeEventListener(MouseEvent.MOUSE_OVER,this.onDiamondMouseOver);
            this._diamondVec[_loc1_].removeEventListener(MouseEvent.MOUSE_OUT,this.onDiamondMouseOut);
            this._diamondVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.onDiamondClick);
            this._diamondVec[_loc1_] = null;
            _loc1_++;
         }
         this._diamondVec = null;
         this._diamond1HotArea = null;
      }
      
      override public function dispose() : void
      {
         if(this._PrizeMC)
         {
            this._PrizeMC.dispose();
         }
         LayerManager.resetOperation();
         this.clearDiamondVec();
         this._littleBoyHotArea.removeEventListener(MouseEvent.CLICK,this.onLittleGameClick);
         this._littleBoyHotArea = null;
         this._littleDuckGame = null;
         this._funnyLion.removeEventListener(MouseEvent.MOUSE_OVER,this.onFunnyLionOver);
         this._funnyLion.removeEventListener(MouseEvent.MOUSE_OUT,this.onFunnyLionOut);
         this._funnyLion = null;
         this._redFlagHotArea.removeEventListener(MouseEvent.MOUSE_OVER,this.onRedFlagOver);
         this._redFlagHotArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onRedFlagOut);
         this._redFlagHotArea = null;
         this._redFlag = null;
         if(this.bianpao)
         {
            this.bianpao.dispose();
         }
         if(this._kingCar)
         {
            this._kingCar.dispose();
         }
         super.dispose();
      }
   }
}
