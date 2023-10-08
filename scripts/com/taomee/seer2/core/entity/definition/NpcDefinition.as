package com.taomee.seer2.core.entity.definition
{
   import com.taomee.seer2.core.entity.handler.EntityEventHandlerParser;
   import com.taomee.seer2.core.entity.handler.IEntityEventHandler;
   import com.taomee.seer2.core.utils.URLUtil;
   import com.taomee.seer2.core.utils.Util;
   import flash.geom.Point;
   
   public class NpcDefinition extends EntityDefinition
   {
       
      
      public var resourceId:uint;
      
      public var name:String;
      
      public var direction:uint;
      
      public var path:Vector.<Point>;
      
      public var dialogData:XML;
      
      public var handlers:Vector.<IEntityEventHandler>;
      
      private var _sourcefunctionalityData:XML;
      
      private var _resultFunctionalityData:XML;
      
      private var _node:XML;
      
      public function NpcDefinition(param1:XML)
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         super();
         this._node = param1;
         this.id = param1.attribute("id").toString();
         this.resourceId = param1.attribute("resId").toString();
         this.direction = param1.attribute("dir").toString();
         this.name = param1.attribute("name").toString();
         this.width = int(param1.attribute("width").toString());
         this.height = int(param1.attribute("height").toString());
         var _loc2_:String = param1.attribute("pos").toString();
         var _loc3_:Array = _loc2_.split(",");
         this.x = _loc3_[0];
         this.y = _loc3_[1];
         var _loc4_:String = param1.attribute("actorPos").toString();
         this.actorPos = Util.parsePositionStr(_loc4_);
         var _loc6_:Array;
         var _loc5_:String;
         if((_loc6_ = (_loc5_ = param1.@path).split(",")).length > 2)
         {
            this.path = new Vector.<Point>();
            _loc8_ = int(_loc6_.length);
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
               this.path.push(new Point(_loc6_[_loc9_],_loc6_[_loc9_ + 1]));
               _loc9_ += 2;
            }
         }
         this.dialogData = param1.elements("dialog")[0];
         this.functionalityData = param1.elements("functionality")[0];
         var _loc7_:XMLList = param1.elements("eventHandler").elements("*");
         this.handlers = EntityEventHandlerParser.parse(this,_loc7_);
      }
      
      public function getResourceUrl() : String
      {
         return URLUtil.getNpcSwf(this.resourceId);
      }
      
      public function addFunctionalityUnitAt(param1:XML, param2:int) : Boolean
      {
         var _loc3_:XMLList = this._resultFunctionalityData.child("node");
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param2 > _loc3_.length())
         {
            param2 = _loc3_.length();
         }
         if(param2 < _loc3_.length())
         {
            this._resultFunctionalityData.insertChildBefore(param1,_loc3_[param2]);
         }
         else
         {
            this._resultFunctionalityData.appendChild(param1);
         }
         return true;
      }
      
      public function removeFunctionalityUnit(param1:String) : XML
      {
         var _loc3_:XML = null;
         var _loc5_:XML = null;
         var _loc2_:XML = <functionality></functionality>;
         var _loc4_:int = 0;
         while(_loc4_ < this._resultFunctionalityData.elements("node").length())
         {
            _loc5_ = this._resultFunctionalityData.elements("node")[_loc4_];
            if(String(_loc5_.attribute("name")) == param1)
            {
               _loc3_ = _loc5_;
            }
            else
            {
               _loc2_.appendChild(_loc5_);
            }
            _loc4_++;
         }
         this._resultFunctionalityData = _loc2_;
         return _loc3_;
      }
      
      public function resetFunctionalityData() : void
      {
         this._sourcefunctionalityData = this._node.copy().elements("functionality")[0];
         this._resultFunctionalityData = this._sourcefunctionalityData;
      }
      
      public function set functionalityData(param1:XML) : void
      {
         this._sourcefunctionalityData = param1;
         this._resultFunctionalityData = this._sourcefunctionalityData;
      }
      
      public function get functionalityData() : XML
      {
         return this._resultFunctionalityData;
      }
   }
}
