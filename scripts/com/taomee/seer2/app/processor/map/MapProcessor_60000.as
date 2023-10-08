package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1135;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.questTiny.QuestTinyPanel;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.team.TeamManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleEvent;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcessor_60000 extends MapProcessor
   {
      
      private static const TEAM_SHOP_EFFECTID:uint = 5;
       
      
      private var _teamNewsBtn:SimpleButton;
      
      private var _teamInfoBtn:SimpleButton;
      
      private var _teamMemberBtn:SimpleButton;
      
      private var _btn0:SimpleButton;
      
      private var _btn1:SimpleButton;
      
      private var npc:Mobile;
      
      public function MapProcessor_60000(param1:MapModel)
      {
         super(param1);
         this._btn0 = _map.content["btn_0"];
         this._btn1 = _map.content["btn_1"];
         TooltipManager.addCommonTip(this._btn0,"战队信息");
         TooltipManager.addCommonTip(this._btn1,"战队排行榜");
         this._btn0.addEventListener(MouseEvent.CLICK,this.onTeamBtnClick);
         this._btn1.addEventListener(MouseEvent.CLICK,this.onTeamNewsClick);
      }
      
      override public function init() : void
      {
         RightToolbarConter.instance.hide();
         QuestTinyPanel.instance.hide();
         this.initTeamShopNpc();
         this.createNpc();
         if(TeamManager.fightBossStatus)
         {
            TeamManager.fightBossStatus = false;
            ModuleManager.toggleModule(URLUtil.getAppModule("NewTeamBossPanel"),"加载战队BOSS面板");
         }
      }
      
      private function createNpc() : void
      {
         this.npc = new Mobile();
         this.npc.setPostion(new Point(114,492));
         this.npc.resourceUrl = URLUtil.getNpcSwf(849);
         this.npc.buttonMode = true;
         MobileManager.addMobile(this.npc,MobileType.NPC);
         this.npc.addEventListener(MouseEvent.CLICK,this.onNpc);
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("FightTeamFightXiaoTianPanel");
      }
      
      private function initTeamShopNpc() : void
      {
         if(TeamManager.teamEffectStatusArr == null)
         {
            this.initTeamEffectStatus();
         }
         else
         {
            this.validateTeamShopNpcStatus();
         }
      }
      
      private function validateTeamShopNpcStatus() : void
      {
         if(!TeamManager.teamEffectStatusArr[TEAM_SHOP_EFFECTID - 1])
         {
            ModuleManager.addEventListener("TeamEffectUpgrade","teamEffectStatusChange",this.onTeamEffectUpgrade);
         }
      }
      
      private function onTeamEffectUpgrade(param1:ModuleEvent) : void
      {
         if(TeamManager.teamEffectStatusArr[TEAM_SHOP_EFFECTID - 1])
         {
            ModuleManager.removeEventListener("TeamEffectUpgrade","teamEffectStatusChange",this.onTeamEffectUpgrade);
         }
      }
      
      private function clearTeamShopNpc() : void
      {
         ModuleManager.removeEventListener("TeamEffectUpgrade","teamEffectStatusChange",this.onTeamEffectUpgrade);
         Connection.removeErrorHandler(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatusError);
         Connection.removeCommandListener(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatus);
      }
      
      private function initTeamEffectStatus() : void
      {
         Connection.addErrorHandler(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatusError);
         Connection.addCommandListener(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatus);
         Connection.send(CommandSet.TEAM_GET_UPGRADE_INFO_1135);
      }
      
      private function onGetTeamEffectStatus(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatusError);
         Connection.removeCommandListener(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatus);
         var _loc2_:Parser_1135 = new Parser_1135(param1.message.getRawData());
         TeamManager.teamEffectStatusArr = _loc2_.statusArr;
         TeamManager.teamCoins = _loc2_.coins;
         this.validateTeamShopNpcStatus();
      }
      
      private function onGetTeamEffectStatusError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatusError);
         Connection.removeCommandListener(CommandSet.TEAM_GET_UPGRADE_INFO_1135,this.onGetTeamEffectStatus);
         AlertManager.showAlert("你还没有权限获取战队信息");
      }
      
      private function onTeamBtnClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NewTeamMainPanel"),"加载战队创建面板");
      }
      
      private function onTeamNewsClick(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("NewTeamRankListPanel"),"加载战队新闻面板");
      }
      
      override public function dispose() : void
      {
         this.clearTeamShopNpc();
         this._btn0.removeEventListener(MouseEvent.CLICK,this.onTeamBtnClick);
         this._btn1.removeEventListener(MouseEvent.CLICK,this.onTeamNewsClick);
         super.dispose();
      }
   }
}
