package com.taomee.seer2.app.activity.processor.grassBlade
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.activity.data.ActivityPet;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ActivityMapHandler_101 extends GrassBladeMapHandler
   {
      
      private static const GUARD_ID:uint = 1;
      
      private static const OFFICER_ID:uint = 2;
      
      private static const TEAMLEADER_ID:uint = 3;
      
      private static var _fightIndex:uint = 0;
       
      
      private var _currentBossId:uint;
      
      private var _ufo:Sprite;
      
      private var _count:uint;
      
      private var _activityMonsterVec:Vector.<ActivityPet>;
      
      private var _teamLeaderDefinition:NpcDefinition;
      
      private var _teamLeaderNpc:Mobile;
      
      public function ActivityMapHandler_101(param1:ActivityProcessor)
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
         if(this._currentBossId == TEAMLEADER_ID)
         {
            ActiveCountManager.requestActiveCount(21,this.onGetActiveCount);
         }
         else
         {
            this.processActivityMonster(this._currentBossId);
         }
      }
      
      private function onGetActiveCount(param1:uint, param2:uint) : void
      {
         this._count = param2;
         if(param2 >= 3)
         {
            this._count = 0;
         }
         this.processsLayout();
         this.processNpc();
         if(this._count <= 3 && this._count > 0 && SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && _fightIndex == 1)
         {
            DialogPanel.addCloseEventListener(this.onTeamLeaderDialogClosed);
            DialogPanel.showForNpc(this._teamLeaderDefinition);
         }
         _fightIndex = 0;
      }
      
      private function processsLayout() : void
      {
         this._ufo = SceneManager.active.mapModel.libManager.getSprite("UFO");
         this._ufo.x = 781.7;
         this._ufo.y = 272.2;
         SceneManager.active.mapModel.ground.addChild(this._ufo);
      }
      
      private function processNpc() : void
      {
         this.processActivityMonster(OFFICER_ID);
         var _loc1_:XML = this.initNpcDefinition();
         this._teamLeaderDefinition = new NpcDefinition(_loc1_);
         this._teamLeaderNpc = MobileManager.createNpc(this._teamLeaderDefinition);
         this._teamLeaderNpc.buttonMode = true;
         this._teamLeaderNpc.addEventListener(MouseEvent.CLICK,this.onTeamLeaderClick);
      }
      
      private function initNpcDefinition() : XML
      {
         var _loc1_:XML = null;
         if(this._count == 1)
         {
            _loc1_ = new XML("<npc id=\"15\" resId=\"15\" name=\"巴卢特\" dir=\"1\" width=\"25\" height=\"150\" pos=\"680,360\" actorPos=\"670,400\" path=\"\">" + "<dialog npcId=\"15\" npcName=\"巴卢特\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[你以为自己很强了吗？，我的青蜂可不是这么容易对付的！]]></node>" + "<reply action=\"close\" params=\"" + TEAMLEADER_ID + "\"><![CDATA[谁怕谁啊]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[顺我者昌，逆我者亡！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else if(this._count == 2)
         {
            _loc1_ = new XML("<npc id=\"15\" resId=\"15\" name=\"巴卢特\" dir=\"1\" width=\"25\" height=\"150\" pos=\"680,360\" actorPos=\"670,400\" path=\"\">" + "<dialog npcId=\"15\" npcName=\"巴卢特\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[这不可能!]]></node>" + "<reply action=\"close\" params=\"" + TEAMLEADER_ID + "\"><![CDATA[我还没热身呢]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[顺我者昌，逆我者亡！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else if(this._count == 3)
         {
            _loc1_ = new XML("<npc id=\"15\" resId=\"15\" name=\"巴卢特\" dir=\"1\" width=\"25\" height=\"150\" pos=\"680,360\" actorPos=\"670,400\" path=\"\">" + "<dialog npcId=\"15\" npcName=\"巴卢特\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[这样软弱的精灵我不配跟随我！哼！]]></node>" + "<reply action=\"close\"  params=\"award\"><![CDATA[回收青蜂]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[顺我者昌，逆我者亡！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
         }
         else
         {
            _loc1_ = new XML("<npc id=\"15\" resId=\"15\" name=\"巴卢特\" dir=\"1\" width=\"25\" height=\"150\" pos=\"680,360\" actorPos=\"670,400\" path=\"\">" + "<dialog npcId=\"15\" npcName=\"巴卢特\" transport=\"1,300,400\">" + "<branch id=\"default\">" + "<node emotion=\"0\"><![CDATA[没有任何事物可以阻止我完成任务！你也一样！]]></node>" + "<reply action=\"close\" params=\"" + TEAMLEADER_ID + "\"><![CDATA[我一定会阻止你的！]]></reply>" + "<reply action=\"close\"><![CDATA[你等着，我马上回来！]]></reply>" + "</branch>" + "</dialog>" + "<eventHandler>" + "<mouseOver>" + "<HandlerShowNpcSlogan><![CDATA[顺我者昌，逆我者亡！]]></HandlerShowNpcSlogan>" + "</mouseOver>" + "</eventHandler>" + "</npc>");
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
         var _loc2_:String = param1.params;
         if(_loc2_ == TEAMLEADER_ID.toString())
         {
            _fightIndex = 1;
            FightManager.startFightWithActivityBoss(TEAMLEADER_ID);
         }
         else if(_loc2_ == "award")
         {
            this._count = 0;
            this.processNpc();
         }
      }
      
      private function processActivityMonster(param1:uint) : void
      {
         var _loc3_:ActivityPet = null;
         this.removeMapActivityMonster();
         this._activityMonsterVec = new Vector.<ActivityPet>();
         var _loc2_:uint = 0;
         while(_loc2_ < ACTIVITY_MONSTER_NUM)
         {
            _loc3_ = new ActivityPet(param1);
            this._activityMonsterVec.push(_loc3_);
            MobileManager.addMobile(_loc3_,MobileType.ACTIVITY_MONSTER);
            _loc2_++;
         }
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
            MobileManager.removeMobileById(this._activityMonsterVec[_loc1_].id,MobileType.ACTIVITY_MONSTER);
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
         if(this._ufo)
         {
            DisplayObjectUtil.removeFromParent(this._ufo);
            this._ufo = null;
         }
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
