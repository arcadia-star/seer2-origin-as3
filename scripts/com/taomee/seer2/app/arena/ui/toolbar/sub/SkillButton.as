package com.taomee.seer2.app.arena.ui.toolbar.sub
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.component.PetTypeIcon;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class SkillButton extends Sprite implements ISkillButton
   {
       
      
      private var _id:int;
      
      private var _btn:SimpleButton;
      
      private var _brief:MovieClip;
      
      private var _typeIcon:PetTypeIcon;
      
      private var _nameTxt:TextField;
      
      private var _angerValueTxt:TextField;
      
      private var _powerTxt:TextField;
      
      private var _powerValueTxt:TextField;
      
      private var _categoryTxt:TextField;
      
      private var _info:SkillInfo;
      
      private var _enabled:Boolean;
      
      public function SkillButton()
      {
         super();
         this.createChildren();
         this.enabled = true;
      }
      
      private function createChildren() : void
      {
         this._btn = FightUIManager.getButton("UI_FightSkillBtn");
         addChild(this._btn);
         this._brief = FightUIManager.getMovieClip("UI_FightSkillBrief");
         this._brief.mouseChildren = false;
         this._brief.mouseEnabled = false;
         var _loc1_:TextField = this._brief["txtAnger"];
         _loc1_.text = "怒气";
         this._nameTxt = this._brief["txtSkillName"];
         this._angerValueTxt = this._brief["txtAngerValue"];
         this._angerValueTxt.text = "0";
         this._powerTxt = this._brief["txtPower"];
         this._powerTxt.text = "威力";
         this._powerValueTxt = this._brief["txtPowerValue"];
         this._powerValueTxt.text = "0";
         this._categoryTxt = this._brief["txtSkillCategory"];
         addChild(this._brief);
         this._typeIcon = new PetTypeIcon();
         DisplayObjectUtil.disableSprite(this._typeIcon);
         this._typeIcon.x = 18;
         this._typeIcon.y = 19;
         addChild(this._typeIcon);
      }
      
      public function setSkillInfo(param1:SkillInfo) : void
      {
         this._info = param1;
         this._nameTxt.text = this._info.name;
         this._angerValueTxt.text = this._info.anger.toString();
         this._powerValueTxt.text = this._info.power.toString();
         this._categoryTxt.text = this._info.category;
         this._typeIcon.type = this._info.typeId;
      }
      
      public function getSkillInfo() : SkillInfo
      {
         return this._info;
      }
      
      public function set id(param1:int) : void
      {
         this._id = param1;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         if(this._enabled == true)
         {
            DisplayObjectUtil.recoverDisplayObject(this);
         }
         else
         {
            DisplayObjectUtil.darkenDisplayObject(this);
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function dispose() : void
      {
         this._info = null;
      }
   }
}
