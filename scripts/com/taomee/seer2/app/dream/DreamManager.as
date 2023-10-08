package com.taomee.seer2.app.dream
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dream.events.DreamEvent;
   import com.taomee.seer2.app.dream.handler.DreamEntryProcessor;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.log.Logger;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DateUtil;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.net.SharedObject;
   import flash.system.ApplicationDomain;
   import org.taomee.bean.BaseBean;
   
   public class DreamManager extends BaseBean
   {
      
      private static const DREAM_MAP:Array = [137,138,139,221,222,223];
      
      private static const DREAM_ENTRY_MAP:Array = [131,203];
      
      private static const COINS_TYPE:uint = 1;
      
      public static const DREAM_LIMIT:int = 5;
      
      public static var closeEye:MovieClip;
      
      public static var openEye:MovieClip;
      
      public static var dreamNpcCategoryID:uint;
      
      private static var _eventDispatcher:EventDispatcher;
      
      private static var _logger:Logger;
      
      private static var _currentTaskId:uint;
      
      private static var _currentDreamNpcID:uint;
      
      private static var _dreamEntryProcessor:DreamEntryProcessor;
       
      
      public function DreamManager()
      {
         super();
      }
      
      public static function isDreamMap() : Boolean
      {
         if(SceneManager.active)
         {
            return DreamManager.DREAM_MAP.indexOf(SceneManager.active.mapID) != -1;
         }
         return false;
      }
      
      private static function onMapComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active && SceneManager.active.type == SceneType.LOBBY && isDreamEntryMap())
         {
            (SceneManager.active as LobbyScene).showToolbar();
            processDreamReward();
            if(DateUtil.isNight())
            {
               _dreamEntryProcessor = createDreamEntryProcessor();
            }
         }
      }
      
      private static function onMapStart(param1:SceneEvent) : void
      {
         if(_dreamEntryProcessor)
         {
            _dreamEntryProcessor.dispose();
            _dreamEntryProcessor = null;
         }
      }
      
      private static function createDreamEntryProcessor() : DreamEntryProcessor
      {
         var _loc1_:Class = ApplicationDomain.currentDomain.getDefinition("com.taomee.seer2.app.dream.handler.DreamEntryProcessor_" + SceneManager.active.mapResourceID) as Class;
         return DreamEntryProcessor(new _loc1_());
      }
      
      private static function isDreamEntryMap() : Boolean
      {
         return DREAM_ENTRY_MAP.indexOf(SceneManager.active.mapID) != -1;
      }
      
      private static function initialize() : void
      {
         _eventDispatcher = new EventDispatcher();
         _logger = Logger.getLogger("DreamManager");
         initDreamStatus();
      }
      
      private static function initDreamStatus() : void
      {
         _currentTaskId = 0;
         _currentDreamNpcID = 0;
         dreamNpcCategoryID = 0;
      }
      
      public static function isDreamingAvalueable() : Boolean
      {
         if(getAvailableDreamTime() <= 0)
         {
            return false;
         }
         return true;
      }
      
      public static function processDreamReward() : void
      {
         if(DreamManager.currentTaskId != 0)
         {
            Connection.addErrorHandler(CommandSet.GET_DREAM_REWAED_1053,onGetDreamRewardError);
            Connection.addCommandListener(CommandSet.GET_DREAM_REWAED_1053,onGetDreamReward);
            Connection.send(CommandSet.GET_DREAM_REWAED_1053,dreamNpcCategoryID,currentTaskId);
            DreamManager.currentTaskId = 0;
         }
      }
      
      private static function onGetDreamRewardError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.GET_DREAM_REWAED_1053,onGetDreamReward);
         Connection.removeErrorHandler(CommandSet.GET_DREAM_REWAED_1053,onGetDreamRewardError);
         if(param1.message.statusCode == 66)
         {
            AlertManager.showAlert("嘘，让它做个好梦吧！今天就别打扰喽！");
            DreamManager.addDreamNum(DreamManager.DREAM_LIMIT);
         }
      }
      
      private static function onGetDreamReward(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.GET_DREAM_REWAED_1053,onGetDreamRewardError);
         Connection.removeCommandListener(CommandSet.GET_DREAM_REWAED_1053,onGetDreamReward);
         DreamManager.addDreamNum();
      }
      
      private static function getAvailableDreamTime() : int
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.DREAMING);
         var _loc2_:String = generateDateKey();
         var _loc3_:String = generateDreamerKey();
         if(_loc1_.data[_loc2_] == null)
         {
            resetSharedObject(_loc1_,_loc2_);
         }
         var _loc4_:Object;
         if((_loc4_ = _loc1_.data[_loc2_][_loc3_]) == null)
         {
            (_loc4_ = new Object()).dreamNum = 0;
            _loc1_.data[_loc2_][_loc3_] = _loc4_;
            SharedObjectManager.flush(_loc1_);
         }
         return DREAM_LIMIT - _loc4_.dreamNum;
      }
      
      public static function addDreamNum(param1:int = 1) : void
      {
         var _loc2_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.DREAMING);
         var _loc3_:String = generateDateKey();
         var _loc4_:String = generateDreamerKey();
         var _loc5_:Object;
         if((_loc5_ = _loc2_.data[_loc3_][_loc4_]) == null)
         {
            _loc5_ = new Object();
            _loc2_.data[_loc3_][_loc4_] = _loc5_;
         }
         _loc5_.dreamNum += param1;
         SharedObjectManager.flush(_loc2_);
      }
      
      public static function set currentDreamNpcID(param1:uint) : void
      {
         _currentDreamNpcID = param1;
      }
      
      public static function get currentDreamNpcID() : uint
      {
         return _currentDreamNpcID;
      }
      
      public static function set currentTaskId(param1:uint) : void
      {
         _currentTaskId = param1;
      }
      
      public static function get currentTaskId() : uint
      {
         return _currentTaskId;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchDreamEvent(param1:String) : void
      {
         if(_eventDispatcher.hasEventListener(param1))
         {
            _eventDispatcher.dispatchEvent(new DreamEvent(param1));
         }
      }
      
      private static function resetSharedObject(param1:SharedObject, param2:String) : void
      {
         param1.clear();
         param1.data[param2] = new Object();
         SharedObjectManager.flush(param1);
      }
      
      private static function generateDateKey() : String
      {
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         return Connection.netType.toString() + _loc1_.fullYear + "_" + _loc1_.month + "_" + _loc1_.date;
      }
      
      private static function generateDreamerKey() : String
      {
         return ActorManager.getActor().getInfo().id.toString() + DreamManager.dreamNpcCategoryID.toString();
      }
      
      override public function start() : void
      {
         initialize();
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onMapComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onMapStart);
         finish();
      }
   }
}
