package com.taomee.seer2.app.activity.processor.waterRecapture
{
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ActivityMapHandler_171 extends WaterRecaptureMapHandler
   {
      
      private static const ACTIVITY_MONSTER_DEFINE:Array = [{
         "dir":1,
         "x":410,
         "y":220
      },{
         "dir":0,
         "x":563,
         "y":330
      },{
         "dir":0,
         "x":767,
         "y":160
      }];
      
      private static const GUARD_ID:uint = 4;
      
      private static const OFFICER_ID:uint = 5;
      
      private static const TEAMLEADER_ID:uint = 6;
       
      
      private var _currentBossId:uint;
      
      private var _protectShelter:MovieClip;
      
      private var _bubbles:MovieClip;
      
      private var _curTimes:uint = 0;
      
      private var _activityMonsterVec:Vector.<Mobile>;
      
      private var _teamLeaderDefinition:NpcDefinition;
      
      private var _teamLeaderNpc:Mobile;
      
      public function ActivityMapHandler_171(param1:ActivityProcessor)
      {
         super(param1);
      }
      
      override public function process() : void
      {
         super.process();
         if(_isTimeOut)
         {
            return;
         }
         var _loc1_:uint = this.getCurrentBossId();
         if(_loc1_ != 0 && this._currentBossId != _loc1_)
         {
            this._currentBossId = _loc1_;
            this.processsLayout();
            this.processMobile();
            this.showMapActivityAnimation();
         }
      }
      
      private function showMapActivityAnimation() : void
      {
         if(this._currentBossId == GUARD_ID)
         {
            this.showFirstPhaseAnimation();
         }
         else if(this._currentBossId == OFFICER_ID)
         {
            this.showSecondPhaseAnimation();
         }
         else if(this._currentBossId == TEAMLEADER_ID)
         {
            this.showThirdPhaseAnimation();
         }
      }
      
      private function showFirstPhaseAnimation() : void
      {
         var _loc1_:* = _activityProcessor.getActivityID() + "/1";
         playActivityAnimation(_loc1_);
      }
      
      private function showSecondPhaseAnimation() : void
      {
         var _loc1_:* = _activityProcessor.getActivityID() + "/2";
         playActivityAnimation(_loc1_);
      }
      
      private function showThirdPhaseAnimation() : void
      {
         var _loc1_:* = _activityProcessor.getActivityID() + "/3";
         playActivityAnimation(_loc1_);
      }
      
      private function processMobile() : void
      {
         if(this._currentBossId == GUARD_ID)
         {
            this.processPhase1Mobile();
         }
         else
         {
            this.processPhase23Mobile();
         }
      }
      
      private function processPhase1Mobile() : void
      {
         this.processActivityMonster(GUARD_ID);
      }
      
      private function processPhase23Mobile() : void
      {
         this.processActivityMonster(OFFICER_ID);
         Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
         Connection.addErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         Connection.send(CommandSet.ACTIVE_COUNT_1142,1,20);
      }
      
      private function onGetActiveCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         AlertManager.showAlert("获取信息失败");
         this.createTeamLeader();
      }
      
      private function onGetActiveCount(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,this.onGetActiveCountError);
         var _loc2_:Parser_1142 = new Parser_1142(param1.message.getRawData());
         this._curTimes = _loc2_.infoVec[0];
         if(this._curTimes == 3 && SceneManager.prevSceneType != SceneType.ARENA)
         {
            this._curTimes = 0;
         }
         this.createTeamLeader();
         if(this._curTimes <= 3 && this._curTimes > 0 && SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT)
         {
            DialogPanel.addCloseEventListener(this.onTeamLeaderDialogClosed);
            DialogPanel.showForNpc(this._teamLeaderDefinition);
         }
      }
      
      private function createTeamLeader() : void
      {
         var _loc1_:XML = this.initNpcDefinition();
         this._teamLeaderDefinition = new NpcDefinition(_loc1_);
         if(this._teamLeaderNpc)
         {
            MobileManager.removeMobileById(this._teamLeaderNpc.id,MobileType.NPC);
         }
         this._teamLeaderNpc = MobileManager.createNpc(this._teamLeaderDefinition);
         this._teamLeaderNpc.buttonMode = true;
         this._teamLeaderNpc.addEventListener(MouseEvent.CLICK,this.onTeamLeaderClick);
      }
      
      private function initNpcDefinition() : XML
      {
         var _loc1_:XML = null;
         if(this._currentBossId == OFFICER_ID)
         {
            _loc1_ = new XML("<npc id=\"39\" resId=\"39\" name=\"缇娜\" dir=\"0\" width=\"25\" height=\"160\" pos=\"630,280\" actorPos=\"650,320\" path=\"\">" + "<dialog npcId=\"40\" npcName=\"紫电士官\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[想和缇娜队长动手必须先过我这关！]]></node>" + "<reply action=\"close\" params=\"" + OFFICER_ID + "\"><![CDATA[要打便打！]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[一切都是徒劳！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else if(this._curTimes == 1)
         {
            _loc1_ = new XML("<npc id=\"39\" resId=\"39\" name=\"缇娜\" dir=\"0\" width=\"25\" height=\"160\" pos=\"630,280\" actorPos=\"650,320\" path=\"\">" + "<dialog npcId=\"39\" npcName=\"缇娜\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[你如果再厉害一点的话，或许我可以把紫电让给你哦！]]></node>" + "<reply action=\"close\" params=\"" + TEAMLEADER_ID + "\"><![CDATA[到底有什么阴谋]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[一切都是徒劳！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else if(this._curTimes == 2)
         {
            _loc1_ = new XML("<npc id=\"39\" resId=\"39\" name=\"缇娜\" dir=\"0\" width=\"25\" height=\"160\" pos=\"630,280\" actorPos=\"650,320\" path=\"\">" + "<dialog npcId=\"39\" npcName=\"缇娜\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[没想到你可以变得这么厉害，要不要我再多陪你玩玩？]]></node>" + "<reply action=\"close\" params=\"" + TEAMLEADER_ID + "\"><![CDATA[来吧]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[一切都是徒劳！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else if(this._curTimes == 3)
         {
            _loc1_ = new XML("<npc id=\"39\" resId=\"39\" name=\"缇娜\" dir=\"0\" width=\"25\" height=\"160\" pos=\"630,280\" actorPos=\"650,320\" path=\"\">" + "<dialog npcId=\"39\" npcName=\"缇娜\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[真是值得钦佩,我很久没有这么认真过了,紫电就归你了！]]></node>" + "<reply action=\"close\" params=\"award\"><![CDATA[那我就收下了！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[一切都是徒劳！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else
         {
            _loc1_ = new XML("<npc id=\"39\" resId=\"39\" name=\"缇娜\" dir=\"0\" width=\"25\" height=\"160\" pos=\"630,280\" actorPos=\"650,320\" path=\"\">" + "<dialog npcId=\"39\" npcName=\"缇娜\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[小家伙还不死心吗？我倒是可以陪你玩玩~]]></node>" + "<reply action=\"close\" params=\"" + TEAMLEADER_ID + "\"><![CDATA[谁怕谁呀！]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[一切都是徒劳！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         return _loc1_;
      }
      
      private function onTeamLeaderClick(param1:MouseEvent) : void
      {
         DialogPanel.addCloseEventListener(this.onTeamLeaderDialogClosed);
         DialogPanel.showForNpc(this._teamLeaderDefinition);
      }
      
      private function onTeamLeaderDialogClosed(param1:DialogCloseEvent) : void
      {
         var _loc3_:uint = 0;
         DialogPanel.removeCloseEventListener(this.onTeamLeaderDialogClosed);
         var _loc2_:String = param1.params;
         if(_loc2_ == TEAMLEADER_ID.toString() || _loc2_ == OFFICER_ID.toString())
         {
            _loc3_ = uint(_loc2_);
            this.startFight(_loc3_);
         }
         else if(_loc2_ == "award")
         {
            this._curTimes = 0;
            this.createTeamLeader();
         }
      }
      
      private function startFight(param1:uint) : void
      {
         FightManager.startFightWithActivityBoss(param1);
      }
      
      private function processsLayout() : void
      {
         if(this._bubbles == null)
         {
            this._bubbles = SceneManager.active.mapModel.content["waterRecaptureBubbles"];
            this._protectShelter = SceneManager.active.mapModel.content["protectShelter"];
         }
         this._bubbles.visible = true;
         if(this._currentBossId == GUARD_ID)
         {
            this._bubbles.visible = false;
         }
         else if(this._currentBossId == TEAMLEADER_ID)
         {
            this._protectShelter.visible = false;
         }
      }
      
      private function processActivityMonster(param1:uint) : void
      {
         var _loc3_:NpcDefinition = null;
         var _loc4_:Mobile = null;
         if(this._currentBossId == TEAMLEADER_ID && Boolean(this._activityMonsterVec))
         {
            return;
         }
         this.removeMapActivityMonster();
         this._activityMonsterVec = new Vector.<Mobile>();
         var _loc2_:uint = 0;
         while(_loc2_ < ACTIVITY_MONSTER_NUM)
         {
            _loc3_ = this.generateNpcDefinition(param1,_loc2_);
            (_loc4_ = MobileManager.createNpc(_loc3_)).action = "正面";
            if(_loc2_ == 1)
            {
               _loc4_.action = "背面";
            }
            _loc4_.buttonMode = true;
            _loc4_.addEventListener(MouseEvent.CLICK,this.onActivityMonsterClick);
            this._activityMonsterVec.push(_loc4_);
            _loc2_++;
         }
      }
      
      private function generateNpcDefinition(param1:uint, param2:uint) : NpcDefinition
      {
         var _loc3_:XML = null;
         if(param1 == GUARD_ID)
         {
            _loc3_ = new XML("<npc id=\"40\" resId=\"40\" name=\"紫电卫兵\" dir=\"0\" width=\"25\" height=\"90\" pos=\"670,280\" actorPos=\"650,320\" path=\"\">" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[缇娜队长会好好修理你们！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else
         {
            _loc3_ = new XML("<npc id=\"41\" resId=\"41\" name=\"紫电士官\" dir=\"0\" width=\"25\" height=\"90\" pos=\"670,280\" actorPos=\"650,320\" path=\"\">" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[缇娜队长会好好修理你们！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         var _loc4_:NpcDefinition;
         (_loc4_ = new NpcDefinition(_loc3_)).direction = ACTIVITY_MONSTER_DEFINE[param2].dir;
         _loc4_.x = ACTIVITY_MONSTER_DEFINE[param2].x;
         _loc4_.y = ACTIVITY_MONSTER_DEFINE[param2].y;
         return _loc4_;
      }
      
      private function onActivityMonsterClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = this._currentBossId;
         if(this._currentBossId == TEAMLEADER_ID)
         {
            _loc2_ = OFFICER_ID;
         }
         this.startFight(_loc2_);
      }
      
      private function removeMapActivityMonster() : void
      {
         if(this._activityMonsterVec == null)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._activityMonsterVec.length)
         {
            MobileManager.removeMobileById(this._activityMonsterVec[_loc1_].id,MobileType.NPC);
            (this._activityMonsterVec[_loc1_] as Mobile).removeEventListener(MouseEvent.CLICK,this.onActivityMonsterClick);
            this._activityMonsterVec[_loc1_] = null;
            _loc1_++;
         }
         this._activityMonsterVec = null;
      }
      
      private function removeMapNpc() : void
      {
         if(this._teamLeaderNpc)
         {
            MobileManager.removeMobileById(this._teamLeaderNpc.id,MobileType.NPC);
         }
         this._teamLeaderNpc = null;
         this._teamLeaderDefinition = null;
      }
      
      private function removeLayOut() : void
      {
         this._protectShelter = null;
         this._bubbles = null;
      }
      
      private function getCurrentBossId() : uint
      {
         var _loc1_:uint = uint(TimeManager.getServerTime());
         var _loc2_:Date = new Date(_loc1_ * 1000);
         var _loc3_:uint = uint(_loc2_.hours * 60 + _loc2_.minutes);
         if(_loc3_ < _currentTimeVec[1] && _loc3_ >= _currentTimeVec[0])
         {
            return GUARD_ID;
         }
         if(_loc3_ < _currentTimeVec[3] && _loc3_ >= _currentTimeVec[2])
         {
            return OFFICER_ID;
         }
         if(_loc3_ < _currentTimeVec[5] && _loc3_ >= _currentTimeVec[4])
         {
            return TEAMLEADER_ID;
         }
         return 0;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.removeMapActivityMonster();
         this.removeMapNpc();
         this.removeLayOut();
      }
   }
}
