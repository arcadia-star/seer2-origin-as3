package com.taomee.seer2.app.pet.data
{
   import com.taomee.seer2.app.arena.util.SkillCategoryValue;
   import com.taomee.seer2.app.arena.util.SkillFieldTable;
   import com.taomee.seer2.app.config.SkillConfig;
   import com.taomee.seer2.app.config.skill.SkillDefinition;
   
   public class SkillInfo
   {
       
      
      private var _id:uint;
      
      private var _effectId:String;
      
      private var _soundId:String;
      
      private var _definition:SkillDefinition;
      
      private var _isHideSkill:Boolean = false;
      
      public function SkillInfo(param1:int)
      {
         super();
         this._id = param1;
         this._definition = SkillConfig.getSkillDefinition(this._id);
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._definition.name;
      }
      
      public function get isIntercourse() : Boolean
      {
         return this._definition.category == SkillCategoryValue.POW_INTERCOURSE_VALUE;
      }
      
      public function get isCritical() : Boolean
      {
         return this.categoryId == SkillCategoryValue.POW_VALUE;
      }
      
      public function get category() : String
      {
         return SkillFieldTable.getCategoryName(this.categoryId);
      }
      
      public function get categoryId() : int
      {
         var _loc1_:String = this._definition.category.toString();
         return int(_loc1_.substr(0,1));
      }
      
      public function get type() : String
      {
         return SkillFieldTable.getTypeName(this._definition.type);
      }
      
      public function get typeId() : int
      {
         return this._definition.type;
      }
      
      public function get anger() : int
      {
         return this._definition.anger;
      }
      
      public function get power() : int
      {
         return this._definition.power;
      }
      
      public function get description() : String
      {
         return this._definition.description;
      }
      
      public function set effectId(param1:String) : void
      {
         this._effectId = param1;
      }
      
      public function get effectId() : String
      {
         return this._effectId;
      }
      
      public function set soundId(param1:String) : void
      {
         this._soundId = param1;
      }
      
      public function get soundId() : String
      {
         return this._soundId;
      }
      
      public function get isHideSkill() : Boolean
      {
         return this._isHideSkill;
      }
      
      public function set isHideSkill(param1:Boolean) : void
      {
         this._isHideSkill = param1;
      }
   }
}
