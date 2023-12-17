package com.taomee.seer2.app.dialog
{
   import com.taomee.seer2.app.dialog.functionality.BaseUnit;
   import com.taomee.seer2.app.dialog.functionality.FunctionalityUnitFactory;
   import com.taomee.seer2.app.dialog.functionality.QuestUnit;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.QuestStep;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Sprite;
   
   public class FunctionalityBox extends Sprite
   {
      
      private static const UNIT_WIDTH:int = 100;
      
      private static const UNIT_HEIGHT:int = 30;
       
      
      private var _unitVec:Vector.<BaseUnit>;
      
      private var _configData:XML;
      
      public function FunctionalityBox()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._unitVec = new Vector.<BaseUnit>();
      }
      
      public function createUnitList(param1:XML) : void
      {
         var _loc3_:XML = null;
         this.clear();
         if(param1 == null)
         {
            return;
         }
         this._configData = param1;
         var _loc2_:XMLList = this._configData.elements("node");
         for each(_loc3_ in _loc2_)
         {
            this.createUnitFromXml(_loc3_);
         }
      }
      
      private function createUnitFromXml(param1:XML) : void
      {
         var _loc2_:String = param1.attribute("type").toString();
         var _loc3_:String = param1.attribute("name").toString();
         var _loc4_:String = param1.attribute("params").toString();
         var _loc5_:BaseUnit;
         if((_loc5_ = FunctionalityUnitFactory.createUnit(_loc2_,_loc3_,_loc4_)) != null)
         {
            this.addUnit(_loc5_);
         }
      }
      
      public function createQuestUnit(param1:int, param2:Quest) : void
      {
         var _loc4_:int = 0;
         var _loc5_:QuestStep = null;
         var _loc6_:QuestUnit = null;
         var _loc3_:Vector.<int> = new Vector.<int>();
         if(param2.status == QuestStatus.ACCEPTABLE)
         {
            if(param2.acceptNpcId == param1)
            {
               _loc3_.push(0);
            }
         }
         else
         {
            for each(_loc5_ in param2.getCurrentStepVec())
            {
               if(_loc5_.relatedNpcId == param1)
               {
                  _loc3_.push(_loc5_.id);
               }
            }
         }
         for each(_loc4_ in _loc3_)
         {
            (_loc6_ = new QuestUnit()).setData(param2,_loc4_);
            this.addUnit(_loc6_);
         }
      }
      
      public function addUnit(param1:BaseUnit) : void
      {
         this._unitVec.push(param1);
         addChild(param1);
         this.updateLayout();
      }
      
      public function getUnit(param1:String) : BaseUnit
      {
         var _loc2_:BaseUnit = null;
         var _loc3_:BaseUnit = null;
         for each(_loc3_ in this._unitVec)
         {
            if(_loc3_.label == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      public function removeUnit(param1:BaseUnit) : void
      {
         this.removeItemFromVec(param1);
         if(contains(param1))
         {
            param1.clearEvent();
            removeChild(param1);
         }
         this.updateLayout();
      }
      
      public function removeQuestUnit(param1:uint) : void
      {
         var _loc2_:BaseUnit = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._unitVec.length)
         {
            if(this._unitVec[_loc3_] is QuestUnit)
            {
               if((this._unitVec[_loc3_] as QuestUnit).getQuest().id == param1)
               {
                  _loc2_ = this._unitVec[_loc3_];
                  break;
               }
            }
            _loc3_++;
         }
         if(_loc2_ != null)
         {
            this.removeUnit(_loc2_);
         }
      }
      
      private function removeItemFromVec(param1:BaseUnit) : void
      {
         var _loc2_:int = int(this._unitVec.length);
         var _loc3_:int = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            if(this._unitVec[_loc3_] == param1)
            {
               param1.clearEvent();
               this._unitVec.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      private function updateLayout() : void
      {
         var _loc6_:BaseUnit = null;
         var _loc1_:Vector.<BaseUnit> = this._unitVec.sort(this.compareUnit);
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            (_loc6_ = _loc1_[_loc5_]).x = _loc3_;
            _loc6_.y = uint(_loc5_ / 3) * UNIT_HEIGHT;
            _loc4_ = _loc6_.width;
            if(_loc5_ % 3 != 2)
            {
               _loc3_ += _loc4_ + 10;
            }
            else
            {
               _loc3_ = 0;
            }
            _loc5_++;
         }
      }
      
      private function compareUnit(param1:BaseUnit, param2:BaseUnit) : int
      {
         if(param1.priority > param2.priority)
         {
            return 1;
         }
         if(param1.priority < param2.priority)
         {
            return -1;
         }
         return 0;
      }
      
      public function getUnitList() : Vector.<BaseUnit>
      {
         return this._unitVec;
      }
      
      public function clear() : void
      {
         var _loc1_:BaseUnit = null;
         for each(_loc1_ in this._unitVec)
         {
            _loc1_.clearEvent();
            DisplayObjectUtil.removeFromParent(_loc1_);
         }
         this._unitVec = new Vector.<BaseUnit>();
      }
   }
}
