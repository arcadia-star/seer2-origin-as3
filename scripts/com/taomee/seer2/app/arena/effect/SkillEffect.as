package com.taomee.seer2.app.arena.effect
{
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.skill.PetSkillSettingDefinition;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import org.taomee.utils.DisplayUtil;
   
   public class SkillEffect extends Sprite
   {
       
      
      private var _effectMC:MovieClip;
      
      private var _skillInfo:SkillInfo;
      
      private var _fighterResourceId:uint;
      
      public function SkillEffect(param1:uint, param2:SkillInfo)
      {
         super();
         this._fighterResourceId = param1;
         this._skillInfo = param2;
         DisplayObjectUtil.disableSprite(this);
      }
      
      public function getResourceUrl() : String
      {
         var _loc1_:PetSkillSettingDefinition = PetConfig.getPetSkillSettingDefinition(this._skillInfo.id);
         if(Boolean(ClientConfig.isDebug) && _loc1_ == null)
         {
            throw new Error("没有从PetConfig中检索出 [NumbersID-" + this._fighterResourceId + "][_SkillId-" + this._skillInfo.id + "]");
         }
         this._skillInfo.effectId = _loc1_.effectId;
         return URLUtil.getSkillEffectSwf(_loc1_.effectId);
      }
      
      public function onResourceLoaded(param1:ContentInfo) : void
      {
         this._effectMC = param1.content;
      }
      
      public function active() : void
      {
         if(this._effectMC)
         {
            addChild(this._effectMC);
            this.play();
         }
      }
      
      public function deactive() : void
      {
         this._effectMC.gotoAndStop(this._effectMC.totalFrames);
      }
      
      public function get skillId() : uint
      {
         return this._skillInfo.id;
      }
      
      private function play() : void
      {
         this._effectMC.gotoAndPlay(1);
         this._effectMC.addEventListener(Event.ENTER_FRAME,this.onMcPlay);
      }
      
      private function onMcPlay(param1:Event) : void
      {
         if(this._effectMC == null)
         {
            return;
         }
         if(this._effectMC.currentFrame == this._effectMC.totalFrames)
         {
            this._effectMC.removeEventListener(Event.ENTER_FRAME,this.onMcPlay);
            this._effectMC.stop();
            DisplayUtil.removeForParent(this._effectMC,false);
         }
         param1.stopPropagation();
      }
      
      public function dispose() : void
      {
         this._skillInfo = null;
         this._effectMC = null;
         this._fighterResourceId = 0;
      }
   }
}
