package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.BitUtil;
   
   public class KingSoulWithWindAct
   {
      
      private static var _instance:KingSoulWithWindAct;
       
      
      private const STATE_ID:uint = 203267;
      
      private const MAP_ARR:Array = [891,900,950,910,930,940];
      
      private const EMAIL_SEAT:Array = [[0,0],[244,-117],[-93,-100],[0,0],[-218,-90],[-200,-100]];
      
      private var currentDate:Date;
      
      private var index:int;
      
      private var _ALLMc:MovieClip;
      
      private var mailer:MovieClip;
      
      public function KingSoulWithWindAct()
      {
         this.currentDate = new Date();
         super();
      }
      
      public static function getInstance() : KingSoulWithWindAct
      {
         if(!_instance)
         {
            _instance = new KingSoulWithWindAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this.currentDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         if(this.currentDate.fullYear == 2013 && this.currentDate.month == 9 && this.currentDate.date == 1)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onChangeMap);
         }
      }
      
      private function onChangeMap(param1:SceneEvent) : void
      {
         this.currentDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         if(this.currentDate.hours > 13)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onChangeMap);
            return;
         }
         this.index = this.MAP_ARR.indexOf(SceneManager.active.mapID);
         if(this.index == -1)
         {
            return;
         }
         if(this.currentDate.minutes > this.index * 5 && this.currentDate.minutes <= this.index * 5 + 5)
         {
            ActiveCountManager.requestActiveCount(this.STATE_ID,this.getState);
         }
      }
      
      private function getState(param1:uint, param2:uint) : void
      {
         if(BitUtil.getBit(param2,this.index) != true)
         {
            this.createSceneMc();
         }
      }
      
      private function createSceneMc() : void
      {
         if(!this._ALLMc)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("ShowWindSoul"),LoadType.SWF,this.getMc);
         }
         else
         {
            this.addMc();
         }
      }
      
      private function addMc() : void
      {
         if(this.mailer)
         {
            this.mailer.removeEventListener(MouseEvent.CLICK,this.showAd);
         }
         this._ALLMc.x = this.EMAIL_SEAT[this.index][0];
         this._ALLMc.y = this.EMAIL_SEAT[this.index][1];
         SceneManager.active.mapModel.front.addChild(this._ALLMc);
         MovieClipUtil.playMc(this._ALLMc,1,this._ALLMc.totalFrames,function():void
         {
            _ALLMc.gotoAndStop(_ALLMc.totalFrames);
            mailer = _ALLMc["mailer"];
            mailer.buttonMode = true;
            mailer.addEventListener(MouseEvent.CLICK,showAd);
         });
      }
      
      private function getMc(param1:ContentInfo) : void
      {
         this._ALLMc = param1.content as MovieClip;
         this.addMc();
      }
      
      private function showAd(param1:MouseEvent) : void
      {
         DisplayObjectUtil.removeFromParent(this._ALLMc);
         this.currentDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         if(this.currentDate.minutes <= this.index * 5 || this.currentDate.minutes > this.index * 5 + 5)
         {
            AlertManager.showAlert("太晚了，我要走了！");
            return;
         }
         ModuleManager.toggleModule(URLUtil.getAppModule("KingSoulWithWindAdPanel"),"",this.index + 1);
      }
   }
}
