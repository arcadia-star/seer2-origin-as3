package com.taomee.seer2.app.cmdl
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dream.DreamMapOrganize;
   import com.taomee.seer2.app.home.panel.HomePanel;
   import com.taomee.seer2.app.plant.panelControl.PlantPanelControl;
   import com.taomee.seer2.app.questTiny.QuestTinyPanel;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.core.map.ResContentLibrary;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.events.Event;
   import org.taomee.bean.BaseBean;
   
   public class UpIconUpdateBean extends BaseBean
   {
       
      
      public function UpIconUpdateBean()
      {
         super();
         LayerManager.stage.addEventListener(Event.RESIZE,this.onResize);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         finish();
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         if(Boolean(SceneManager.active) && (SceneManager.active.type == SceneType.ARENA || SceneManager.active.type == SceneType.GUDIE_ARENA || SceneManager.active.type == SceneType.GUDIE_ARENA2 || SceneManager.active.type == SceneType.GUDIE_ARENA3 || SceneManager.active.type != SceneType.GUDIE_ARENA4 || SceneManager.active.type != SceneType.GUDIE_ARENA5))
         {
            FightManager.addEventListener(FightStartEvent.FIGHT_LOADING_END,this.onFightEnd);
         }
         else if(Boolean(SceneManager.active) && SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.active.mapModel.content.scaleX = 1;
            SceneManager.active.mapModel.content.scaleY = 1;
         }
      }
      
      private function onResize(param1:Event) : void
      {
         if(SceneManager.active && SceneManager.active.type != SceneType.GUDIE_ARENA && SceneManager.active.type != SceneType.GUDIE_ARENA2 && SceneManager.active.type != SceneType.GUDIE_ARENA3 && SceneManager.active.type != SceneType.GUDIE_ARENA4 && SceneManager.active.type != SceneType.GUDIE_ARENA5 && SceneManager.active.type != SceneType.GUIDE_NEW_ARENA1 && SceneManager.active.type != SceneType.GUIDE_NEW_ARENA2 && SceneManager.active.type != SceneType.GUIDE_NEW_ARENA3)
         {
            DialogPanel.layIcon();
            ResContentLibrary.updateRes();
            RightToolbarConter.instance.upupdate();
            LayerManager.layout();
            ToolBar.layIcons();
            QuestTinyPanel.layout();
            DreamMapOrganize.layout();
         }
         if(SceneManager.active && ActorManager.actorInfo && SceneManager.active.type == SceneType.HOME)
         {
            HomePanel.layIcons();
         }
         if(SceneManager.active && ActorManager.actorInfo && SceneManager.active.type == SceneType.PLANT)
         {
            PlantPanelControl.layIcons();
         }
         if(Boolean(SceneManager.active) && (SceneManager.active.type == SceneType.ARENA || SceneManager.active.type == SceneType.GUDIE_ARENA || SceneManager.active.type == SceneType.GUDIE_ARENA2 || SceneManager.active.type == SceneType.GUDIE_ARENA3 || SceneManager.active.type != SceneType.GUDIE_ARENA4 || SceneManager.active.type != SceneType.GUDIE_ARENA5))
         {
            this.fightLayout();
         }
      }
      
      private function onFightEnd(param1:FightStartEvent) : void
      {
         FightManager.removeEventListener(FightStartEvent.FIGHT_LOADING_END,this.onFightEnd);
         this.fightLayout();
      }
      
      private function fightLayout() : void
      {
         var _loc1_:ArenaScene = SceneManager.active as ArenaScene;
         if(Boolean(_loc1_) && Boolean(_loc1_.arenaUIController))
         {
            _loc1_.arenaUIController.layOut();
            SceneManager.active.mapModel.content.scaleX = LayerManager.stage.stageWidth / 1200;
            SceneManager.active.mapModel.content.scaleY = LayerManager.stage.stageHeight / 660;
         }
      }
   }
}
