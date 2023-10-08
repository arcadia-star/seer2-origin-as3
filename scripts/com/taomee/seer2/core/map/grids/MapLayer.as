package com.taomee.seer2.core.map.grids
{
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.geom.Point;
   
   public class MapLayer extends BaseDisplayObject
   {
       
      
      private var _imageLoader:com.taomee.seer2.core.map.grids.ImageLoader;
      
      private var _image:Bitmap;
      
      private var _imageMap:com.taomee.seer2.core.map.grids.HashMap;
      
      private var _simage:Bitmap;
      
      private var _map:com.taomee.seer2.core.map.grids.GameMap;
      
      private var _loadType:int;
      
      private var _visualWidth:Number;
      
      private var _visualHeight:Number;
      
      private var _sliceWidth:Number;
      
      private var _sliceHeight:Number;
      
      private var _preloadX:Number;
      
      private var _preloadY:Number;
      
      private var _loadingMap:com.taomee.seer2.core.map.grids.HashMap;
      
      private var _waitLoadingArr:Array;
      
      private var _loadingNo:int = 1;
      
      private var _screenImageRow:int;
      
      private var _screenImageCol:int;
      
      private var _row:int;
      
      private var _col:int;
      
      private var _nowPlayerPoint:Point;
      
      public function MapLayer(param1:com.taomee.seer2.core.map.grids.GameMap)
      {
         super();
         this._map = param1;
         this._loadType = parseInt(this._map.mapXML.@loadType);
      }
      
      private function loadBigSuccess(param1:Event) : void
      {
         var _loc2_:com.taomee.seer2.core.map.grids.ImageLoader = ImageLoader(param1.target);
         var _loc3_:Bitmap = new Bitmap(_loc2_._data);
         addChild(_loc3_);
         if(this._simage != null && this._simage.parent == this)
         {
            removeChild(this._simage);
            this._simage = null;
         }
         this.width = _loc3_.width;
         this.height = _loc3_.height;
         _loc2_.removeEventListener(Event.COMPLETE,this.loadBigSuccess);
         _loc2_.removeEventListener(ProgressEvent.PROGRESS,loadingHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
         _loc2_ = null;
         dispatchEvent(param1);
         HeptaFishGC.gc();
      }
      
      public function initMapLayer(param1:BitmapData) : void
      {
         var _loc3_:String = null;
         var _loc4_:com.taomee.seer2.core.map.grids.ImageLoader = null;
         var _loc2_:Bitmap = new Bitmap(param1);
         _loc2_.width *= 10;
         _loc2_.height *= 10;
         _loc2_.cacheAsBitmap = true;
         addChild(_loc2_);
         HeptaFishGC.gc();
         switch(this._loadType)
         {
            case 0:
               _loc3_ = URLUtil.getMapImage(this._map.name + "/map");
               (_loc4_ = new com.taomee.seer2.core.map.grids.ImageLoader()).load(_loc3_);
               _loc4_.addEventListener(Event.COMPLETE,this.loadBigSuccess);
               _loc4_.addEventListener(ProgressEvent.PROGRESS,loadingHandler);
               _loc4_.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
               break;
            case 1:
               this._loadingMap = new com.taomee.seer2.core.map.grids.HashMap();
               this._imageMap = new com.taomee.seer2.core.map.grids.HashMap();
               this._waitLoadingArr = new Array();
               this._visualWidth = this._map.app.width;
               this._visualHeight = this._map.app.height;
               this._sliceWidth = parseFloat(this._map.mapXML.@sliceWidth);
               this._sliceHeight = parseFloat(this._map.mapXML.@sliceHeight);
               this._preloadX = parseFloat(this._map.mapXML.@preloadX);
               this._preloadY = parseFloat(this._map.mapXML.@preloadY);
               this._screenImageRow = Math.round(this._visualWidth / this._sliceWidth);
               this._screenImageCol = Math.round(this._visualHeight / this._sliceHeight);
               this._row = Math.ceil(this._map.mapWidth / this._sliceWidth);
               this._col = Math.ceil(this._map.mapHeight / this._sliceHeight);
               this.loadSliceImage(this._map.initPlayerPoint);
         }
      }
      
      private function loadSliceImage(param1:Point) : void
      {
         var _loc11_:int = 0;
         var _loc2_:int = int(param1.x / this._sliceWidth);
         var _loc3_:int = int(param1.y / this._sliceHeight);
         var _loc4_:int = int(_loc2_ / this._screenImageRow);
         var _loc5_:int = int(_loc3_ / this._screenImageCol);
         this._nowPlayerPoint = new Point(_loc4_,_loc5_);
         this.loadScreenImage(_loc4_,_loc5_);
         var _loc6_:int = _loc4_ - this._preloadX < 0 ? 0 : int(_loc4_ - this._preloadX);
         var _loc7_:int = _loc5_ - this._preloadY < 0 ? 0 : int(_loc5_ - this._preloadY);
         var _loc8_:int = _loc4_ + this._preloadX > this._row ? this._row : int(_loc4_ + this._preloadX);
         var _loc9_:int = _loc5_ + this._preloadY > this._col ? this._col : int(_loc5_ + this._preloadY);
         var _loc10_:int = _loc6_;
         while(_loc10_ < _loc8_)
         {
            _loc11_ = _loc7_;
            while(_loc11_ < _loc9_)
            {
               if(!(_loc10_ == _loc4_ && _loc11_ == _loc5_))
               {
                  this.loadScreenImage(_loc10_,_loc11_);
               }
               _loc11_++;
            }
            _loc10_++;
         }
      }
      
      private function loadScreenImage(param1:int, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc3_:int = this._screenImageRow * param1 <= 0 ? 0 : this._screenImageRow * param1;
         var _loc4_:int = this._screenImageCol * param2 <= 0 ? 0 : this._screenImageCol * param2;
         var _loc5_:int = this._screenImageRow * (param1 + 1) >= this._row - 1 ? this._row - 1 : this._screenImageRow * (param1 + 1);
         var _loc6_:int = this._screenImageCol * (param2 + 1) >= this._col - 1 ? this._col - 1 : this._screenImageCol * (param2 + 1);
         var _loc7_:int = _loc4_;
         while(_loc7_ <= _loc6_)
         {
            _loc8_ = _loc3_;
            while(_loc8_ <= _loc5_)
            {
               _loc9_ = _loc7_ + "_" + _loc8_;
               if(!this._loadingMap.containsValue(_loc9_) && !this._imageMap.containsKey(_loc9_))
               {
                  this._waitLoadingArr.push(_loc9_);
               }
               _loc8_++;
            }
            this._waitLoadingArr.reverse();
            this.loadImage();
            _loc7_++;
         }
      }
      
      private function loadImage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:com.taomee.seer2.core.map.grids.ImageLoader = null;
         var _loc4_:String = null;
         if(this._waitLoadingArr.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._loadingNo - this._loadingMap.size())
            {
               _loc2_ = this._waitLoadingArr.pop();
               _loc3_ = new com.taomee.seer2.core.map.grids.ImageLoader();
               _loc4_ = URLUtil.getMapImage(this._map.name + "/" + _loc2_);
               this._loadingMap.put(_loc3_,_loc2_);
               _loc3_.addEventListener(Event.COMPLETE,this.loadScreenImageSuccess);
               _loc3_.addEventListener(ProgressEvent.PROGRESS,loadingHandler);
               _loc3_.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
               _loc3_.load(_loc4_);
               _loc1_++;
            }
         }
      }
      
      private function loadScreenImageSuccess(param1:Event) : void
      {
         var _loc2_:com.taomee.seer2.core.map.grids.ImageLoader = ImageLoader(param1.target);
         var _loc3_:String = String(this._loadingMap.getValue(_loc2_));
         var _loc4_:Array;
         var _loc5_:int = int((_loc4_ = _loc3_.split("_"))[0]);
         var _loc6_:int = int(_loc4_[1]);
         this._loadingMap.remove(_loc2_);
         var _loc7_:Bitmap;
         (_loc7_ = new Bitmap(_loc2_._data)).x = this._sliceWidth * _loc6_;
         _loc7_.y = this._sliceHeight * _loc5_;
         this.addChild(_loc7_);
         this._imageMap.put(_loc5_ + "_" + _loc6_,_loc7_);
         _loc2_.removeEventListener(Event.COMPLETE,this.loadScreenImageSuccess);
         _loc2_.removeEventListener(ProgressEvent.PROGRESS,loadingHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
         _loc2_ = null;
         this.loadImage();
      }
      
      private function removeScreenImage(param1:int, param2:int) : void
      {
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Bitmap = null;
         var _loc3_:int = param1 - this._preloadX < 0 ? 0 : int(param1 - this._preloadX);
         var _loc4_:int = param2 - this._preloadY < 0 ? 0 : int(param2 - this._preloadY);
         var _loc5_:int = param1 + this._preloadX > this._row ? this._row : int(param1 + this._preloadX);
         var _loc6_:int = param2 + this._preloadY > this._col ? this._col : int(param2 + this._preloadY);
         var _loc7_:Array = this._imageMap.keys();
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc11_ = int((_loc10_ = (_loc9_ = _loc7_ as String).split("_"))[0]);
            if((_loc12_ = int(_loc10_[1])) < _loc3_ * this._screenImageRow || _loc12_ > _loc5_ * this._screenImageRow || _loc11_ < _loc4_ * this._screenImageCol || _loc11_ > _loc6_ * this._screenImageCol)
            {
               _loc13_ = Bitmap(this._imageMap.getValue(_loc9_));
               this.removeChild(_loc13_);
               _loc13_ = null;
               this._imageMap.remove(_loc9_);
            }
            _loc8_++;
         }
         HeptaFishGC.gc();
      }
      
      public function checkLoad(param1:Point) : void
      {
         var _loc2_:int = Math.floor(param1.x / this._sliceWidth);
         var _loc3_:int = Math.floor(param1.y / this._sliceHeight);
         var _loc4_:int = Math.floor(_loc2_ / this._screenImageRow);
         var _loc5_:int = Math.floor(_loc3_ / this._screenImageCol);
         if(_loc4_ != this._nowPlayerPoint.x || _loc5_ != this._nowPlayerPoint.y)
         {
            this.loadSliceImage(param1);
         }
      }
      
      public function dispose() : void
      {
         this._imageMap.clear();
         this._loadingMap.clear();
         this._waitLoadingArr.length = 0;
         this._waitLoadingArr = null;
      }
   }
}
