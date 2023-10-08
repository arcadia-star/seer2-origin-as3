package com.taomee.seer2.app.lobby.messageHandler
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.net.message.IMessageHandler;
   import com.taomee.seer2.core.scene.ImageLevelManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.StageQuality;
   
   public class MessageHandlerStartLoadArenaMap implements IMessageHandler
   {
       
      
      private var _isStartFight:Boolean;
      
      public function MessageHandlerStartLoadArenaMap()
      {
         super();
         this._isStartFight = false;
      }
      
      public function setup() : void
      {
         Connection.addCommandListener(CommandSet.FIGHT_LOAD_MAP_4,this.onMessage);
      }
      
      public function onMessage(param1:MessageEvent) : void
      {
         if(this._isStartFight == false)
         {
            AlertManager.closeAllPopUp();
            DialogPanel.hide();
            NpcDialog.hide();
            this._isStartFight = true;
            SceneManager.changeScene(SceneType.ARENA,SceneManager.active.fightMapId);
            if(ImageLevelManager.getFightImageQuality() == "")
            {
               ImageLevelManager.setFightImageLevel(StageQuality.MEDIUM);
            }
            else
            {
               ImageLevelManager.setFightImageLevel(ImageLevelManager.getFightImageQuality());
            }
         }
      }
      
      public function dispose() : void
      {
         Connection.removeCommandListener(CommandSet.FIGHT_LOAD_MAP_4,this.onMessage);
      }
   }
}
