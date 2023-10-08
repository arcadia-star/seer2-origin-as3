package com.taomee.seer2.app.processor.quest.handler.activity.quest30013
{
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_30013_330 extends QuestMapHandler
   {
       
      
      private var _npcDefinition:NpcDefinition;
      
      private var npc:MovieClip;
      
      public function QuestMapHandler_30013_330(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(_quest.id))
         {
            this.initNpc();
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this.npc)
         {
            this.npc.removeEventListener(MouseEvent.CLICK,this.showNpcDia);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
         super.processMapDispose();
      }
      
      private function initNpc() : void
      {
         this.npc = _processor.resLib.getMovieClip("npc");
         _map.content.addChild(this.npc);
         this.npc.buttonMode = true;
         this.npc.addEventListener(MouseEvent.CLICK,this.showNpcDia);
      }
      
      private function showNpcDia(param1:MouseEvent) : void
      {
         var _loc2_:XML = <npc id="438" resId="438" name="爆炸头" dir="1" width="25" height="90" pos="841,288" actorPos="821,288" path="">
					<dialog npcId="438" npcName="爆炸头" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[什么玩意嘛！俺不就随口说了句我是天下无敌嘛！用得着打的这么用力不]]></node>
							<reply action="close"><![CDATA[我一会再来问你]]></reply>
						</branch>				
					</dialog>
					<functionality>			
					</functionality>
				</npc>;
         var _loc3_:XML = <node type="quest" name="战斗传人" params="battlechuanren"/>;
         this._npcDefinition = new NpcDefinition(_loc2_);
         this._npcDefinition.addFunctionalityUnitAt(_loc3_,0);
         DialogPanel.showForNpc(this._npcDefinition);
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
      }
      
      private function onUnit(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if(event.content.params == "battlechuanren")
         {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onUnit);
            NpcDialog.show(438,"爆炸头",[[0,"啥？你问我它长的什么样子？我到觉得这家伙几分像伊特？但是比伊特又嚣张跋扈一点……"]],["难道是伊特兄弟？"],[function():void
            {
               var mc:* = undefined;
               mc = _processor.resLib.getMovieClip("CryMc");
               _map.front.addChild(mc);
               DisplayUtil.removeForParent(npc);
               MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(mc);
                  QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                  QuestManager.accept(_quest.id);
               });
            }]);
         }
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY,320);
         }
      }
   }
}
