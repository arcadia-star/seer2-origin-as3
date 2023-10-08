package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.KingCarZhangManager;
   import com.taomee.seer2.app.activity.processor.PrizeCeremony.Map320Prize;
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
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class MapProcessor_320 extends TitleMapProcessor
   {
       
      
      private var _PrizeMC:Map320Prize;
      
      private var bianpao:GuoNianBianPao;
      
      private var _kingCar:KingCarZhangManager;
      
      private var mcCar:MovieClip;
      
      private var index:int;
      
      private var _heroTieAct:HeroTieAct;
      
      private var _gear:MovieClip;
      
      private var _gearClick:MovieClip;
      
      public function MapProcessor_320(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initGear();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_156);
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
               ModuleManager.closeForName("KingCarZhangPanel");
               ModuleManager.showModule(URLUtil.getAppModule("KingCarZhangSmallPanel"),"打开保护的面板...");
            },null,new SpecialInfo(1,this.index));
            this.mcCar.removeEventListener(MouseEvent.CLICK,this.onMouseCar);
         }
      }
      
      private function initPrizeMC() : void
      {
         if(DateUtil.inInDateScope(5,14,31,14,41))
         {
            this._PrizeMC = new Map320Prize();
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
      
      private function initGear() : void
      {
         this._gear = _map.content["injection"];
         this._gear.gotoAndStop(1);
         this._gearClick = _map.content["swapBtn"];
         this._gearClick.buttonMode = true;
         DisplayObjectUtil.enableSprite(this._gearClick);
         this._gearClick.addEventListener(MouseEvent.CLICK,this.onGearClick);
      }
      
      private function onGearClick(param1:MouseEvent) : void
      {
         DisplayObjectUtil.disableSprite(this._gearClick);
         this._gear.addEventListener(Event.ENTER_FRAME,this.onGearEnd);
         this._gear.gotoAndStop(2);
         if(SwapManager.isSwapNumberMax(85))
         {
            SwapManager.entrySwap(85);
         }
      }
      
      private function onGearEnd(param1:Event) : void
      {
         if(this._gear.currentFrame == this._gear.totalFrames)
         {
            this._gear.removeEventListener(Event.ENTER_FRAME,this.onGearEnd);
            DisplayObjectUtil.enableSprite(this._gearClick);
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
         this._gearClick.removeEventListener(MouseEvent.CLICK,this.onGearClick);
         this._gear.removeEventListener(Event.ENTER_FRAME,this.onGearEnd);
         this._gear = null;
         this._gearClick = null;
         if(this._kingCar)
         {
            this._kingCar.dispose();
         }
         super.dispose();
      }
   }
}
