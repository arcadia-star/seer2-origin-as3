package com.taomee.seer2.core.map.grids
{
   import flash.display.BitmapData;
   
   public class BuildingLayer extends BaseDisplayObject
   {
       
      
      public var _buildingArray:Array;
      
      private var _maxNum:int = 0;
      
      private var _map:com.taomee.seer2.core.map.grids.GameMap;
      
      private var _imageDataMap:com.taomee.seer2.core.map.grids.HashMap;
      
      public function BuildingLayer(param1:com.taomee.seer2.core.map.grids.GameMap)
      {
         super();
         this._map = param1;
         this._buildingArray = new Array();
         this._imageDataMap = new com.taomee.seer2.core.map.grids.HashMap();
      }
      
      public function drawByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:GameMapItem = null;
         var _loc4_:BitmapData = null;
         for each(_loc2_ in param1.items.item)
         {
            _loc3_ = new GameMapItem();
            _loc3_.parentLayer = this;
            _loc3_.x = _loc2_.@px;
            _loc3_.y = _loc2_.@py;
            if((_loc4_ = BitmapData(this._imageDataMap.getValue(_loc2_.@file[0]))) != null)
            {
               _loc3_.reset(_loc4_,_loc2_);
            }
            else
            {
               _loc3_.configXml = _loc2_;
               _loc3_.loadImage();
            }
            this._buildingArray.push(_loc3_);
            this.addChild(_loc3_);
         }
      }
      
      public function get imageDataMap() : com.taomee.seer2.core.map.grids.HashMap
      {
         return this._imageDataMap;
      }
      
      public function get buildingArray() : Array
      {
         return this._buildingArray;
      }
      
      public function dispose() : void
      {
         this._imageDataMap.clear();
         this._buildingArray.length = 0;
         this._buildingArray = null;
      }
   }
}
