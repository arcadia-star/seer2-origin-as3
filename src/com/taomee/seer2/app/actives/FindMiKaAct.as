package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.DayLimitManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1140;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class FindMiKaAct
   {
      
      private static var _instance:FindMiKaAct;
       
      
      private const RANDOM_EVENT:uint = 88;
      
      private const FIGHT_INDEX:uint = 938;
      
      private const DAYLIMIT_INDEX:uint = 1091;
      
      private const NPC_ID:uint = 749;
      
      private var _npc:Mobile;
      
      public function FindMiKaAct()
      {
         super();
      }
      
      public static function get instance() : FindMiKaAct
      {
         if(!_instance)
         {
            _instance = new FindMiKaAct();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(SceneManager.active.mapID == ActorManager.actorInfo.id)
         {
            return;
         }
         DayLimitManager.getDoCount(this.DAYLIMIT_INDEX,this.getLimit);
      }
      
      private function getLimit(param1:uint) : void
      {
         if(param1 < 10)
         {
            Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140,this.getResult);
            Connection.send(CommandSet.RANDOM_EVENT_1140,this.RANDOM_EVENT,0);
         }
      }
      
      private function getResult(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140,this.getResult);
         var _loc2_:Parser_1140 = new Parser_1140(param1.message.getRawData());
         var _loc3_:uint = _loc2_.id;
         if(_loc3_ == 1)
         {
            this.showPet();
         }
      }
      
      private function showPet() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
         }
         this._npc.width = 100;
         this._npc.height = 160;
         this._npc.setPostion(new Point(460,325));
         this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPC_ID);
         this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
         this._npc.label = "米卡";
         this._npc.labelImage.y = -this._npc.height - 10;
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpcClick);
      }
      
      public function dispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      protected function onNpcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(this.NPC_ID,"小丑米咔",[[0,"和我一起欢度愚人节吧！"]],[" 嗯嗯！ ","你的帽子真好看"],[function():void
         {
            FightManager.startFightWithWild(FIGHT_INDEX);
         }]);
      }
   }
}
