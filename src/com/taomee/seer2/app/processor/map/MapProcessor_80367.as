package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80367 extends MapProcessor
   {
       
      
      private var _octopusCrawl:MovieClip;
      
      private var _octopusCrawlTrigger:MovieClip;
      
      private var _teleport:Teleport;
      
      private var bossNpc:Mobile;
      
      private const NPC_ID:uint = 832;
      
      private const FIGHT_ID:uint = 792;
      
      public function MapProcessor_80367(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(DateUtil.isInDayAndHourScope(3,8,14,14,20,30))
         {
            this.createNpc();
         }
         else
         {
            AlertManager.showAlert("活动时间已经结束了,去传送室看看其他活动吧!",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
            });
         }
         this.initTeleport();
         this.initOctopus();
      }
      
      private function initTeleport() : void
      {
         this._teleport = AnimateElementManager.getElement(1) as Teleport;
         this._teleport.visible = false;
      }
      
      private function createNpc() : void
      {
         this.bossNpc = new Mobile();
         this.bossNpc.resourceUrl = URLUtil.getNpcSwf(this.NPC_ID);
         this.bossNpc.buttonMode = true;
         this.bossNpc.x = 607;
         this.bossNpc.y = 394;
         this.bossNpc.addEventListener(MouseEvent.CLICK,this.toFight);
         this.bossNpc.addOverHeadMark(new AcceptableMark());
         MobileManager.addMobile(this.bossNpc,MobileType.NPC);
      }
      
      private function toFight(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(this.NPC_ID,"雷小伊",[[0,"你有能力战胜我吗？战胜后有机会获得雷伊石哦！"]],["马上挑战","我是路过的"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_ID);
         }]);
      }
      
      private function initOctopus() : void
      {
         this._octopusCrawl = _map.content["octopusCrawl"];
         this._octopusCrawlTrigger = _map.content["octopusCrawlTrigger"];
         initInteractor(this._octopusCrawlTrigger);
         closeInteractor(this._octopusCrawl);
         this._octopusCrawlTrigger.addEventListener(MouseEvent.CLICK,this.onOctopusClick);
      }
      
      private function resetOctopus(param1:Event) : void
      {
         if(this._octopusCrawl.currentFrame == this._octopusCrawl.totalFrames)
         {
            this._octopusCrawl.stop();
            this._octopusCrawl.removeEventListener(Event.ENTER_FRAME,this.resetOctopus);
            this.showTeleport(this._teleport);
         }
      }
      
      private function showTeleport(param1:Teleport) : void
      {
         param1.visible = true;
      }
      
      private function onOctopusClick(param1:MouseEvent) : void
      {
         this._octopusCrawl.addEventListener(Event.ENTER_FRAME,this.resetOctopus);
         closeInteractor(this._octopusCrawlTrigger);
         this._octopusCrawlTrigger.removeEventListener(MouseEvent.CLICK,this.onOctopusClick);
         this._octopusCrawl.gotoAndPlay("跑掉了");
      }
      
      override public function dispose() : void
      {
         if(this._octopusCrawlTrigger)
         {
            this._octopusCrawlTrigger.removeEventListener(MouseEvent.CLICK,this.onOctopusClick);
         }
         if(this.bossNpc)
         {
            this.bossNpc.removeEventListener(MouseEvent.CLICK,this.toFight);
         }
         this._octopusCrawl = null;
         this._octopusCrawlTrigger = null;
         this._teleport = null;
         this.bossNpc = null;
         super.dispose();
      }
   }
}
