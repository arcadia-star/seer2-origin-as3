package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.record.FightRecordData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.gameRule.door.core.vo.DoorLevelInfomation;
   import com.taomee.seer2.app.gameRule.ring.RingSupport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_81 extends TitleMapProcessor
   {
       
      
      private var _ringSupport:RingSupport;
      
      private var _liftDown:MovieClip;
      
      private var _npc125:Mobile;
      
      private var _npc126:Mobile;
      
      private var _btn0:SimpleButton;
      
      private var _btn1:SimpleButton;
      
      private var _integralMC:MovieClip;
      
      private var _rulesMC:MovieClip;
      
      private var _fireworks0:MovieClip;
      
      private var _fireworks1:MovieClip;
      
      public function MapProcessor_81(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._ringSupport = RingSupport.getInstance();
         this._ringSupport.init(_map);
         this._liftDown = _map.content["liftDown"];
         initInteractor(this._liftDown);
         this._liftDown.addEventListener(MouseEvent.CLICK,this.onLiftClick);
         TooltipManager.addCommonTip(this._liftDown,"选择要塞");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_197);
         this._btn0 = _map.front["btn_0"];
         this._btn1 = _map.front["btn_1"];
         this._btn0.addEventListener(MouseEvent.CLICK,this.onBtn0);
         this._btn1.addEventListener(MouseEvent.CLICK,this.onBtn1);
         TooltipManager.addCommonTip(this._btn0,"要塞玩法");
         TooltipManager.addCommonTip(this._btn1,"玩法对抗");
         this.initNPC();
         this.checkTrainerPVP();
         this.initMascot();
      }
      
      private function initMascot() : void
      {
      }
      
      private function checkTrainerPVP() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == FightRecordData.FIGHT_PVP_TRAINER)
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("TrainerMatchPanel"),"正在加载资源...");
            }
         }
      }
      
      private function onBtn1(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("PVPDoorCampPanel"),"正在打开召集令面板...");
      }
      
      private function onBtn0(param1:MouseEvent) : void
      {
         this.onLiftClick(new MouseEvent(MouseEvent.CLICK));
      }
      
      private function initNPC() : void
      {
         this._npc125 = MobileManager.getMobile(125,MobileType.NPC);
         this._npc125.buttonMode = true;
         this._npc125.addEventListener(MouseEvent.CLICK,this.onNpc125,false,1);
         this._npc126 = MobileManager.getMobile(126,MobileType.NPC);
         this._npc126.buttonMode = true;
         this._npc126.addEventListener(MouseEvent.CLICK,this.onNpc126,false,1);
      }
      
      private function onNpc125(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         e.stopImmediatePropagation();
         NpcDialog.show(125,"试炼高手",[[0,"你是来英格瓦要塞寻找更强的挑战吗？那你来对地方了！"]],["参加试炼之门","我走错路了"],[function():void
         {
            SceneManager.changeScene(SceneType.LOBBY,82);
         }]);
      }
      
      private function onNpc126(param1:MouseEvent) : void
      {
         var doorInformation:DoorLevelInfomation = null;
         var requestDailyLimit:Function = null;
         var e:MouseEvent = param1;
         requestDailyLimit = function():void
         {
            if(doorInformation.getMaxLevelPVENormalHistory(1) == 21)
            {
               NpcDialog.show(126,"勇士之王",[[0,"你看起来很厉害嘛，一定要来挑战一下勇士之门哦，我在21层等着你！"]],["参加勇士之门","我走错路了"],[function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,83);
               }]);
            }
            else
            {
               NpcDialog.show(126,"勇士之王",[[0,"你看来还没有通过试炼之门，虽然你很厉害但我还是推荐你一步步来哦！"]],["参加试炼之门","我走错路了"],[function():void
               {
                  SceneManager.changeScene(SceneType.LOBBY,82);
               }]);
            }
         };
         e.stopImmediatePropagation();
         doorInformation = new DoorLevelInfomation();
         doorInformation.getInformation(requestDailyLimit);
      }
      
      private function onLiftClick(param1:MouseEvent) : void
      {
         if(this._ringSupport.checkChangeable())
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("DoorMapPanel"),"正在打开英格瓦要塞……");
         }
      }
      
      override public function dispose() : void
      {
         this._ringSupport.dispose();
         TooltipManager.remove(this._liftDown);
         this._liftDown = null;
         this._npc125.removeEventListener(MouseEvent.CLICK,this.onNpc125);
         this._npc125 = null;
         this._npc126.removeEventListener(MouseEvent.CLICK,this.onNpc126);
         this._npc126 = null;
         this._btn0.removeEventListener(MouseEvent.CLICK,this.onBtn0);
         this._btn1.removeEventListener(MouseEvent.CLICK,this.onBtn1);
         TooltipManager.remove(this._btn0);
         TooltipManager.remove(this._btn1);
         super.dispose();
      }
      
      override public function checkChangeable() : Boolean
      {
         return this._ringSupport.checkChangeable();
      }
   }
}
