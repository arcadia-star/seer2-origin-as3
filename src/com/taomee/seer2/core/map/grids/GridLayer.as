package com.taomee.seer2.core.map.grids
{
   import flash.display.Shape;
   
   public class GridLayer extends BaseDisplayObject
   {
       
      
      private var _mapWidth:int;
      
      private var _mapHeight:int;
      
      private var _tilePixelWidth:int;
      
      private var _tilePixelHeight:int;
      
      private var _gridLineColor:uint = 12303291;
      
      private var _wHalfTile:int;
      
      private var _hHalfTile:int;
      
      private var _map:GameMap;
      
      public function GridLayer(param1:GameMap)
      {
         super();
         this._map = param1;
      }
      
      public function drawGrid(param1:int, param2:int, param3:int, param4:int) : void
      {
         this._mapWidth = param1;
         this._mapHeight = param2;
         this._tilePixelWidth = param3;
         this._tilePixelHeight = param4;
         var _loc5_:int = this._mapHeight / this._tilePixelHeight;
         var _loc6_:int = this._mapWidth / this._tilePixelWidth;
         this._wHalfTile = int(this._tilePixelWidth / 2);
         this._hHalfTile = int(this._tilePixelHeight / 2);
         var _loc7_:Shape = new Shape();
         this.addChild(_loc7_);
         _loc7_.graphics.lineStyle(1,this._gridLineColor,1);
         var _loc8_:int = _loc6_ * 2 + 1;
         var _loc9_:int = _loc5_ * 2 + 1;
         var _loc10_:int = 1;
         while(_loc10_ < _loc8_)
         {
            _loc7_.graphics.moveTo(_loc10_ * this._wHalfTile,0);
            if(_loc9_ + _loc10_ >= _loc8_)
            {
               _loc7_.graphics.lineTo(_loc8_ * this._wHalfTile,(_loc8_ - _loc10_) * this._hHalfTile);
            }
            else
            {
               _loc7_.graphics.lineTo((_loc9_ + _loc10_) * this._wHalfTile,_loc9_ * this._hHalfTile);
            }
            _loc7_.graphics.moveTo(_loc10_ * this._wHalfTile,0);
            if(_loc10_ <= _loc9_)
            {
               _loc7_.graphics.lineTo(0,_loc10_ * this._hHalfTile);
            }
            else
            {
               _loc7_.graphics.lineTo((_loc10_ - _loc5_ - 1) * this._wHalfTile,_loc9_ * this._hHalfTile);
            }
            _loc10_ += 2;
         }
         var _loc11_:int = 1;
         while(_loc11_ < _loc9_)
         {
            _loc7_.graphics.moveTo(0,_loc11_ * this._hHalfTile);
            if(_loc9_ - _loc11_ >= _loc8_)
            {
               _loc7_.graphics.lineTo(_loc8_ * this._wHalfTile,(_loc8_ + _loc11_) * this._hHalfTile);
            }
            else
            {
               _loc7_.graphics.lineTo((_loc9_ - _loc11_) * this._wHalfTile,_loc9_ * this._hHalfTile);
            }
            _loc11_ += 2;
         }
         var _loc12_:int = 0;
         while(_loc12_ < _loc9_)
         {
            _loc7_.graphics.moveTo(_loc8_ * this._wHalfTile,_loc12_ * this._hHalfTile);
            if(_loc8_ - _loc9_ + _loc12_ < 0)
            {
               _loc7_.graphics.lineTo(0,(_loc8_ + _loc12_) * this._hHalfTile);
            }
            else
            {
               _loc7_.graphics.lineTo((_loc8_ - _loc9_ + _loc12_) * this._wHalfTile,_loc9_ * this._hHalfTile);
            }
            _loc12_ += 2;
         }
      }
   }
}
