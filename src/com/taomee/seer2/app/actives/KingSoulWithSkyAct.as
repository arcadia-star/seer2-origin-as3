package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.entity.definition.NpcDefinition;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   import org.taomee.utils.BitUtil;
   
   public class KingSoulWithSkyAct implements IActInstance
   {
      
      private static var _instance:KingSoulWithSkyAct;
       
      
      private const FIGHT_ID:uint = 586;
      
      private const RANDOM_INDEX:uint = 60;
      
      private const FIGHT_STATE_ID:uint = 816;
      
      private const WEEKEND_MAPS:Array = [124,850,291,203,204,360];
      
      private const WEEKEND_SEAT:Array = [[613,338],[373,200],[608,370],[695,340],[650,300],[305,290]];
      
      private const GENERAL_MAPS:Array = [124,850,291,203,204,360];
      
      private const GENERAL_SEAT:Array = [[613,338],[373,200],[608,370],[695,340],[650,300],[305,290]];
      
      private const YUESE_ID:uint = 624;
      
      private const ACT_RULE_PANEL:String = "KingSoulWithSkyRulePanel";
      
      private var isWeekEnd:Boolean;
      
      private var timeDate:Date;
      
      private var yueSeMobile:Mobile;
      
      private var mapIndex:int;
      
      private var hasGet:Boolean;
      
      public function KingSoulWithSkyAct()
      {
         this.timeDate = new Date();
         super();
      }
      
      public static function getInstance() : KingSoulWithSkyAct
      {
         if(!_instance)
         {
            _instance = new KingSoulWithSkyAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         this.getWeekState();
         this.initEvent();
      }
      
      private function initEvent() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwithComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,this.onStart);
      }
      
      private function onStart(param1:SceneEvent) : void
      {
         this.dispose();
      }
      
      private function onSwithComplete(param1:SceneEvent) : void
      {
         var _loc2_:uint = uint(SceneManager.active.mapID);
         this.mapIndex = this.isWeekEnd ? this.WEEKEND_MAPS.indexOf(_loc2_) : this.GENERAL_MAPS.indexOf(_loc2_);
         if(this.mapIndex < 0)
         {
            return;
         }
         this.timeDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         if(!this.isWeekEnd)
         {
            if(this.timeDate.hours >= 9 && this.timeDate.hours < 23)
            {
               Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
               Connection.send(CommandSet.RANDOM_EVENT_1140,this.RANDOM_INDEX,0);
            }
         }
         else if(this.timeDate.hours == 12 && this.timeDate.minutes >= this.mapIndex * 10 && this.timeDate.minutes < this.mapIndex * 10 + 10)
         {
            this.createYueSe();
         }
      }
      
      private function onRandomStatus(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.onRandomStatus);
         var _loc2_:IDataInput = param1.message.getRawDataCopy();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint;
         if((_loc4_ = uint(_loc2_.readUnsignedInt())) != 0)
         {
            this.createYueSe();
         }
      }
      
      private function createYueSe() : void
      {
         if(!this.yueSeMobile)
         {
            this.yueSeMobile = new Mobile();
            this.yueSeMobile.buttonMode = true;
         }
         if(!this.yueSeMobile.hasEventListener(MouseEvent.CLICK))
         {
            this.yueSeMobile.addEventListener(MouseEvent.CLICK,this.showDia);
         }
         this.yueSeMobile.resourceUrl = URLUtil.getNpcSwf(this.YUESE_ID);
         this.yueSeMobile.direction = 0;
         if(this.isWeekEnd)
         {
            this.yueSeMobile.x = this.WEEKEND_SEAT[this.mapIndex][0];
            this.yueSeMobile.y = this.WEEKEND_SEAT[this.mapIndex][1];
            DayLimitManager.getDoCount(this.FIGHT_STATE_ID,this.getState);
         }
         else
         {
            this.yueSeMobile.x = this.GENERAL_SEAT[this.mapIndex][0];
            this.yueSeMobile.y = this.GENERAL_SEAT[this.mapIndex][1];
            MobileManager.addMobile(this.yueSeMobile,MobileType.NPC);
         }
      }
      
      private function getState(param1:uint) : void
      {
         this.hasGet = BitUtil.getBit(param1,this.mapIndex);
         MobileManager.addMobile(this.yueSeMobile,MobileType.NPC);
      }
      
      private function showDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var npcNode:XML = <npc id="591" resId="591" name="约瑟" dir="0" width="25" height="90" pos="841,288" actorPos="821,288" path="">
					<dialog npcId="591" npcName="约瑟" transport="1,300,400">
						<branch id="default">
							<node emotion="0"><![CDATA[王之觉醒，我就是精灵王！]]></node>
							<reply action="close"><![CDATA[围观精灵王！]]></reply>
						</branch>
					</dialog>
					<functionality>					
					</functionality>
				</npc>;
         var _npcDefinition:NpcDefinition = new NpcDefinition(npcNode);
         _npcDefinition.addFunctionalityUnitAt(<node type="" name="挑战约瑟" params="fight_yuese"/>,0);
         _npcDefinition.addFunctionalityUnitAt(<node type="" name="活动规则" params="see_rule"/>,0);
         this.timeDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         if(this.timeDate.hours == 12 && this.timeDate.minutes >= this.mapIndex * 10 && this.timeDate.minutes < this.mapIndex * 10 + 10)
         {
            if(this.hasGet)
            {
               NpcDialog.show(591,"约瑟",[[0,"不错，后生可畏，你已经完成了挑战，我要走了。"]],["精灵王给力！"]);
            }
            else
            {
               DialogPanel.showForNpc(_npcDefinition);
               DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.toDia);
            }
         }
         else if(this.isWeekEnd)
         {
            NpcDialog.show(591,"约瑟",[[0,"时间已过我要去其它地方了"]],["精灵王给力！"],[function():void
            {
               MobileManager.removeMobile(yueSeMobile,MobileType.NPC);
            }]);
         }
         else
         {
            DialogPanel.showForNpc(_npcDefinition);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.toDia);
         }
      }
      
      private function toDia(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         var params:String = (event.content as DialogPanelEventData).params;
         if(params == "fight_yuese")
         {
            NpcDialog.show(591,"约瑟",[[0,"勇气！勇气是用来对战的！1000滴血的极限，你能达到我就给你一块羽翼图腾。"]],["开始战斗","准备一下"],[function():void
            {
               FightManager.startFightWithBoss(FIGHT_ID);
            }]);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule(this.ACT_RULE_PANEL));
         }
      }
      
      private function getWeekState() : void
      {
         this.timeDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
         this.isWeekEnd = this.timeDate.day < 1 || this.timeDate.day > 5 ? true : false;
      }
      
      public function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.toDia);
      }
   }
}
