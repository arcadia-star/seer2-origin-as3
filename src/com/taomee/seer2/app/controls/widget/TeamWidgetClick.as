package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.controls.widget.core.IToolBarWidgetClick;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.team.TeamManager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   
   public class TeamWidgetClick implements IToolBarWidgetClick
   {
      
      public static const TEAM:String = "team";
       
      
      private var _widget:ToolBarWidget;
      
      public function TeamWidgetClick()
      {
         super();
      }
      
      public function get widget() : ToolBarWidget
      {
         return this._widget;
      }
      
      public function set widget(param1:ToolBarWidget) : void
      {
         this._widget = param1;
      }
      
      public function onWidgetClick(param1:MouseEvent) : void
      {
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_308);
         if(TeamManager.teamId > 0)
         {
            SceneManager.changeScene(SceneType.TEAM,TeamManager.teamId);
         }
         else
         {
            AlertManager.showEntryTeamAlert(this.creTeamFun,this.entryTeamFun);
         }
         SoundEffects.playSoundMouseClick();
      }
      
      private function creTeamFun() : void
      {
         NpcDialog.show(6,"克拉克",[[0,"创建战队需要训练师等级≥8级，成功创建战队还将扣除5000赛尔豆。你，准备好了么？"]],["以后再来","时刻准备着！"],[null,function():void
         {
            var _loc1_:* = ActorManager.getActor().getInfo();
            if(_loc1_.coins < 5000)
            {
               NpcDialog.show(6,"克拉克",[[0,"创建战队需要5000赛尔豆。"]],["我知道了"]);
            }
            else if(_loc1_.trainerLevel < 8)
            {
               NpcDialog.show(6,"克拉克",[[0,"只有训练师等级≥8级，才能够担当起战队队长的责任。"]],["我知道了"]);
            }
            else
            {
               ModuleManager.showModule(URLUtil.getAppModule("NewTeamCreatePanel1"),"加载战队创建面板",0);
            }
         }]);
      }
      
      private function entryTeamFun() : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("NewTeamRankListPanel"),"加载面板",0);
      }
   }
}
