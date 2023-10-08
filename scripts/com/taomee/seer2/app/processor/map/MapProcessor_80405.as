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
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
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
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import org.taomee.utils.BitUtil;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class MapProcessor_80405 extends MapProcessor
   {
      
      private static const FOR_LIST:Array = [205662,205659];
      
      private static const DAY_LIST:Array = [1638];
      
      private static const FIGHT_INDEX:Vector.<uint> = Vector.<uint>([1514,1515]);
      
      private static const RES_ID_LIST:Vector.<int> = Vector.<int>([644,644]);
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605521]);
      
      private static var _par:Parser_1142;
      
      private static var _info:DayLimitListInfo;
       
      
      private var _timeUI:MovieClip;
      
      private var _scoreUI:MovieClip;
      
      private var _leftTim:TextField;
      
      private var _scroe:TextField;
      
      private var _miPass:SimpleButton;
      
      private var _leaveTime:int;
      
      private var _monsterList:Vector.<SpawnedPet>;
      
      public function MapProcessor_80405(param1:MapModel)
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
         this._miPass = _map.front["miPass"];
         this.hideLobbyMenu();
         this.update();
      }
      
      private function update() : void
      {
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
            {
               var par:Parser_1142 = param1;
               if(_par == null)
               {
                  _par = par;
               }
               else
               {
                  if(_par.infoVec[1] < par.infoVec[1])
                  {
                     ServerMessager.addMessage("恭喜本次挑战获得" + (par.infoVec[1] - _par.infoVec[1]) + "分哦!");
                  }
                  _par = par;
               }
               if(TimeManager.getPrecisionServerTime() >= info.getCount(DAY_LIST[0]))
               {
                  _leaveTime = 0;
               }
               else
               {
                  _leaveTime = info.getCount(DAY_LIST[0]) - TimeManager.getPrecisionServerTime();
               }
               _leftTim.text = DateUtil.getMS(_leaveTime).toString();
               Tick.instance.removeRender(timeUpdate);
               if(_leaveTime > 0)
               {
                  Tick.instance.addRender(timeUpdate,1000);
               }
               if(BitUtil.getBit(_par.infoVec[0],0))
               {
                  _miPass.visible = false;
                  ServerMessager.addMessage("恭喜通关喽!");
                  SceneManager.changeScene(SceneType.LOBBY,70);
                  TweenNano.delayedCall(2,function():void
                  {
                     ModuleManager.showAppModule("WorldKingFirstPanel");
                  });
               }
               else
               {
                  _miPass.visible = true;
                  if(_leaveTime > 0)
                  {
                     createMonster();
                  }
               }
               _miPass.addEventListener(MouseEvent.CLICK,onMiPass);
               _scroe.text = _par.infoVec[1].toString();
            });
         });
      }
      
      private function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      private function onMiPass(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ShopManager.buyItemForId(MI_ID_LIST[0],function():void
         {
            ServerMessager.addMessage("恭喜通关喽!");
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(2,function():void
            {
               ModuleManager.showAppModule("WorldKingFirstPanel");
            });
         });
      }
      
      private function createMonster() : void
      {
         var _loc1_:int = 0;
         this.clearMonsterList();
         this._monsterList = new Vector.<SpawnedPet>();
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ActsHelperUtil.getRandom(0,1);
            this._monsterList.push(new SpawnedPet(RES_ID_LIST[_loc1_],FIGHT_INDEX[_loc1_],0));
            MobileManager.addMobile(this._monsterList[_loc2_],MobileType.SPAWNED_PET);
            _loc2_++;
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
            AlertManager.showAlert("时间到了！",function():void
            {
               SceneManager.changeScene(SceneType.LOBBY,70);
               TweenNano.delayedCall(2,function():void
               {
                  ModuleManager.showAppModule("WorldKingFirstGetPowerPanel");
               });
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
         if(this._miPass)
         {
            this._miPass.removeEventListener(MouseEvent.CLICK,this.onMiPass);
            this._miPass = null;
         }
      }
      
      override public function dispose() : void
      {
         this.onActDispose();
         super.dispose();
      }
   }
}
