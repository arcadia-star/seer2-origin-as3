package com.taomee.seer2.core.map.grids
{
   import com.taomee.seer2.core.entity.PathMobile;
   import com.taomee.seer2.core.scene.BaseMapLoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class GameMap extends BaseDisplayObject
   {
       
      
      public var playerList:Array;
      
      private var _player:HeptaFishCharacter;
      
      private var _mapWidth:Number;
      
      private var _mapHeight:Number;
      
      private var _cellWidth:Number;
      
      private var _cellHeight:Number;
      
      private var _itemArr:Array;
      
      private var _mapArr:Array;
      
      private var _mapDArr:Array;
      
      private var _mapXML:XML;
      
      private var _row:int;
      
      private var _col:int;
      
      private var _pathIndex:int;
      
      private var _mapLayer:MapLayer;
      
      private var _buildLayer:BuildingLayer;
      
      private var _gridLayer:GridLayer;
      
      private var _roadPointLayer:RoadPointLayer;
      
      private var _initPlayerPoint:Point;
      
      private var _roadSeeker:RoadSeeker;
      
      private var _roadArr:Array;
      
      private var _roadMap:HashMap;
      
      private var _app:Sprite;
      
      private var _bitmapData:BitmapData;
      
      private var _targetPoint:Point;
      
      private var _curtPoint:Point;
      
      public function GameMap(param1:BaseMapLoader, param2:Point = null)
      {
         this.playerList = new Array();
         this._roadMap = new HashMap();
         super();
         this._app = LayerManager.root;
         this._mapXML = param1.dataXml;
         this._bitmapData = param1.mapBitmapData;
         this.name = this._mapXML.@name;
         this._initPlayerPoint = param2 || new Point(30,80);
         this._mapWidth = this._mapXML.@mapwidth;
         this._mapHeight = this._mapXML.@mapheight;
         this._cellWidth = this._mapXML.floor.@tileWidth;
         this._cellHeight = this._mapXML.floor.@tileHeight;
         this._mapArr = GameMapUtils.getArrByStr(this._mapXML.floor,this._mapXML.floor.@col,this._mapXML.floor.@row);
         this._row = this._mapArr.length;
         this._col = this._mapArr[0].length;
         this._mapDArr = GameMapUtils.getDArrayByArr(this._mapArr,this._row,this._col,this._roadMap);
         this._roadSeeker = new RoadSeeker(this._mapDArr,this._cellWidth,this._cellHeight * 2);
      }
      
      public function initMap() : void
      {
         this._mapLayer = new MapLayer(this);
         this._buildLayer = new BuildingLayer(this);
         this._buildLayer.mouseEnabled = false;
         this._buildLayer.mouseChildren = false;
         this._mapLayer.initMapLayer(this._bitmapData);
         this._buildLayer.drawByXml(this._mapXML);
         this.sortBuild();
      }
      
      private function sortBuild() : void
      {
         var _loc2_:GameMapItem = null;
         var _loc3_:int = 0;
         var _loc4_:GameMapItem = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._buildLayer.buildingArray.length)
         {
            _loc2_ = this._buildLayer.buildingArray[_loc1_];
            _loc3_ = 0;
            while(_loc3_ < this._buildLayer.buildingArray.length)
            {
               _loc4_ = this._buildLayer.buildingArray[_loc3_];
               if(_loc2_.y > _loc4_.y)
               {
                  if(this._buildLayer.getChildIndex(_loc2_ as DisplayObject) < this._buildLayer.getChildIndex(_loc4_ as DisplayObject))
                  {
                     this._buildLayer.swapChildren(_loc2_,_loc4_);
                  }
               }
               else if(this._buildLayer.getChildIndex(_loc2_ as DisplayObject) > this._buildLayer.getChildIndex(_loc4_ as DisplayObject))
               {
                  this._buildLayer.swapChildren(_loc2_,_loc4_);
               }
               _loc3_++;
            }
            _loc1_++;
         }
      }
      
      public function setControlPlayer(param1:int = 0) : void
      {
         if(this.playerList.length > 0)
         {
            this._player = this.playerList[param1];
            this._player.mapEle = this;
            this._player.x = this._initPlayerPoint.x;
            this._player.y = this._initPlayerPoint.y;
         }
      }
      
      public function addPlayer(param1:HeptaFishCharacter) : void
      {
         this.playerList.push(param1);
         param1.mapEle = this;
         param1.x = this._initPlayerPoint.x;
         param1.y = this._initPlayerPoint.y;
         this._buildLayer.addChild(param1 as DisplayObject);
      }
      
      private function mapLayerLoaded(param1:Event) : void
      {
      }
      
      public function walk(param1:PathMobile, param2:Point, param3:Point) : void
      {
         var _loc10_:int = 0;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:Point = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Array = null;
         this._curtPoint = param2;
         this._targetPoint = param3;
         var _loc4_:Point;
         var _loc5_:int = (_loc4_ = GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param3.x,param3.y,this._row)).x;
         var _loc6_:int = _loc4_.y;
         var _loc7_:Point;
         var _loc8_:int = (_loc7_ = GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x,param1.y - this._cellHeight,this._row)).x;
         var _loc9_:int = _loc7_.y;
         var _loc11_:Point = GameMapUtils.getMaxDirectPoint(this._row,this._col);
         if(_loc5_ >= 0 && _loc5_ < _loc11_.x && _loc6_ >= 0 && _loc6_ < _loc11_.y && this._roadSeeker.value(_loc5_,_loc6_) == 0)
         {
            this._roadArr = this._roadSeeker.path8(new Point(_loc8_,_loc9_),new Point(_loc5_,_loc6_));
            if((_loc10_ = int(this._roadSeeker.path.length)) > 0)
            {
               param1.runInBigMapToLocation(this.roadArrToPointArr(this._roadArr),param3.x,param3.y);
            }
            else if(_loc10_ == 0)
            {
               _loc12_ = [GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x - this._cellWidth,param1.y - this._cellHeight,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x - this._cellWidth / 2,param1.y - this._cellHeight - this._cellHeight / 2,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x,param1.y,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x + this._cellWidth / 2,param1.y - this._cellHeight - this._cellHeight / 2,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x + this._cellWidth,param1.y - this._cellHeight,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x + this._cellWidth / 2,param1.y - this._cellHeight + this._cellHeight / 2,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x,param1.y - this._cellHeight + this._cellHeight / 2,this._row),GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1.x - this._cellWidth / 2,param1.y - this._cellHeight + this._cellHeight / 2,this._row)];
               _loc13_ = 0;
               while(_loc13_ < _loc12_.length)
               {
                  _loc15_ = int(_loc12_[_loc13_].x);
                  _loc16_ = int(_loc12_[_loc13_].y);
                  if((_loc17_ = this._roadSeeker.path8(new Point(_loc15_,_loc16_),new Point(_loc5_,_loc6_))).length > 0)
                  {
                     param1.runInBigMapToLocation(this.roadArrToPointArr(this._roadArr),param3.x,param3.y);
                     break;
                  }
                  _loc13_++;
               }
               _loc14_ = new Point();
            }
         }
      }
      
      private function roadArrToPointArr(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Point = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 1;
         while(_loc3_ < param1.length - 1)
         {
            _loc4_ = int(this._roadMap.getValue(this._roadSeeker.path[_loc3_].y + "-" + this._roadSeeker.path[_loc3_].x).px);
            _loc5_ = int(this._roadMap.getValue(this._roadSeeker.path[_loc3_].y + "-" + this._roadSeeker.path[_loc3_].x).py);
            _loc6_ = GameMapUtils.getPixelPoint(this._cellWidth,this._cellHeight,_loc4_,_loc5_);
            _loc2_.push(new Point(_loc6_.x,_loc6_.y + this._cellHeight));
            _loc3_++;
         }
         _loc2_.unshift(this._curtPoint);
         _loc2_.push(this._targetPoint);
         return _loc2_;
      }
      
      private function checkDiff(param1:int, param2:int) : int
      {
         return int((param1 - param2) * Math.tan(30 / 180 * 3.14));
      }
      
      public function canWalk(param1:int, param2:int) : Boolean
      {
         var _loc3_:Point = GameMapUtils.getDirectPointByPixel(this._cellWidth,this._cellHeight,param1,param2,this._row);
         var _loc4_:int = _loc3_.x;
         var _loc5_:int = _loc3_.y;
         return this._roadSeeker.value(_loc4_,_loc5_) == 0 ? true : false;
      }
      
      public function sortDepth(param1:Array) : void
      {
         var _loc6_:Point = null;
         var _loc8_:DisplayObject = null;
         var _loc10_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc7_:Boolean = false;
         var _loc9_:uint = 0;
         while(_loc9_ < param1.length)
         {
            _loc8_ = param1[_loc9_];
            if(this._buildLayer.hitTestObject(_loc8_ as DisplayObject))
            {
               for each(_loc10_ in this._buildLayer.buildingArray)
               {
                  if(_loc10_ is GameMapItem && Boolean(_loc10_.bitMap))
                  {
                     if(_loc10_.bitMap.hitTestObject(_loc8_ as DisplayObject))
                     {
                        if(_loc10_.configXml.walkable.@left_k != null && _loc10_.configXml.walkable.@right_k != null && _loc10_.configXml.walkable.@origin_x != null && Boolean(_loc10_.configXml.walkable.@origin_y))
                        {
                           _loc4_ = Number(_loc10_.configXml.walkable.@left_k);
                           _loc5_ = Number(_loc10_.configXml.walkable.@right_k);
                           _loc3_ = -((_loc6_ = new Point(Number(_loc10_.configXml.walkable.@origin_x) + _loc10_.x,Number(_loc10_.configXml.walkable.@origin_y) + _loc10_.y)).y - _loc8_.y) / (_loc6_.x - _loc8_.x);
                           _loc7_ = true;
                        }
                        else
                        {
                           _loc7_ = false;
                        }
                        _loc11_ = this._buildLayer.getChildIndex(_loc8_ as DisplayObject);
                        _loc12_ = this._buildLayer.getChildIndex(_loc10_);
                        if(_loc8_.y < _loc10_.y + _loc10_.bitMap.height)
                        {
                           if(_loc7_)
                           {
                              if(_loc3_ < 0 && _loc3_ < _loc4_ || _loc3_ > 0 && _loc3_ > _loc5_)
                              {
                                 if(_loc11_ > _loc12_)
                                 {
                                    this._buildLayer.addChildAt(_loc8_,_loc12_);
                                 }
                              }
                              else if(_loc11_ < _loc12_)
                              {
                                 this._buildLayer.addChildAt(_loc8_,_loc12_ + 1);
                              }
                           }
                           else if(_loc11_ > _loc12_)
                           {
                              this._buildLayer.addChildAt(_loc8_,_loc12_);
                           }
                        }
                        else if(_loc11_ < _loc12_)
                        {
                           this._buildLayer.addChildAt(_loc8_,_loc12_ + 1);
                        }
                     }
                  }
               }
            }
            _loc9_++;
         }
         param1.length = 0;
         param1 = null;
      }
      
      public function dispose() : void
      {
         this._itemArr.length = 0;
         this._itemArr = null;
         this._mapArr.length = 0;
         this._mapArr = null;
         this._mapDArr.length = 0;
         this._mapDArr = null;
         this._mapLayer.dispose();
         this._buildLayer.dispose();
         this._bitmapData.dispose();
         this._bitmapData = null;
         this._mapXML = null;
      }
      
      public function get cellWidth() : Number
      {
         return this._cellWidth;
      }
      
      public function get cellHeight() : Number
      {
         return this._cellHeight;
      }
      
      public function get mapWidth() : Number
      {
         return this._mapWidth;
      }
      
      public function get mapHeight() : Number
      {
         return this._mapHeight;
      }
      
      public function get mapXML() : XML
      {
         return this._mapXML;
      }
      
      public function get mapLayer() : MapLayer
      {
         return this._mapLayer;
      }
      
      public function get initPlayerPoint() : Point
      {
         return this._initPlayerPoint;
      }
      
      public function get app() : Sprite
      {
         return this._app;
      }
      
      public function get buildLayer() : BuildingLayer
      {
         return this._buildLayer;
      }
   }
}
