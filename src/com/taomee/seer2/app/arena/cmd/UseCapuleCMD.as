package com.taomee.seer2.app.arena.cmd
{
   import com.taomee.seer2.app.arena.controller.ArenaUIController;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class UseCapuleCMD implements IArenaBaseCMD
   {
       
      
      private var _uiContorller:ArenaUIController;
      
      private var _usedItemReferenceId:uint;
      
      public function UseCapuleCMD(param1:ArenaUIController, param2:uint)
      {
         super();
         this._uiContorller = param1;
         this._usedItemReferenceId = param2;
      }
      
      public function init() : void
      {
      }
      
      public function send() : void
      {
         Connection.addCommandListener(CommandSet.FIGHT_CATCH_PET_1031,this.onUseCapule);
         Connection.send(CommandSet.FIGHT_CATCH_PET_1031,this._usedItemReferenceId);
      }
      
      private function onUseCapule(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_CATCH_PET_1031,this.onUseCapule);
         if(this._usedItemReferenceId > 0)
         {
            ItemManager.reduceItemQuantity(this._usedItemReferenceId,1);
         }
         this._uiContorller.itemPanelUpdate();
         this.dispose();
      }
      
      public function dispose() : void
      {
         this._uiContorller = null;
      }
   }
}
