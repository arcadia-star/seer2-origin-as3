package com.taomee.seer2.app.processor.map
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.pet.SpawnedPet;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80397 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [205562];
      
      private static const DAY_LIST:Array = [1610,1611];
      
      private static const RES_ID:int = 658;
      
      private static var _par:Parser_1142;
      
      private static var _info:DayLimitListInfo;
       
      
      private var _timeUI:MovieClip;
      
      private var _scoreUI:MovieClip;
      
      private var _leftTim:TextField;
      
      private var _scroe:TextField;
      
      private var _leaveTime:int;
      
      private var _monsterList:Vector.<SpawnedPet>;
      
      public function MapProcessor_80397(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.onActInit();
      }
      
      private function onActInit() : void
      {
         this._timeUI = _map.front["timeUI"];
         this._scoreUI = _map.front["scoreUI"];
         this._leftTim = this._timeUI["leftTim"];
         this._scroe = this._scoreUI["scroe"];
         this.hideLobbyMenu();
         this.update();
      }
      
      private function update() : void
      {
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               var info:DayLimitListInfo = param1;
               _info = info;
               _par = par;
               Tick.instance.removeRender(timeUpdate);
               if(!BitUtil.getBit(_par.infoVec[0],0))
               {
                  _leaveTime = int(TimeManager.getPrecisionServerTime() >= _info.getCount(DAY_LIST[0]) ? 0 : _info.getCount(DAY_LIST[0]) - TimeManager.getPrecisionServerTime());
                  _leftTim.text = DateUtil.getMS(_leaveTime).toString();
                  if(_leaveTime > 0)
                  {
                     Tick.instance.addRender(timeUpdate,1000);
                     createMonster();
                  }
                  else
                  {
                     ServerMessager.addMessage("挑战失败喽!");
                     SceneManager.changeScene(SceneType.LOBBY,70);
                     TweenNano.delayedCall(2,function():void
                     {
                        ModuleManager.showAppModule("DragonChroniclesThreeSeasonPanel");
                     });
                  }
               }
               else
               {
                  ServerMessager.addMessage("恭喜过关喽!");
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(2,function():void
                  {
                     ModuleManager.showAppModule("DragonChroniclesThreeSeasonPanel");
                  });
               }
               _scroe.text = _info.getCount(DAY_LIST[1]).toString() + "/10";
            });
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function createMonster() : void
      {
         this.clearMonsterList();
         this._monsterList = new Vector.<SpawnedPet>();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this._monsterList.push(new FightBoss(RES_ID,1492,0));
            MobileManager.addMobile(this._monsterList[_loc1_],MobileType.SPAWNED_PET);
            _loc1_++;
         }
      }
      
      private function clearMonsterList() : void
      {
         var _loc1_:SpawnedPet = null;
         if(this._monsterList)
         {
            for each(_loc1_ in this._monsterList)
            {
               DisplayUtil.removeForParent(_loc1_);
            }
            this._monsterList = null;
         }
      }
      
      private function timeUpdate(param1:uint) : void
      {
         var val:uint = param1;
         --this._leaveTime;
         if(this._leaveTime <= 0)
         {
            Tick.instance.removeRender(this.timeUpdate);
            this.clearMonsterList();
            ServerMessager.addMessage("挑战失败喽!");
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(2,function():void
            {
               ModuleManager.showAppModule("DragonChroniclesThreeSeasonPanel");
            });
         }
         this._leftTim.text = DateUtil.getMS(this._leaveTime).toString();
      }
      
      private function onActDispose() : void
      {
         this.clearMonsterList();
         Tick.instance.removeRender(this.timeUpdate);
         this._timeUI = null;
         this._scoreUI = null;
         this._leftTim = null;
         this._scroe = null;
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}

import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.core.module.ModuleManager;

class FightBoss extends SpawnedPet
{
    
   
   public function FightBoss(param1:int, param2:int, param3:int)
   {
      super(param1,param2,param3);
   }
   
   override protected function startFight() : void
   {
      ModuleManager.showAppModule("PetSelectFightPanel",{
         "mode":7,
         "posIndex":1492,
         "min":1,
         "max":1
      });
   }
}
