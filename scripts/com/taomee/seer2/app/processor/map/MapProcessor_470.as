package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.KingCarZhangManager;
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.Map470Prize;
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
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_470 extends TitleMapProcessor
   {
       
      
      private var _gameBtn:SimpleButton;
      
      private var _PrizeMC:Map470Prize;
      
      private var bianpao:GuoNianBianPao;
      
      private var _kingCar:KingCarZhangManager;
      
      private var mcCar:MovieClip;
      
      private var index:int;
      
      private var _heroTieAct:HeroTieAct;
      
      private var _bucket:MovieClip;
      
      public function MapProcessor_470(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initBucket();
         this.initGame();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_147);
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
         this.mcCar.buttonMode = true;
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
      
      private function initGame() : void
      {
         this._gameBtn = _map.content["gameBtn"];
         TooltipManager.addGameTip(this._gameBtn,"酒鬼胖胖");
         this._gameBtn.addEventListener(MouseEvent.CLICK,this.onGameClick);
      }
      
      private function onGameClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_258);
         ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"),"正在打开小游戏" + "...",{"gameId":10});
      }
      
      private function initPrizeMC() : void
      {
         if(DateUtil.inInDateScope(5,14,41,14,51))
         {
            this._PrizeMC = new Map470Prize();
         }
      }
      
      private function initBucket() : void
      {
         this._bucket = _map.content["bucket"];
         this._bucket.addEventListener(MouseEvent.CLICK,this.onBucketClick);
      }
      
      private function onBucketClick(param1:MouseEvent) : void
      {
         this._bucket.removeEventListener(MouseEvent.CLICK,this.onBucketClick);
         if(SwapManager.isSwapNumberMax(90))
         {
            SwapManager.entrySwap(90);
         }
      }
      
      override public function dispose() : void
      {
         if(this._PrizeMC)
         {
            this._PrizeMC.dispose();
         }
         if(this.bianpao)
         {
            this.bianpao.dispose();
         }
         this._bucket.removeEventListener(MouseEvent.CLICK,this.onBucketClick);
         this._bucket = null;
         TooltipManager.remove(this._gameBtn);
         this._gameBtn.removeEventListener(MouseEvent.CLICK,this.onGameClick);
         this._gameBtn = null;
         if(this._kingCar)
         {
            this._kingCar.dispose();
         }
         super.dispose();
      }
   }
}
