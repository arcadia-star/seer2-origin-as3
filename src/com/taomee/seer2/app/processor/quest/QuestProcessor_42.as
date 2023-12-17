package com.taomee.seer2.app.processor.quest
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.dialog.events.FunctionalityBoxEvent;
   import com.taomee.seer2.app.dialog.functionality.CustomNewUnit;
   import com.taomee.seer2.app.processor.quest.handler.story.quest42.Panel42;
   import com.taomee.seer2.app.processor.quest.handler.story.quest42.Quest42NpcDialog;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.Quest;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import flash.events.MouseEvent;
   
   public class QuestProcessor_42 extends QuestProcessor
   {
       
      
      private const gotoMapList:Vector.<uint> = Vector.<uint>([110,160,192,470,320,540,660]);
      
      private const npcIdList:Vector.<uint> = Vector.<uint>([16,23,31,55,56,49,107]);
      
      private const mapNpcIdList:Vector.<uint> = Vector.<uint>([470,320,540,660]);
      
      private var _panel:Panel42;
      
      private var _npc:Mobile;
      
      private var _currNpc:Mobile;
      
      private var _npcDefinition:NpcDefinition;
      
      public function QuestProcessor_42(param1:Quest)
      {
         _isLoadResLib = true;
         super(param1);
         QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccept);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onMapComplete);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this.showPanel();
         }
      }
      
      private function onMapComplete(param1:SceneEvent) : void
      {
         if(QuestManager.isAccepted(42) && QuestManager.isStepComplete(42,1) == false && this.gotoMapList.indexOf(SceneManager.active.mapID) != -1)
         {
            if(this.gotoMapList.indexOf(SceneManager.active.mapID) > 2)
            {
               this.initNpc();
            }
            ServerBufferManager.getServerBuffer(ServerBufferType.QUEST_BUF_42,this.getServer,false);
         }
      }
      
      private function getServer(param1:ServerBuffer) : void
      {
         var _loc2_:uint = this.gotoMapList.indexOf(SceneManager.active.mapID);
         var _loc3_:int = param1.readDataAtPostion(_loc2_);
         if(_loc3_ != 1)
         {
            this.setNpc(this.npcIdList[_loc2_]);
            DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
         }
      }
      
      private function setNpc(param1:uint) : void
      {
         var _loc2_:AcceptableMark = null;
         this._currNpc = MobileManager.getMobile(param1,MobileType.NPC);
         if(this._currNpc)
         {
            this._currNpc.removeOverHeadMark();
            _loc2_ = new AcceptableMark();
            this._currNpc.addOverHeadMark(_loc2_);
         }
      }
      
      private function onDialogShow(param1:DialogPanelEvent) : void
      {
         var _loc3_:CustomNewUnit = null;
         var _loc2_:uint = this.gotoMapList.indexOf(SceneManager.active.mapID);
         if(_loc2_ > 100000)
         {
            return;
         }
         if(param1.content == this.npcIdList[_loc2_])
         {
            _loc3_ = new CustomNewUnit();
            _loc3_.setData(_quest.id);
            _loc3_.addEventListener(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,this.onUnitClick);
            DialogPanel.functionalityBox.addUnit(_loc3_);
         }
      }
      
      private function onUnitClick(param1:FunctionalityBoxEvent) : void
      {
         var _loc2_:uint = 0;
         if(_quest.id == param1.content)
         {
            DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW,this.onDialogShow);
            DialogPanel.functionalityBox.removeEventListener(FunctionalityBoxEvent.CUSTOM_UNIT_CLICK,this.onUnitClick);
            if(this._currNpc)
            {
               this._currNpc.removeOverHeadMark();
            }
            _loc2_ = this.gotoMapList.indexOf(SceneManager.active.mapID);
            Quest42NpcDialog.showDialog(this.npcIdList[_loc2_],resLib);
         }
      }
      
      private function showPanel() : void
      {
         if(this._panel)
         {
            this._panel.dispose();
         }
         this._panel = new Panel42(_resLib);
      }
      
      private function initNpc() : void
      {
         var _loc2_:XML = null;
         var _loc1_:uint = this.mapNpcIdList.indexOf(SceneManager.active.mapID);
         if(_loc1_ == -1)
         {
            return;
         }
         switch(_loc1_)
         {
            case 0:
               _loc2_ = <npc id="55" resId="55" name="" dir="0" width="25" height="90" pos="241,476" actorPos="439,433" path="">
											<dialog npcId="55" npcName="神月老大" transport="1,300,400">
												<branch id="default">
													<node emotion="0"><![CDATA[洒家要带领全族人用自己的双手发家致富！！]]></node>
													<reply action="close"><![CDATA[挖煤啊……]]></reply>
												</branch>
											</dialog>
										</npc>;
               break;
            case 1:
               _loc2_ = <npc id="56" resId="56" name="" dir="0" width="25" height="90" pos="647,343" actorPos="647,333" path="">
											<dialog npcId="56" npcName="神爪财团老板" transport="1,300,400">
												<branch id="default">
													<node emotion="0"><![CDATA[努力发展经济，就算时局已乱，还是要最优先保证民众的生活！]]></node>
													<reply action="close"><![CDATA[老板好……]]></reply>
												</branch>
											</dialog>
										</npc>;
               break;
            case 2:
               _loc2_ = <npc id="49" resId="49" name="" dir="0" width="25" height="90" pos="758,324" actorPos="758,314" path="">
											<dialog npcId="49" npcName="神沁酋长" transport="1,300,400">
												<branch id="default">
													<node emotion="0"><![CDATA[必须要让内心变得更加强大才行。]]></node>
													<reply action="close"><![CDATA[内心的强大啊……]]></reply>
												</branch>
											</dialog>
										</npc>;
               break;
            case 3:
               _loc2_ = <npc id="107" resId="107" name="" dir="0" width="25" height="90" pos="515,313" actorPos="635,293" path="">
											<dialog npcId="107" npcName="神翼总督" transport="1,300,400">
												<branch id="default">
													<node emotion="0"><![CDATA[自由与力量，都要依靠自己的双手。]]></node>
													<reply action="close"><![CDATA[嗯……]]></reply>
												</branch>
											</dialog>
										</npc>;
         }
         this._npcDefinition = new NpcDefinition(_loc2_);
         this._npc = MobileManager.createNpc(this._npcDefinition);
         this._npc.buttonMode = true;
         this._npc.addEventListener(MouseEvent.CLICK,this.onShowNpc);
      }
      
      private function onShowNpc(param1:MouseEvent) : void
      {
         DialogPanel.showForNpc(this._npcDefinition);
      }
      
      override public function dispose() : void
      {
         if(this._panel)
         {
            this._panel.dispose();
         }
         if(this._npc)
         {
            this._npc.dispose();
         }
         if(this._currNpc)
         {
            this._currNpc.removeOverHeadMark();
         }
         this._panel = null;
         this._npc = null;
         this._currNpc = null;
         super.dispose();
      }
   }
}
