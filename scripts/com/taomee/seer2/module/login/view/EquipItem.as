package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.config.ItemConfig;
   import com.taomee.seer2.module.login.config.definition.EquipDefinition;
   import com.taomee.seer2.module.login.loader.LoaderManager;
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import com.taomee.seer2.module.login.util.DomainUtil;
   import com.taomee.seer2.module.login.util.EquipUtil;
   import com.taomee.seer2.module.login.util.VersionManager;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.system.ApplicationDomain;
   
   public class EquipItem extends Sprite
   {
       
      
      private const EQUIP_PREVIEW_URL:String = "res/item/equip/preview/";
      
      public var slotIndex:int;
      
      private var _id:int;
      
      private var _definition:EquipDefinition;
      
      private var _loader:Loader;
      
      private var _equipMC:MovieClip;
      
      public function EquipItem(param1:int)
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.slotIndex = param1;
      }
      
      public function setEquipId(param1:int) : void
      {
         if(this._id == param1)
         {
            return;
         }
         this._id = param1;
         this._definition = ItemConfig.getEquipDefinition(param1);
         var _loc2_:String = LoaderAgent.rootUrl + VersionManager.getURL(this.previewUrl);
         LoaderManager.Load(_loc2_,this.onLoadComplete);
      }
      
      private function get previewUrl() : String
      {
         var _loc1_:String = this.getResourceIdentifier();
         if(EquipUtil.hasAccessory(this.slotIndex) == true)
         {
            return this.EQUIP_PREVIEW_URL + _loc1_ + "_0.swf";
         }
         if(EquipUtil.isAccessory(this.slotIndex) == true)
         {
            return this.EQUIP_PREVIEW_URL + _loc1_ + "_1.swf";
         }
         return this.EQUIP_PREVIEW_URL + _loc1_ + ".swf";
      }
      
      private function getResourceIdentifier() : String
      {
         var _loc1_:String = this._definition.suitId.toString();
         var _loc2_:String = EquipUtil.pad(_loc1_,"0",3,false);
         var _loc3_:String = this.slotIndex.toString();
         if(this.slotIndex == EquipUtil.HAND_LEFT)
         {
            _loc3_ = EquipUtil.HAND_RIGHT.toString();
         }
         if(this.slotIndex == EquipUtil.FOOT_LEFT)
         {
            _loc3_ = EquipUtil.FOOT_RIGHT.toString();
         }
         var _loc4_:String = EquipUtil.pad(_loc3_,"0",2,false);
         return "1" + _loc2_ + _loc4_;
      }
      
      public function removeEquip() : void
      {
         if(this._equipMC)
         {
            DisplayObjectUtil.removeFromParent(this._equipMC);
         }
         this._id = 0;
      }
      
      private function onLoadComplete(param1:String, param2:ApplicationDomain, param3:DisplayObject) : void
      {
         if(this._equipMC)
         {
            DisplayObjectUtil.removeFromParent(this._equipMC);
         }
         this._equipMC = DomainUtil.getMovieClip("item",param2);
         addChild(this._equipMC);
      }
      
      public function dispose() : void
      {
         this.removeEquip();
         this._definition = null;
         this._loader = null;
         this._equipMC = null;
      }
   }
}
