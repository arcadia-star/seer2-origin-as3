package com.taomee.seer2.core.map
{
   import com.taomee.seer2.core.map.grids.GameMap;
   import com.taomee.seer2.core.scene.BaseMapLoader;
   import com.taomee.seer2.core.scene.MapAssetExtractor;
   import com.taomee.seer2.core.scene.MapConfigurator;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.SwitchData;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import org.taomee.algo.IMapModel;
   
   public class MapModel extends EventDispatcher implements IMapModel
   {
       
      
      protected var _id:int;
      
      protected var _resourceId:int;
      
      protected var _name:String;
      
      protected var _sceneType:int;
      
      protected var _initPoint:Point;
      
      protected var _isComplete:Boolean;
      
      protected var _configXml:XML;
      
      protected var _libManager:ResourceLibrary;
      
      protected var _assetExtractor:MapAssetExtractor;
      
      protected var _mapProcessor:MapProcessor;
      
      protected var _mapConfigurator:MapConfigurator;
      
      protected var _userBehavior:int;
      
      protected var _gm:GameMap;
      
      public function MapModel(param1:SwitchData, param2:BaseMapLoader)
      {
         super();
         this._configXml = param2.configXml;
         this._libManager = param2.libManager;
         this.parseSwitchData(param1);
         if(param2.mapResource)
         {
            this._assetExtractor = new MapAssetExtractor(param2.mapResource);
         }
         this._mapConfigurator = new MapConfigurator(this);
         this._isComplete = false;
      }
      
      protected function parseSwitchData(param1:SwitchData) : void
      {
         var _loc2_:XML = null;
         this._id = param1.mapId;
         this._sceneType = param1.sceneType;
         this._resourceId = param1.resourceId;
         this._userBehavior = param1.userBehavior;
         if(SceneType.hasPath(this._sceneType))
         {
            if(param1.postion == null)
            {
               this._initPoint = new Point();
               _loc2_ = this._configXml.elements("initialPoint")[0];
               this._initPoint.x = int(_loc2_.attribute("x").toString());
               this._initPoint.y = int(_loc2_.attribute("y").toString());
            }
            else
            {
               this._initPoint = param1.postion;
            }
         }
      }
      
      public function init() : void
      {
         this.extract();
         this.config();
      }
      
      private function extract() : void
      {
         this._assetExtractor.extract();
         if(SceneType.hasPath(this.sceneType))
         {
            this._assetExtractor.extractPath();
         }
      }
      
      private function config() : void
      {
         this._mapConfigurator.config();
      }
      
      public function complete() : void
      {
         this._mapProcessor = MapProcessor.createMapProcessor(this);
         this._mapProcessor.init();
         this._isComplete = true;
         dispatchEvent(new SceneEvent(SceneEvent.MAP_COMPLETE));
      }
      
      public function dispose() : void
      {
         this._mapProcessor.dispose();
         this._mapConfigurator.dispose();
         this._assetExtractor.dispose();
         this._isComplete = false;
      }
      
      public function canWalk(param1:int, param2:int) : Boolean
      {
         var _loc3_:int = int(param1 / this.gridSize);
         var _loc4_:int = int(param2 / this.gridSize);
         if(_loc3_ < 0 || _loc3_ >= this._assetExtractor.gridX)
         {
            return false;
         }
         if(_loc4_ < 0 || _loc4_ >= this._assetExtractor.gridY)
         {
            return false;
         }
         return this.data[_loc3_][_loc4_];
      }
      
      public function recalculatePathData() : void
      {
         if(SceneType.hasPath(this.sceneType))
         {
            this._assetExtractor.extractPath();
         }
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get resourceId() : int
      {
         return this._resourceId;
      }
      
      public function get userBehavior() : int
      {
         return this._userBehavior;
      }
      
      public function get fightMapId() : int
      {
         var _loc1_:XML = this._configXml.elements("fightMap")[0];
         if(_loc1_)
         {
            return uint(_loc1_.attribute("id").toString());
         }
         return 0;
      }
      
      public function get categoryId() : uint
      {
         if(this._configXml.hasOwnProperty("categoryId") != null)
         {
            return int(this._configXml.attribute("categoryId"));
         }
         return 0;
      }
      
      public function get sceneType() : int
      {
         return this._sceneType;
      }
      
      public function get name() : String
      {
         if(this._name == null)
         {
            return this._configXml.attribute("name").toString();
         }
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get isComplete() : Boolean
      {
         return this._isComplete;
      }
      
      public function get weather() : uint
      {
         if(this._configXml.hasOwnProperty("weather") != null)
         {
            return int(this._configXml.attribute("weather"));
         }
         return 0;
      }
      
      public function get checkable() : Boolean
      {
         var _loc1_:uint = uint(this._configXml.attribute("checkable"));
         if(_loc1_ == 0)
         {
            return false;
         }
         return true;
      }
      
      public function get initialPoint() : Point
      {
         return this._initPoint;
      }
      
      public function set x(param1:Number) : void
      {
         this._assetExtractor.x = param1;
      }
      
      public function set y(param1:Number) : void
      {
         this._assetExtractor.y = param1;
      }
      
      public function get x() : Number
      {
         return this._assetExtractor.x;
      }
      
      public function get y() : Number
      {
         return this._assetExtractor.y;
      }
      
      public function get width() : int
      {
         return this._assetExtractor.width;
      }
      
      public function get height() : int
      {
         return this._assetExtractor.height;
      }
      
      public function get gridSize() : uint
      {
         return this._assetExtractor.gridSize;
      }
      
      public function get gridX() : uint
      {
         return this._assetExtractor.gridX;
      }
      
      public function get gridY() : uint
      {
         return this._assetExtractor.gridY;
      }
      
      public function get data() : Array
      {
         return this._assetExtractor.data;
      }
      
      public function get front() : Sprite
      {
         return this._assetExtractor.front;
      }
      
      public function get content() : Sprite
      {
         return this._assetExtractor.content;
      }
      
      public function get ground() : Sprite
      {
         return this._assetExtractor.ground;
      }
      
      public function get far() : Sprite
      {
         return this._assetExtractor.far;
      }
      
      public function get path() : Sprite
      {
         return this._assetExtractor.path;
      }
      
      public function get assetExtractor() : MapAssetExtractor
      {
         return this._assetExtractor;
      }
      
      public function get configXml() : XML
      {
         return this._configXml;
      }
      
      public function get libManager() : ResourceLibrary
      {
         return this._libManager;
      }
      
      public function get mapProcessor() : MapProcessor
      {
         return this._mapProcessor;
      }
      
      public function get gameMap() : GameMap
      {
         return this._gm;
      }
   }
}
