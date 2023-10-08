package com.taomee.seer2.app.arena
{
   import com.taomee.seer2.app.arena.record.*;
   import com.taomee.seer2.app.arena.ui.ButtonPanelData;
   import com.taomee.seer2.app.gameRule.data.FighterSelectPanelVO;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.log.LogArea;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import org.taomee.ds.HashMap;
   
   public class FightManager extends EventDispatcher
   {
      
      public static var autoFightFlag:Boolean = false;
      
      private static var _fightRecords:HashMap = new HashMap();
      
      private static var _currentFightRecord:FightRecordData;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function FightManager()
      {
         super();
      }
      
      public static function get fightWinnerSide() : uint
      {
         return currentFightRecord.fightResult;
      }
      
      public static function getPositionIndex() : uint
      {
         return currentFightRecord.initData.positionIndex;
      }
      
      public static function isWinWar() : Boolean
      {
         return currentFightRecord.isWinWar();
      }
      
      public static function get endReason() : uint
      {
         return currentFightRecord.endReason;
      }
      
      public static function get currentFightRecord() : FightRecordData
      {
         if(_currentFightRecord == null)
         {
            _currentFightRecord = new FightRecordData(0,{},null);
         }
         return _currentFightRecord;
      }
      
      public static function getFightRecordData(param1:Number) : FightRecordData
      {
         return _fightRecords.getValue(param1);
      }
      
      public static function recordPvpInviate() : Number
      {
         return -1;
      }
      
      public static function startFightWithTrainMonster(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         LogArea.getInstance().addLog("1042协议发送战斗索引:" + param1);
         var _loc5_:IFightRequest;
         (_loc5_ = new TrainMonster(param2,param3)).startFight({
            "id":param1,
            "type":FightRecordData.FIGHT_TRAINER
         },param4);
         _fightRecords.add(_loc5_.uid,_loc5_.fightRecordData);
         _currentFightRecord = _loc5_.fightRecordData;
         return _loc5_.uid;
      }
      
      public static function startFightWithActivityBoss(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         LogArea.getInstance().addLog("1066协议发送战斗索引:" + param1);
         var _loc5_:IFightRequest;
         (_loc5_ = new ActivityBoss(param2,param3)).startFight({"bossId":param1},param4);
         _fightRecords.add(_loc5_.uid,_loc5_.fightRecordData);
         _currentFightRecord = _loc5_.fightRecordData;
         return _loc5_.uid;
      }
      
      public static function startFightWithGateMonster(param1:Function = null, param2:Function = null, param3:ButtonPanelData = null) : Number
      {
         var _loc4_:IFightRequest;
         (_loc4_ = new GateMonster(param1,param2)).startFight({},param3);
         _fightRecords.add(_loc4_.uid,_loc4_.fightRecordData);
         _currentFightRecord = _loc4_.fightRecordData;
         return _loc4_.uid;
      }
      
      public static function startSelectCountPetFight(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         var _loc5_:IFightRequest;
         (_loc5_ = new SelectPetCountFight(param2,param3)).startFight({"type":param1},param4);
         _fightRecords.add(_loc5_.uid,_loc5_.fightRecordData);
         _currentFightRecord = _loc5_.fightRecordData;
         return _loc5_.uid;
      }
      
      public static function startFightPVPWOHOO(param1:LittleEndianByteArray, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         var _loc5_:IFightRequest;
         (_loc5_ = new PVPWOHOOFight(param2,param3)).startFight({
            "type":FightRecordData.FIGHT_PVP_WOHOO,
            "data":param1
         },param4);
         _fightRecords.add(_loc5_.uid,_loc5_.fightRecordData);
         _currentFightRecord = _loc5_.fightRecordData;
         return _loc5_.uid;
      }
      
      public static function startFightPVPTrainer(param1:LittleEndianByteArray, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         var _loc5_:IFightRequest;
         (_loc5_ = new PVPTrainerMatchFight(param2,param3)).startFight({
            "type":FightRecordData.FIGHT_PVP_TRAINER,
            "data":param1
         },param4);
         _fightRecords.add(_loc5_.uid,_loc5_.fightRecordData);
         _currentFightRecord = _loc5_.fightRecordData;
         return _loc5_.uid;
      }
      
      public static function startFightPVP(param1:LittleEndianByteArray, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         var _loc5_:IFightRequest;
         (_loc5_ = new PVPTrainerMatchFight(param2,param3)).startFight({
            "type":FightRecordData.FIGHT_PVP,
            "data":param1
         },param4);
         _fightRecords.add(_loc5_.uid,_loc5_.fightRecordData);
         _currentFightRecord = _loc5_.fightRecordData;
         return _loc5_.uid;
      }
      
      public static function startFightBinaryWild(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null) : Number
      {
         var defaultPets:Vector.<PetInfo>;
         var UID:Number = NaN;
         var onSelectedFighter:Function = null;
         var positionIndex:uint = param1;
         var onStart:Function = param2;
         var onError:Function = param3;
         var btnPanelData:ButtonPanelData = param4;
         onSelectedFighter = function(param1:Vector.<uint>):void
         {
            var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
            _loc2_.writeUnsignedInt(param1.length);
            var _loc3_:uint = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_.writeUnsignedInt(param1[_loc3_]);
               _loc3_++;
            }
            Connection.send(CommandSet.SELECT_FIGHT_MONS_1192,_loc2_);
            startFightWithWild(positionIndex,onStart,onError,btnPanelData,UID);
         };
         var initData:FighterSelectPanelVO = new FighterSelectPanelVO();
         initData.minSelectedPetCount = 2;
         initData.maxSelectedPetCount = 2;
         initData.pets = PetInfoManager.getAllBagPetInfo();
         defaultPets = PetInfoManager.getRandomFightPetInfo(2);
         if(defaultPets.length < 2)
         {
            AlertManager.showAlert("您背包中的精灵少于2只！");
            return -1;
         }
         initData.defaultPets = defaultPets;
         initData.onComplete = onSelectedFighter;
         ModuleManager.showModule(URLUtil.getAppModule("FighterSelectPanel"),"正在打开精灵选择面板...",initData);
         UID = UUID.getUnique();
         return UID;
      }
      
      public static function startFightWithGudiePet(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null, param5:Number = -1, param6:int = 0) : Number
      {
         var _loc7_:IFightRequest = null;
         if(param1 == 100000)
         {
            _loc7_ = new GudieMonster2(param2,param3,param6);
         }
         else
         {
            _loc7_ = new GudieMonster(param2,param3);
         }
         _loc7_.startFight({
            "positionIndex":param1,
            "type":FightRecordData.FIGHT_GUDIE
         },param4,param5);
         _fightRecords.add(_loc7_.uid,_loc7_.fightRecordData);
         _currentFightRecord = _loc7_.fightRecordData;
         return _loc7_.uid;
      }
      
      public static function startFightWithWild(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null, param5:Number = -1) : Number
      {
         LogArea.getInstance().addLog("1500协议发送战斗索引:" + param1);
         var _loc6_:IFightRequest;
         (_loc6_ = new WildMonster(param2,param3)).startFight({
            "positionIndex":param1,
            "type":FightRecordData.FIGHT_WILD
         },param4,param5);
         _fightRecords.add(_loc6_.uid,_loc6_.fightRecordData);
         _currentFightRecord = _loc6_.fightRecordData;
         return _loc6_.uid;
      }
      
      public static function startFightWithBoss(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null, param5:Number = -1) : Number
      {
         LogArea.getInstance().addLog("1500协议发送战斗索引:" + param1);
         var _loc6_:IFightRequest;
         (_loc6_ = new WildMonster(param2,param3)).startFight({
            "positionIndex":param1,
            "type":FightRecordData.FIGHT_WILD,
            "bloodType":1
         },param4,param5);
         _fightRecords.add(_loc6_.uid,_loc6_.fightRecordData);
         _currentFightRecord = _loc6_.fightRecordData;
         return _loc6_.uid;
      }
      
      public static function startFightWithMiniBoss(param1:uint, param2:Function = null, param3:Function = null, param4:ButtonPanelData = null, param5:Number = -1) : Number
      {
         var _loc6_:IFightRequest;
         (_loc6_ = new WildMonster(param2,param3)).startFight({
            "positionIndex":param1,
            "type":FightRecordData.FIGHT_MINI_BOSS
         },param4,param5);
         _fightRecords.add(_loc6_.uid,_loc6_.fightRecordData);
         _currentFightRecord = _loc6_.fightRecordData;
         return _loc6_.uid;
      }
      
      public static function startFightWithFishBoss(param1:Function = null, param2:Function = null, param3:ButtonPanelData = null) : Number
      {
         var _loc4_:IFightRequest;
         (_loc4_ = new FishBoss(param1,param2)).startFight({},param3);
         _fightRecords.add(_loc4_.uid,_loc4_.fightRecordData);
         _currentFightRecord = _loc4_.fightRecordData;
         return _loc4_.uid;
      }
      
      public static function startFightBinarySPTBoss(param1:uint, param2:Array = null, param3:Function = null, param4:Function = null, param5:ButtonPanelData = null) : Number
      {
         var defaultPets:Vector.<PetInfo>;
         var UID:Number = NaN;
         var onSelectedFighter:Function = null;
         var bossId:uint = param1;
         var params:Array = param2;
         var onStart:Function = param3;
         var onError:Function = param4;
         var btnPanelData:ButtonPanelData = param5;
         onSelectedFighter = function(param1:Vector.<uint>):void
         {
            startFightWithSPTBoss(bossId,params,onStart,onError,btnPanelData,false,param1,UID);
         };
         var initData:FighterSelectPanelVO = new FighterSelectPanelVO();
         initData.minSelectedPetCount = 2;
         initData.maxSelectedPetCount = 2;
         initData.pets = PetInfoManager.getAllBagPetInfo();
         defaultPets = PetInfoManager.getRandomFightPetInfo(2);
         if(defaultPets.length < 2)
         {
            AlertManager.showAlert("您背包中的精灵少于2只！");
            return -1;
         }
         initData.defaultPets = defaultPets;
         initData.onComplete = onSelectedFighter;
         ModuleManager.showModule(URLUtil.getAppModule("FighterSelectPanel"),"正在打开精灵选择面板...",initData);
         UID = UUID.getUnique();
         return UID;
      }
      
      public static function startFightWithSPTBoss(param1:uint, param2:Array = null, param3:Function = null, param4:Function = null, param5:ButtonPanelData = null, param6:Boolean = true, param7:Vector.<uint> = null, param8:Number = -1) : Number
      {
         var _loc9_:IFightRequest;
         (_loc9_ = new SPTBoss(param3,param4)).startFight({
            "bossId":param1,
            "params":param2,
            "type":FightRecordData.FIGHT_BOSS,
            "singlePetFight":param6,
            "petIds":param7
         },param5,param8);
         _fightRecords.add(_loc9_.uid,_loc9_.fightRecordData);
         _currentFightRecord = _loc9_.fightRecordData;
         return _loc9_.uid;
      }
      
      public static function startFightWithNPC(param1:uint, param2:int = 0, param3:LittleEndianByteArray = null, param4:Function = null, param5:Function = null, param6:ButtonPanelData = null) : Number
      {
         var _loc7_:IFightRequest;
         (_loc7_ = new NPCBoss(param4,param5)).startFight({
            "positionIndex":param1,
            "count":param2,
            "lebData":param3
         },param6);
         _fightRecords.add(_loc7_.uid,_loc7_.fightRecordData);
         _currentFightRecord = _loc7_.fightRecordData;
         return _loc7_.uid;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:Event) : void
      {
         if(_dispatcher.hasEventListener(param1.type))
         {
            _dispatcher.dispatchEvent(param1);
         }
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
      
      public static function isFightRecordData(param1:String) : Boolean
      {
         if(currentFightRecord && currentFightRecord.initData && Boolean(currentFightRecord.initData.type) && currentFightRecord.initData.type == param1)
         {
            return true;
         }
         return false;
      }
      
      public static function isJustWinFight() : Boolean
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && isWinWar())
         {
            return true;
         }
         return false;
      }
   }
}
