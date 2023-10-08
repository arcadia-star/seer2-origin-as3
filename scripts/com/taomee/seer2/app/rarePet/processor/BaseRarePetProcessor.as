package com.taomee.seer2.app.rarePet.processor
{
   import com.taomee.seer2.app.config.NPCConfig;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   
   public class BaseRarePetProcessor implements IRarepetProcessor
   {
       
      
      protected var _npc:Mobile;
      
      protected var _npcId:int;
      
      protected var _mapId:int;
      
      public function BaseRarePetProcessor(param1:int, param2:int)
      {
         super();
         this._npcId = param1;
         this._mapId = param2;
      }
      
      protected function createNPC() : void
      {
         var _loc1_:NpcDefinition = NPCConfig.getNPCDefinition(this._npcId);
         this._npc = MobileManager.createNpc(_loc1_);
      }
      
      protected function disposeNPC() : void
      {
         if(this._npc)
         {
            MobileManager.removeMobileById(this._npcId,MobileType.NPC);
            this._npc = null;
         }
      }
      
      protected function showNPC() : void
      {
         if(this._npc)
         {
            DisplayObjectUtil.enableSprite(this._npc);
            this._npc.visible = true;
         }
      }
      
      protected function hideNPC() : void
      {
         if(this._npc)
         {
            DisplayObjectUtil.disableSprite(this._npc);
            this._npc.visible = false;
         }
      }
      
      public function processMapComplete() : void
      {
         if(SceneManager.active.mapID == this._mapId)
         {
            this.createNPC();
         }
      }
      
      public function processMapDispose() : void
      {
         if(SceneManager.active.mapID == this._mapId)
         {
            this.disposeNPC();
         }
      }
   }
}
