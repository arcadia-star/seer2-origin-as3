package com.taomee.seer2.core.map.grids
{
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class GameMapItem extends BaseDisplayObject
   {
       
      
      private var _bitMap:Bitmap;
      
      private var _configXml:XML;
      
      private var _init:Boolean = false;
      
      private var _imageLoader:com.taomee.seer2.core.map.grids.ImageLoader;
      
      private var _parentLayer:com.taomee.seer2.core.map.grids.BuildingLayer;
      
      public function GameMapItem()
      {
         super();
      }
      
      public function reset(param1:BitmapData, param2:XML) : void
      {
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         this._bitMap = new Bitmap(param1);
         addChild(this._bitMap);
         this._configXml = param2;
      }
      
      public function imageLoaded(param1:Event) : void
      {
         this._bitMap = new Bitmap(this._imageLoader._data);
         this._parentLayer.imageDataMap.put(this._imageLoader.url,this._imageLoader._data);
         addChild(this._bitMap);
         this._imageLoader.removeEventListener(Event.COMPLETE,this.imageLoaded);
         this._imageLoader = null;
         HeptaFishGC.gc();
      }
      
      public function loadImage(param1:String = "map/") : void
      {
         this._imageLoader = new com.taomee.seer2.core.map.grids.ImageLoader();
         this._imageLoader.addEventListener(Event.COMPLETE,this.imageLoaded);
         var _loc2_:String = URLUtil.getRes(param1 + this._configXml.@file[0]);
         this._imageLoader.load(_loc2_);
      }
      
      public function get configXml() : XML
      {
         return this._configXml;
      }
      
      public function set configXml(param1:XML) : void
      {
         this._configXml = param1;
      }
      
      public function get bitMap() : Bitmap
      {
         return this._bitMap;
      }
      
      public function set bitMap(param1:Bitmap) : void
      {
         this._bitMap = param1;
      }
      
      public function get parentLayer() : com.taomee.seer2.core.map.grids.BuildingLayer
      {
         return this._parentLayer;
      }
      
      public function set parentLayer(param1:com.taomee.seer2.core.map.grids.BuildingLayer) : void
      {
         this._parentLayer = param1;
      }
   }
}
