package com.taomee.seer2.app.processor.activity.guessDevilHouseAct
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class GuessDevilHouseAct
   {
      
      private static const FOR_LIST:Array = [206396];
      
      private static const FIGHT_LIST:Vector.<int> = Vector.<int>([1438]);
       
      
      private var _leave:SimpleButton;
      
      private var _qiu:MovieClip;
      
      private var _followMC:MovieClip;
      
      private var _dragMC:MovieClip;
      
      private var _darkBg:MovieClip;
      
      private var _pet:MovieClip;
      
      private var _map:MapModel;
      
      private var _fightState:int;
      
      public function GuessDevilHouseAct(param1:MapModel)
      {
         var map:MapModel = param1;
         super();
         this._map = map;
         this.initSet();
         if(SceneManager.prevSceneType != SceneType.ARENA)
         {
            this.update();
         }
         else
         {
            (SceneManager.active as LobbyScene).showToolbar();
            TweenNano.delayedCall(2,function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
               ModuleManager.showAppModule("GuessDevilHousePanel");
            });
         }
      }
      
      private function initSet() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
         this._leave = this._map.front["leave"];
         this._qiu = this._map.front["qiu"];
         this._qiu.mouseEnabled = this._qiu.mouseChildren = false;
         this._followMC = this._map.front["followMC"];
         this._dragMC = this._map.front["dragMC"];
         this._darkBg = this._map.front["darkBg"];
         this._pet = this._darkBg["pet"];
         this._darkBg.mask = this._dragMC;
         this._followMC.mouseEnabled = this._followMC.mouseChildren = false;
         this._dragMC.mouseEnabled = this._dragMC.mouseChildren = false;
         this._dragMC.startDrag(true);
         this._pet.visible = false;
         this._pet.buttonMode = true;
         if(Boolean(this._map.content) && Boolean(this._map.content.stage))
         {
            this._map.content.stage.addEventListener(MouseEvent.CLICK,this.onStageClick);
            this._map.content.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onDragMC);
         }
         this._leave.addEventListener(MouseEvent.CLICK,this.onLeave);
         this._pet.addEventListener(MouseEvent.CLICK,this.onPet);
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         if(this._dragMC == null)
         {
            return;
         }
         this._dragMC.gotoAndPlay(2);
         this._followMC.gotoAndPlay(2);
      }
      
      private function onDragMC(param1:MouseEvent) : void
      {
         if(this._followMC == null)
         {
            return;
         }
         this._followMC.x = this._dragMC.x;
         this._followMC.y = this._dragMC.y;
         this._qiu.x = this._dragMC.x;
         this._qiu.y = this._dragMC.y;
      }
      
      private function onPet(param1:MouseEvent) : void
      {
         this.forwardFilter();
         if(this._fightState == 0)
         {
            FightManager.startFightWithWild(FIGHT_LIST[0]);
         }
      }
      
      private function onLeave(param1:MouseEvent) : void
      {
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function update() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function getData(param1:Parser_1142):void
         {
            _pet.gotoAndStop(param1.infoVec[0] - 15);
            _pet.visible = true;
            _pet.x = ActsHelperUtil.getRandom(50,1150);
            _pet.y = ActsHelperUtil.getRandom(60,600);
         });
      }
      
      private function forwardFilter() : void
      {
         this._fightState = 0;
         var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(_loc1_ != null)
         {
            if(_loc1_.hp == 0)
            {
               AlertManager.showAlert("首发精灵体力耗尽,暂时不可寻找,以防遇到对战不可进入战斗哦!");
               this._fightState = 1;
            }
         }
         else
         {
            AlertManager.showAlert("没有设置首发精灵,暂时不可寻找,以防遇到对战不可进入战斗哦!");
            this._fightState = 2;
         }
      }
      
      public function dispose() : void
      {
         this._leave.removeEventListener(MouseEvent.CLICK,this.onLeave);
         this._pet.removeEventListener(MouseEvent.CLICK,this.onPet);
         DisplayObjectUtil.removeFromParent(this._pet);
         if(Boolean(this._map.content) && Boolean(this._map.content.stage))
         {
            this._map.content.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onDragMC);
            this._map.content.stage.removeEventListener(MouseEvent.CLICK,this.onStageClick);
         }
         this._leave = null;
         if(this._dragMC)
         {
            this._dragMC.stopDrag();
            this._dragMC = null;
         }
         this._darkBg = null;
         this._pet = null;
         this._qiu = null;
         this._followMC = null;
      }
   }
}
