package com.taomee.seer2.core.scene
{
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.map.BigMapModel;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.sound.SoundManager;
   import flash.events.EventDispatcher;
   
   public class SceneManager
   {
      
      private static var _currentScene:com.taomee.seer2.core.scene.BaseScene;
      
      private static var _preSceneType:int;
      
      private static var _preMapId:int;
      
      private static var _isSwitching:Boolean = false;
      
      private static var _switchData:com.taomee.seer2.core.scene.SwitchData;
      
      private static var _callBack:Function;
      
      private static var _dispatcher:EventDispatcher = new EventDispatcher();
       
      
      public function SceneManager()
      {
         super();
      }
      
      public static function changeScene(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:int = 0, param7:Function = null) : void
      {
         if(SceneManager.active && SceneManager.active.type == param1 && SceneManager.active.mapID == param2)
         {
            if(null != param7)
            {
               param7();
            }
            return;
         }
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MAP_ID,"\n跳转地图: " + SceneType.getTypeName(param1) + " mapID=" + param2);
         var _loc8_:com.taomee.seer2.core.scene.SwitchData = new com.taomee.seer2.core.scene.SwitchData(param1,param2,param3,param4,param5,param6);
         if(vaildateSwitch(_loc8_))
         {
            _isSwitching = true;
            preprocessSwitch(_loc8_);
            _callBack = param7;
         }
      }
      
      private static function vaildateSwitch(param1:com.taomee.seer2.core.scene.SwitchData) : Boolean
      {
         if(_isSwitching)
         {
            return false;
         }
         if(!param1.isSkipValidate)
         {
            return SwitchValidator.validateRepeat(param1) && SwitchValidator.validateChangeable(param1);
         }
         return true;
      }
      
      private static function preprocessSwitch(param1:com.taomee.seer2.core.scene.SwitchData) : void
      {
         ModuleManager.closeAll();
         var _loc2_:SwitchPreProcessor = SceneTypeFactory.createSwitchPreProcessor(param1.sceneType);
         _loc2_.process(param1,loadMap);
      }
      
      private static function loadMap(param1:com.taomee.seer2.core.scene.SwitchData) : void
      {
         _switchData = param1;
         var _loc2_:BaseMapLoader = SceneTypeFactory.createMapLoader(param1.sceneType);
         _loc2_.load(_switchData.resourceId);
         _loc2_.addEventListener(SceneEvent.LOAD_ERROR,onLoadError);
         _loc2_.addEventListener(SceneEvent.LOAD_COMPLETE,onLoadComplete);
         dispatchEvent(SceneEvent.SWITCH_START);
      }
      
      private static function onLoadError(param1:SceneEvent) : void
      {
         var _loc2_:MapLoader = param1.currentTarget as MapLoader;
         clearMapLoader(_loc2_);
         processSwitchComplete();
         dispatchEvent(SceneEvent.SWITCH_ERROR);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MAP_ID," 跳转出错了···");
      }
      
      private static function onLoadComplete(param1:SceneEvent) : void
      {
         var _loc2_:BaseMapLoader = param1.currentTarget as BaseMapLoader;
         processLoaderComplete(_loc2_);
         clearMapLoader(_loc2_);
      }
      
      private static function clearMapLoader(param1:BaseMapLoader) : void
      {
         param1.removeEventListener(SceneEvent.LOAD_ERROR,onLoadError);
         param1.removeEventListener(SceneEvent.LOAD_COMPLETE,onLoadComplete);
         param1.dispose();
      }
      
      private static function processLoaderComplete(param1:BaseMapLoader) : void
      {
         var _loc2_:MapModel = null;
         var _loc3_:com.taomee.seer2.core.scene.BaseScene = null;
         recordPrevInfo();
         if(_switchData.switchType == com.taomee.seer2.core.scene.SwitchData.SWITCH_SCENE)
         {
            if(_currentScene)
            {
               _currentScene.dispose();
            }
            _loc3_ = SceneTypeFactory.createScene(_switchData.sceneType);
            _loc3_.init();
            _currentScene = _loc3_;
         }
         if(_switchData.sceneType == SceneType.BIG_LOBBY)
         {
            _loc2_ = new BigMapModel(_switchData,param1);
         }
         else
         {
            _loc2_ = new MapModel(_switchData,param1);
         }
         _loc2_.addEventListener(SceneEvent.MAP_COMPLETE,onMapComplete);
         _currentScene.updateMap(_loc2_);
      }
      
      private static function recordPrevInfo() : void
      {
         _preSceneType = !!_currentScene ? _currentScene.type : SceneType.NULL;
         _preMapId = Boolean(_currentScene) && Boolean(_currentScene.mapModel) ? _currentScene.mapID : 0;
      }
      
      private static function onMapComplete(param1:SceneEvent) : void
      {
         var _loc2_:MapModel = param1.currentTarget as MapModel;
         _loc2_.removeEventListener(SceneEvent.MAP_COMPLETE,onMapComplete);
         processSwitchComplete();
         if(null != _callBack)
         {
            _callBack();
            _callBack = null;
         }
         dispatchEvent(SceneEvent.SWITCH_COMPLETE);
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.MAP_ID," name=\"" + _loc2_.name + "\"");
      }
      
      private static function processSwitchComplete() : void
      {
         _isSwitching = false;
         _switchData = null;
         if(currentSceneType == SceneType.ARENA || currentSceneType == SceneType.GUDIE_ARENA || currentSceneType == SceneType.GUDIE_ARENA2 || currentSceneType == SceneType.GUDIE_ARENA3 || currentSceneType == SceneType.GUDIE_ARENA5 || currentSceneType == SceneType.GUDIE_ARENA4 || currentSceneType == SceneType.GUIDE_NEW_ARENA1 || currentSceneType == SceneType.GUIDE_NEW_ARENA2 || currentSceneType == SceneType.GUIDE_NEW_ARENA3)
         {
            SoundManager.backgroundSoundEnabled = false;
         }
         else
         {
            SoundManager.backgroundSoundEnabled = true;
         }
      }
      
      public static function get active() : com.taomee.seer2.core.scene.BaseScene
      {
         return _currentScene;
      }
      
      public static function get currentSceneType() : int
      {
         return !!_currentScene ? _currentScene.type : SceneType.NULL;
      }
      
      public static function get prevSceneType() : int
      {
         return _preSceneType;
      }
      
      public static function get prevMapID() : int
      {
         return _preMapId;
      }
      
      public static function get isSwitching() : Boolean
      {
         return _isSwitching;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2,param3);
      }
      
      public static function dispatchEvent(param1:String) : void
      {
         if(_dispatcher.hasEventListener(param1))
         {
            _dispatcher.dispatchEvent(new SceneEvent(param1));
         }
      }
      
      public static function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher.hasEventListener(param1);
      }
   }
}
