package com.taomee.seer2.core.animation.frame
{
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import org.taomee.ds.HashMap;
   
   public class FrameSequence
   {
       
      
      public var referredCount:uint;
      
      public var isFromPool:Boolean = true;
      
      private var _sheet:com.taomee.seer2.core.animation.frame.FrameSheet;
      
      private var _frameWidth:uint;
      
      private var _frameHeight:uint;
      
      private var _totalFrameNum:uint;
      
      private var _anchor:Point;
      
      private var _labelMap:HashMap;
      
      public function FrameSequence()
      {
         super();
      }
      
      public function setData(param1:ByteArray) : void
      {
         param1.position = 0;
         this.parseHead(param1);
         this._sheet = new com.taomee.seer2.core.animation.frame.FrameSheet(param1);
      }
      
      private function parseHead(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:uint = uint(param1.readShort());
         param1.readBytes(_loc2_,0,_loc3_);
         _loc2_.position = 0;
         this._frameWidth = _loc2_.readShort();
         this._frameHeight = _loc2_.readShort();
         this._totalFrameNum = _loc2_.readShort();
         this._anchor = new Point(_loc2_.readShort(),_loc2_.readShort());
         var _loc4_:Object;
         var _loc5_:String = (_loc4_ = _loc2_.readObject()).l as String;
         var _loc6_:String = _loc4_.i as String;
         this.parseLabel(_loc5_,_loc6_);
      }
      
      private function parseLabel(param1:String, param2:String) : void
      {
         var _loc7_:FrameLabelInfo = null;
         var _loc3_:Array = param1.split(",");
         var _loc4_:Array = param2.split(",");
         this._labelMap = new HashMap();
         var _loc5_:int = int(_loc3_.length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = new FrameLabelInfo(_loc3_[_loc6_],_loc4_[_loc6_ * 2],_loc4_[_loc6_ * 2 + 1]);
            this._labelMap.add(_loc3_[_loc6_],_loc7_);
            _loc6_++;
         }
      }
      
      public function getTotalFrameNum() : uint
      {
         return this._totalFrameNum;
      }
      
      public function getLabelInfo(param1:String) : FrameLabelInfo
      {
         return this._labelMap.getValue(param1);
      }
      
      public function getLabelMap() : HashMap
      {
         return this._labelMap;
      }
      
      public function getFrameInfoByIndex(param1:uint) : FrameInfo
      {
         if(this.isReady == true)
         {
            return this._sheet.getFrameInfo(param1);
         }
         return null;
      }
      
      public function get isReady() : Boolean
      {
         return Boolean(this._sheet) && this._sheet.isReady;
      }
      
      public function get anchor() : Point
      {
         return this._anchor;
      }
      
      public function get frameWidth() : uint
      {
         return this._frameWidth;
      }
      
      public function get frameHeight() : uint
      {
         return this._frameHeight;
      }
      
      public function dispose() : void
      {
         if(this._sheet != null)
         {
            this._sheet.dispose();
            this._sheet = null;
         }
      }
   }
}
